package com.skilldistillery.buckit.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.skilldistillery.buckit.dao.UserDAO;
import com.skilldistillery.buckit.entities.User;

@Controller
public class HomeController {

	@Autowired
	private UserDAO userDao;

	@RequestMapping(path = { "/", "home.do" })
	public String home(HttpSession session, Model model) {
		if (session.getAttribute("loggedInUser") != null) {
			return "redirect:getUserBucket.do";
		} else {
//			model.addAttribute("DEBUG", userDao.findById(1));
			return "home";
		}
	}

	@RequestMapping(path = "login.do", method = RequestMethod.GET)
	public String getLoginPage(HttpSession session, Model model) {
		if (session.getAttribute("loggedInUser") != null) {
			String result = "User is already logged in";
			model.addAttribute("loginResult", result);
			return "redirect:getUserBucket.do";
		} else {
			User user = new User();
			session.setAttribute("loggedInUser", user);
			return "login";
		}
	}

	@RequestMapping(path = "login.do", method = RequestMethod.POST)
	public String loginUser(String username, String password, HttpSession session, Model model) {
		if (session.getAttribute("loggedInUser") != null) {
			String result = "User is already logged in";
			System.out.println(result);
			model.addAttribute("loginResult", result);
			return "redirect:getUserBucket.do";
		} else {
			User userToLogin = null;
			userToLogin = userDao.findUserByUsernameAndPassword(username, password);
			if (userToLogin == null) {
				String result = "No user found with the supplied username and password";
				System.out.println(result);
				model.addAttribute("loginResult", result);
				return "home";
			} else if (userToLogin.getIsActive() == false) {
				String result = "User is not currently active";
				System.out.println(result);
				model.addAttribute("loginResult", result);
				return "home";
			} else {
				session.setAttribute("loggedInUser", userToLogin);
				String result = "Successfully Logged In";
				System.out.println(result);
				model.addAttribute("loginResult", result);
				return "redirect:getUserBucket.do";
			}
		}
	}

	@RequestMapping(path = "logout.do")
	public String logoutUser(HttpSession session) {
		session.removeAttribute("loggedInUser");
		return "home";
	}

	@RequestMapping(path = "navi.do")
	public String navigationBar(HttpSession session, Model model, String userSelect) {
		if (userSelect.equals("home")) {
			if (session.getAttribute("loggedInUser") != null) {
				return "redirect:getUserBucket.do";
			} else {
				return "home";
			}
		} else if (userSelect.equalsIgnoreCase("explore")) {
			return "redirect:exploreAll.do";
		} else if (userSelect.equalsIgnoreCase("userBucket")) {
			if (session.getAttribute("loggedInUser") != null) {
				return "redirect:getUserBucket.do";
			} else {
				String loginResult = "You must login to access your private bucket list";
				model.addAttribute("loginResult", loginResult);
				return "home";
			}
		} else if (userSelect.equalsIgnoreCase("settings")) {
			if (session.getAttribute("loggedInUser") != null) {
				return "redirect:settings.do";
			} else {
				return "home";
			}
		} else {
			return "home";
		}
	}
}
