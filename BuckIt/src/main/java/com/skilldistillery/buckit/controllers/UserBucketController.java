package com.skilldistillery.buckit.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.skilldistillery.buckit.dao.CategoryDAO;
import com.skilldistillery.buckit.dao.UserBucketItemDAO;
import com.skilldistillery.buckit.entities.BucketItem;
import com.skilldistillery.buckit.entities.Category;
import com.skilldistillery.buckit.entities.User;
import com.skilldistillery.buckit.entities.UserBucketItem;

@Controller
public class UserBucketController {

	@Autowired
	private UserBucketItemDAO userBucketItemDao;
	@Autowired
	private CategoryDAO categoryDao;

	@RequestMapping(path = "getUserBucket.do")
	public String getUserBucketList(Model model, HttpSession session) {
		List<UserBucketItem> allUserBucketItems = null;
		allUserBucketItems = userBucketItemDao.getAllUserBucketItemsForLoggedInUser((User)session.getAttribute("loggedInUser"));
		model.addAttribute("allUserBucketItems", allUserBucketItems);
		List<Category> allCategories = null;
		allCategories = categoryDao.getAllCategories();
		model.addAttribute("allCategories", allCategories);
		return "userBucketList";
	}
	
	@RequestMapping(path = "filterByCategoryUserBucket.do")
	public String filterUserBucketByCategory(Model model, int categoryId) {
		if (categoryId == -1) {
			return "redirect:getUserBucket.do";
		}
		Category categoryToFilterBy = categoryDao.findCategoryById(categoryId);
		List<UserBucketItem> filteredUserBucketItems = null;
		filteredUserBucketItems = userBucketItemDao.getUserBucketItemsWithCategory(categoryToFilterBy);
		model.addAttribute("allUserBucketItems", filteredUserBucketItems);
		List<Category> allCategories = null;
		allCategories = categoryDao.getAllCategories();
		model.addAttribute("allCategories", allCategories);
		return "userBucketList";
		
	}


}
