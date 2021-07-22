package com.skilldistillery.buckit.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.skilldistillery.buckit.dao.BucketItemDAO;
import com.skilldistillery.buckit.dao.CategoryDAO;
import com.skilldistillery.buckit.dao.UserBucketItemDAO;
import com.skilldistillery.buckit.entities.BucketItem;
import com.skilldistillery.buckit.entities.Category;
import com.skilldistillery.buckit.entities.User;
import com.skilldistillery.buckit.entities.UserBucketItem;

@Controller
public class ExploreController {

	@Autowired
	private BucketItemDAO bucketItemDao;
	@Autowired
	private UserBucketItemDAO userBucketItemDao;
	@Autowired
	private CategoryDAO categoryDao;

	@RequestMapping(path = "exploreAll.do")
	public String exploreAllBucketItems(Model model, HttpSession session) {
		if (session.getAttribute("loggedInUser") != null) {
			User user = (User)session.getAttribute("loggedInUser");
			List<UserBucketItem> allUserBucketItems = null;
			allUserBucketItems = userBucketItemDao.getAllUserBucketItemsForLoggedInUser(user);
			model.addAttribute("allUserItems", allUserBucketItems);
		}
		List<BucketItem> allPublicBucketItems = null;
		allPublicBucketItems = bucketItemDao.getAllPublicBucketItems();
		model.addAttribute("allPublicBucketItems", allPublicBucketItems);
		List<Category> allCategories = null;
		allCategories = categoryDao.getAllCategories();
		model.addAttribute("allCategories", allCategories);
		return "exploreAll";
	}
	
	@RequestMapping(path = "viewDetailed.do")
	public String viewDetailedBucketItem(Model model, Integer bucketItemIdToView) {
		BucketItem itemToView = bucketItemDao.findBucketItemById(bucketItemIdToView);
		model.addAttribute("bucketItem", itemToView);
		model.addAttribute("avgStarRating", itemToView.getAverageStarRating());
		model.addAttribute("avgCostRating", itemToView.getAverageCostRating());
		model.addAttribute("bestTimeToDo", itemToView.getMostFrequentBestTime());
		// Check if bucketItem has a location or country associated and assign to map, if not assign world map
		String mapSearch = "";
		String iFrame = "";
		if (itemToView.getLocation() != null && !itemToView.getLocation().getCityArea().isEmpty() && !itemToView.getLocation().getCityArea().equals("")) {	
			mapSearch = itemToView.getLocation().getCityArea();
			iFrame = "https://www.google.com/maps/embed/v1/search?q=" + mapSearch + "&key=AIzaSyBf2VmxfBNxs1HkJpnNGHwYL36EM3V9R_U";
		} 
		
		else if (itemToView.getLocation() != null && itemToView.getLocation().getCountryCode() != null) {
			mapSearch = itemToView.getLocation().getCountryCode().getCountryName();
			iFrame = "https://www.google.com/maps/embed/v1/search?q=" + mapSearch + "&key=AIzaSyBf2VmxfBNxs1HkJpnNGHwYL36EM3V9R_U";
		}	
		else {
			iFrame = "https://www.google.com/maps/embed/v1/view?key=AIzaSyBf2VmxfBNxs1HkJpnNGHwYL36EM3V9R_U&center=0,0&zoom=1";
		}
		model.addAttribute("map", iFrame);
		
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
	
	@RequestMapping(path = "filterByCategory.do")
	public String filterExploreAllByCategory(Model model, int categoryId) {
		if (categoryId == -1) {
			return "redirect:exploreAll.do";
		}
		Category categoryToFilterBy = categoryDao.findCategoryById(categoryId);
		List<BucketItem> filteredPublicBucketItems = null;
		filteredPublicBucketItems = bucketItemDao.getAllBucketItemsWithCategory(categoryToFilterBy);
		model.addAttribute("allPublicBucketItems", filteredPublicBucketItems);
		List<Category> allCategories = null;
		allCategories = categoryDao.getAllCategories();
		model.addAttribute("allCategories", allCategories);
		return "exploreAll";
		
	}


}
