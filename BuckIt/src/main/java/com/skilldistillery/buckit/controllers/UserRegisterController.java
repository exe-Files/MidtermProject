package com.skilldistillery.buckit.controllers;


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
	public ModelAndView registerUser(User user) {
		ModelAndView mv = new ModelAndView();	
		
//		TODO validate username is unique, else redirect
		mv.addObject("user", userDao.createUser(user));
		
		mv.setViewName("user-added");		

		return mv;
	}

}
