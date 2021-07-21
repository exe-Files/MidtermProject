package com.skilldistillery.buckit.controllers;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.skilldistillery.buckit.dao.UserDAO;
import com.skilldistillery.buckit.entities.User;

@Controller
public class UserRegisterController {

	@Autowired
	private UserDAO userDao;
	
	@RequestMapping("register.do")
	public String gotoregistration(Model model) {
		return "register";
	}

	@RequestMapping(path = "registrationinfo.do", method = RequestMethod.POST)
	public ModelAndView registerUser(User user, Model model) {
		ModelAndView mv = new ModelAndView();	
		List<User> allUsers = userDao.getAllUsers();
		for (User user2 : allUsers) {
			if (user.getUsername().equals(user2.getUsername())) {
				mv.addObject("usernameTaken", "true");
				mv.setViewName("register");
				return mv;
			}
		}

		user.setActive(true);
		System.out.println("From controller: " + user.getIsActive());
		
		mv.addObject("user", userDao.createUser(user));
		
		mv.setViewName("redirect:home.do");		

		return mv;
	}

}
