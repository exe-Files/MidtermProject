package com.skilldistillery.buckit.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.skilldistillery.buckit.dao.UserBucketItemDAO;
import com.skilldistillery.buckit.entities.UserBucketItem;

@Controller
public class UserBucketItemController {
	
	@Autowired
	private UserBucketItemDAO daoUBI;
	
	@RequestMapping(path="editUserBucketItem.do", method=RequestMethod.GET)
	public String editUserBucketItemForm(int id, Model model) {
		model.addAttribute("userBucketItem", daoUBI.findByID(id));
		return "editUserBucketItemForm";
	}
	
	@RequestMapping(path="updateUserBucketItem.do", method=RequestMethod.POST)
	public String updateUserBucketItem(UserBucketItem userBucketItem, Model model) {
		model.addAttribute("userBucketItem", daoUBI.updateBucketItem(userBucketItem));
		return "userBucketListItem";
	}
	
	@RequestMapping(path="deleteUserBucketItem.do", method=RequestMethod.POST)
	public String deleteUserBucketItem(int id, Model model) {
		boolean deleted = daoUBI.deleteBucketItem(id);
		if(deleted) {
			return "success";
		}
		return "fail";
	}
	
	@RequestMapping(path="viewUserBucketItem.do", method=RequestMethod.GET)
	public String viewUserBucketItemDetails(int id, Model model) {
		model.addAttribute("userBucketItem", daoUBI.findByID(id));
		model.addAttribute("bucketItem", daoUBI.getBucketItemFromUserBucketItem(daoUBI.findByID(id)));
		return "userBucketListItem";
	}
}
