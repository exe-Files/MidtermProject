package com.skilldistillery.buckit.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.skilldistillery.buckit.dao.BucketItemDAO;
import com.skilldistillery.buckit.dao.CategoryDAO;
import com.skilldistillery.buckit.dao.CountryDAO;
import com.skilldistillery.buckit.dao.LocationDAO;
import com.skilldistillery.buckit.dao.UserBucketItemDAO;
import com.skilldistillery.buckit.dao.UserDAO;
import com.skilldistillery.buckit.entities.BucketItem;
import com.skilldistillery.buckit.entities.Category;
import com.skilldistillery.buckit.entities.Country;
import com.skilldistillery.buckit.entities.Location;
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
	private LocationDAO locationDao;

	@Autowired
	private CountryDAO countryDao;

	@Autowired
	private CategoryDAO categoryDao;

	@RequestMapping("newbucketitem.do")
	public String gotoMakeNewBucketItem(Model model) {
		List<Country> countryList = countryDao.getAllCountries();
		model.addAttribute("countries", countryList);
		List<Category> categoryList = categoryDao.getAllCategories();
		model.addAttribute("categories", categoryList);

		return "newBucketItem";
	}

	@RequestMapping(path = "newbucketinfo.do", method = RequestMethod.POST)
	public ModelAndView createNewBucketItem(BucketItem item, @RequestParam(name = "countryId") String country,
			@RequestParam(name = "categoryId") Integer catId, Location location, HttpSession session,
			RedirectAttributes ra) {
		ModelAndView mv = new ModelAndView();
		User user = (User) session.getAttribute("loggedInUser");
		UserBucketItem userItem = new UserBucketItem();

		if (location.getCityArea() != null && location.getCityArea() != "" || country.length() == 3) {
			location = locationDao.createLocation(location);
		}

		if (country.length() == 3) {
			Country newCountry = countryDao.findByCountryCode(country);
			location.setCountryCode(newCountry);
		}
		
		if (catId > 0) {
			item.addCategory(categoryDao.findCategoryById(catId));		
		}
		
		if (location.getId() != 0) {
			item.setLocation(location);			
		}

		item.setCreatedByUser(user);
		item = bucketDao.createBucketItem(item);

		userItem.setBucketItem(item);
		userItem.setUser(user);

		UserBucketItem newUserItem = userBucketDao.createBucketItem(userItem);

		ra.addAttribute("itemId", newUserItem.getId());
		mv.addObject("addSuccessful", "Successfully added new item to your bucket!");
		mv.setViewName("redirect:viewUserBucketItem.do");

		return mv;
	}

}
