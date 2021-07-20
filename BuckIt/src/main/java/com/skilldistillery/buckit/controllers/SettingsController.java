package com.skilldistillery.buckit.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.skilldistillery.buckit.dao.UserDAO;
import com.skilldistillery.buckit.entities.User;
import com.skilldistillery.buckit.entities.UserBucketItem;

@Controller
public class SettingsController {

	@Autowired
	private UserDAO userDao;
	
	@RequestMapping(path = "settings.do", method = RequestMethod.GET)
	public String getUserSettings(Model model, HttpSession session) {
		User user = null;
		user = userDao.findById(((User)session.getAttribute("loggedInUser")).getId());
		model.addAttribute("user", user);
		return "settings";
	}
	
	@RequestMapping(path = "updatedSettings.do", method = RequestMethod.POST)
	public String postUserSettings(Model model, HttpSession session, User user) {
		User userUpdate = null;
		userUpdate = userDao.updateUser(user);
		boolean result;
		System.out.println(userUpdate);
		if(userUpdate == null) {
			result = false;
			model.addAttribute("updateResult", result);
			return "settings";
		} else {
			// userUpdate = userDao.findById(((User)session.getAttribute("loggedInUser")).getId());
			// TODO update current HttpSession to reflect changes
			result = true;
			session.setAttribute("loggedInUser", userUpdate);
			model.addAttribute("updateResult", result);
			return "settings";
		}
	}
	
}