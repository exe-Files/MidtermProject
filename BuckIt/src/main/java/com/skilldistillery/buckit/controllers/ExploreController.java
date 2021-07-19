package com.skilldistillery.buckit.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.skilldistillery.buckit.dao.BucketItemDAO;
import com.skilldistillery.buckit.dao.UserBucketItemDAO;
import com.skilldistillery.buckit.entities.BucketItem;
import com.skilldistillery.buckit.entities.User;
import com.skilldistillery.buckit.entities.UserBucketItem;

@Controller
public class ExploreController {

	@Autowired
	private BucketItemDAO bucketItemDao;
	@Autowired
	private UserBucketItemDAO userBucketItemDao;

	@RequestMapping(path = "exploreAll.do")
	public String exploreAllBucketItems(Model model) {
		List<BucketItem> allPublicBucketItems = null;
		allPublicBucketItems = bucketItemDao.getAllPublicBucketItems();
		model.addAttribute("allPublicBucketItems", allPublicBucketItems);
		return "exploreAll";
	}
	
	@RequestMapping(path = "viewDetailed.do")
	public String viewDetailedBucketItem(Model model, Integer bucketItemIdToView) {
		BucketItem itemToView = bucketItemDao.findBucketItemById(bucketItemIdToView);
		model.addAttribute("bucketItem", itemToView);
		return "bucketListItem";
	}
	
	@RequestMapping(path= "addUserBucketItem.do")
	public String addPublicItemToUserBucket(Model model, Integer bucketItemIdToAdd, HttpSession session) {
		BucketItem itemToAdd = bucketItemDao.findBucketItemById(bucketItemIdToAdd);
		User user = (User)session.getAttribute("loggedInUser");
		UserBucketItem userBucketItem = new UserBucketItem();
		userBucketItem.setBucketItem(itemToAdd);
		userBucketItem.setUser(user);
		UserBucketItem itemAdded = userBucketItemDao.addPublicBucketItemToUserBucket(userBucketItem);
		return "redirect:getUserBucket.do";
	}


}
