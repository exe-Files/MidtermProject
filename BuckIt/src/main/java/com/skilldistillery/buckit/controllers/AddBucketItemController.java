package com.skilldistillery.buckit.controllers;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.skilldistillery.buckit.dao.BucketItemDAO;
import com.skilldistillery.buckit.dao.UserBucketItemDAO;
import com.skilldistillery.buckit.dao.UserDAO;
import com.skilldistillery.buckit.entities.BucketItem;
import com.skilldistillery.buckit.entities.Note;
import com.skilldistillery.buckit.entities.Poll;
import com.skilldistillery.buckit.entities.Resource;
import com.skilldistillery.buckit.entities.User;
import com.skilldistillery.buckit.entities.UserBucketItem;

@Controller
public class AddBucketItemController {

	@Autowired
	private BucketItemDAO bucketDao;
	
	@Autowired
	private UserBucketItemDAO userBucketDao;

	@Autowired
	private UserDAO userDao;
	
	@RequestMapping("newbucketitem.do")
	public String gotoMakeNewBucketItem(Model model) {	
		return "newBucketItem";
	}

	@RequestMapping(path = "newbucketinfo.do", method = RequestMethod.POST)
	public ModelAndView createNewBucketItem(BucketItem item, HttpSession session) {
		ModelAndView mv = new ModelAndView();	
//		User user = (User) session.getAttribute("loggedInUser");
		UserBucketItem userItem = new UserBucketItem();
		
		// Used to hard code user ID to test DAOs
		User user = userDao.findById(3);		
		
		item.setCreatedByUser(user);
		
		mv.addObject("item", bucketDao.createBucketItem(item));
		
		System.out.println("User for bucket item: " + item.getCreatedByUser());
		
		userItem.setBucketItem(item);
		userItem.setUser(user);
		
		System.out.println("User for user bucket item: " + userItem.getUser());
		
		mv.addObject("userItem", userBucketDao.createBucketItem(userItem));
		
		mv.setViewName("new-item-added");		

		return mv;
	}

}
