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
	public String home(Model model) {
		model.addAttribute("DEBUG", userDao.findById(1));
		return "home";
	}

	@RequestMapping(path = "login.do", method = RequestMethod.GET)
	public String getLoginPage(HttpSession session, Model model) {
		if (session.getAttribute("loggedInUser") != null) {
			String result = "User is already logged in";
			model.addAttribute("loginResult", result);
			return "userBucketView";
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
			model.addAttribute("loginResult", result);
			return "userBucketView";
		} else {
			User userToLogin = null;
			userToLogin = userDao.findUserByUsernameAndPassword(username, password);
			if (userToLogin == null) {
				String result = "No user found with the supplied username and password";
				model.addAttribute("loginResult", result);
				return "login";
			} else {
				session.setAttribute("loggedInUser", userToLogin);
				String result = "Successfully Logged In";
				model.addAttribute("loginResult", result);
				return "userBucketView";
			}
		}
	}

	@RequestMapping(path = "navi.do")
	public String navigationBar(HttpSession session, Model model, String userSelect) {
		if (userSelect.equals("home")) {
			return "home";
		} else if (userSelect.equalsIgnoreCase("explore")) {
			return "explore";
		} else if (userSelect.equalsIgnoreCase("userBucket")) {
			if (session.getAttribute("loggedInUser") != null) {
				return "userBucketView";
			} else {
				String result = "You must login to access your private bucket list";
				return "home";
			}
		} else if (userSelect.equalsIgnoreCase("settings")) {
			return "settings";
		} else {
			return "home";
		}
	}

	@RequestMapping(path = "explore.do")
	public String explorePage(HttpSession session, Model model) {
		return "explore";
	}

	@RequestMapping(path = "userBucket.do")
	public String userBucketList(HttpSession session) {
		session.removeAttribute("loggedInUser");
		return "userBucket";
	}

	@RequestMapping(path = "logout.do")
	public String logoutUser(HttpSession session) {
		session.removeAttribute("loggedInUser");
		return "home";
	}

	@RequestMapping(path = "settings.do")
	public String settings(HttpSession session) {
		session.removeAttribute("loggedInUser");
		return "settings";
	}

}
