package com.skilldistillery.buckit.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.skilldistillery.buckit.dao.UserBucketItemDAO;
import com.skilldistillery.buckit.entities.User;
import com.skilldistillery.buckit.entities.UserBucketItem;

@Controller
public class UserBucketController {

	@Autowired
	private UserBucketItemDAO userBucketItemDao;

	@RequestMapping(path = "getUserBucket.do")
	public String getUserBucketList(Model model, HttpSession session) {
		List<UserBucketItem> allUserBucketItems = null;
		allUserBucketItems = userBucketItemDao.getAllUserBucketItemsForLoggedInUser((User)session.getAttribute("loggedInUser"));
		model.addAttribute("allUserBucketItems", allUserBucketItems);
		return "userBucketList";
	}


}
