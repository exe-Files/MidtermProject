package com.skilldistillery.buckit.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.skilldistillery.buckit.dao.BucketItemDAO;
import com.skilldistillery.buckit.dao.CategoryDAO;
import com.skilldistillery.buckit.dao.CommentDAO;
import com.skilldistillery.buckit.dao.PollDAO;
import com.skilldistillery.buckit.dao.UserBucketItemDAO;
import com.skilldistillery.buckit.dao.UserDAO;
import com.skilldistillery.buckit.entities.BucketItem;
import com.skilldistillery.buckit.entities.Category;
import com.skilldistillery.buckit.entities.Poll;
import com.skilldistillery.buckit.entities.User;

@Controller
public class AdminController {

	@Autowired
	private BucketItemDAO bucketItemDao;
	@Autowired
	private UserBucketItemDAO userBucketItemDao;
	@Autowired
	private UserDAO userDao;
	@Autowired
	private CommentDAO commentDao;
	@Autowired
	private PollDAO pollDao;
	@Autowired
	private CategoryDAO categoryDao;
	
	@RequestMapping(path = "addCategory")
	public ModelAndView addCategory(Category category, Model model) {
		ModelAndView mv = new ModelAndView();		
		mv.addObject("category", categoryDao.addCategory(category));
		mv.addObject("returnToTab", "sitewide");
//		ra.addAttribute("returnToTab", "sitewide");
		mv.setViewName("redirect:adminHome.do");		
//		return "redirect:adminHome.do";
		return mv;
	}
	
	@RequestMapping(path = "deleteCategory")
	public ModelAndView deleteCategory(Category category, Model model) {
		ModelAndView mv = new ModelAndView();		
		mv.addObject("category", categoryDao.deleteCategory(category.getId()));	
		mv.addObject("returnToTab", "sitewide");
		mv.setViewName("redirect:adminHome.do");		
		return mv;
	}
	

	@RequestMapping(path = "adminHome.do")
	public String goToAdminHomeView(HttpSession session, Model model, String returnToTab) {
		if (((User) session.getAttribute("loggedInUser")).getRole().equals("admin")) {
			List<User> allUsers = userDao.getAllUsers();
			model.addAttribute("allUsers", allUsers);
			List<BucketItem> allBucketItems = bucketItemDao.getAllBucketItems();
			model.addAttribute("allBucketItems", allBucketItems);
			List<Category> allCategories = categoryDao.getAllCategories();
			model.addAttribute("allCategories", allCategories);
			if (returnToTab != null && !returnToTab.equals("")) {
				model.addAttribute("returnToTab", returnToTab);
			}
			return "adminHome";
		}
		return "redirect:getUserBucket";
	}

	@RequestMapping(path = "adminEditUser.do", method = RequestMethod.GET)
	public String goToEditUser(HttpSession session, Model model, int adminUserToEdit) {
		if (((User) session.getAttribute("loggedInUser")).getRole().equals("admin")) {
			User userToEdit = userDao.findById(adminUserToEdit);
			model.addAttribute("user", userToEdit);
			return "adminEditUser";
		}
		return "redirect:getUserBucket";
	}

	@RequestMapping(path = "editUserDetails.do", method = RequestMethod.POST)
	public String adminEditUser(HttpSession session, Model model, User userFromForm, String isActive) {
		if (((User) session.getAttribute("loggedInUser")).getRole().equals("admin")) {
			if (isActive.equals("true")) {
				userFromForm.setActive(true);
			}
			User editedUser = userDao.updateUser(userFromForm);
			model.addAttribute("user", editedUser);
			return "redirect:adminHome.do";
		}
		return "redirect:getUserBucket";
	}

	@RequestMapping(path = "adminDeleteCommentFromUser.do", method = RequestMethod.POST)
	public String adminDeleteCommentReturnToUser(HttpSession session, Model model, int idToDelete, int userId) {
		if (((User) session.getAttribute("loggedInUser")).getRole().equals("admin")) {
			commentDao.deleteComment(idToDelete);
			User userToEdit = userDao.findById(userId);
			model.addAttribute("user", userToEdit);
			return "adminEditUser";
		}
		return "redirect:getUserBucket";
	}

	@RequestMapping(path = "adminDeletePollFromUser.do", method = RequestMethod.POST)
	public String adminDeletePollReturnToUser(HttpSession session, Model model, int idToDelete, int userId) {
		if (((User) session.getAttribute("loggedInUser")).getRole().equals("admin")) {
			Poll pollToDelete = pollDao.findById(idToDelete);
			pollDao.deletePoll(pollToDelete);
			User userToEdit = userDao.findById(userId);
			model.addAttribute("user", userToEdit);
			return "adminEditUser";
		}
		return "redirect:getUserBucket";
	}

	@RequestMapping(path = "adminEditItem.do", method = RequestMethod.GET)
	public String goToEditItem(HttpSession session, Model model, int adminItemToEdit) {
		if (((User) session.getAttribute("loggedInUser")).getRole().equals("admin")) {
			BucketItem itemToEdit = bucketItemDao.findBucketItemById(adminItemToEdit);
			model.addAttribute("item", itemToEdit);
			return "adminEditItem";
		}
		return "redirect:getUserBucket";
	}

	@RequestMapping(path = "editItemDetails.do", method = RequestMethod.POST)
	public String adminEditItem(HttpSession session, Model model, BucketItem bucketItemFromForm, String isActive,
			String isPublicAtCreation) {
		if (((User) session.getAttribute("loggedInUser")).getRole().equals("admin")) {
			if (isActive.equals("true")) {
				bucketItemFromForm.setIsActive(true);
			}
			if (isPublicAtCreation.equals("true")) {
				bucketItemFromForm.setIsPublicAtCreation(true);
			}
			BucketItem editedBucketItem = bucketItemDao.updateBucketItem(bucketItemFromForm);
			model.addAttribute("item", editedBucketItem);
			List<User> allUsers = userDao.getAllUsers();
			model.addAttribute("allUsers", allUsers);
			List<BucketItem> allBucketItems = bucketItemDao.getAllBucketItems();
			model.addAttribute("allBucketItems", allBucketItems);
			model.addAttribute("returnToTab", "item");
			return "adminHome";
		}
		return "redirect:getUserBucket";
	}

	@RequestMapping(path = "adminDeleteCommentFromItem.do", method = RequestMethod.POST)
	public String adminDeleteCommentReturnToItem(HttpSession session, Model model, int idToDelete, int itemId) {
		if (((User) session.getAttribute("loggedInUser")).getRole().equals("admin")) {
			commentDao.deleteComment(idToDelete);
			BucketItem itemToEdit = bucketItemDao.findBucketItemById(itemId);
			model.addAttribute("item", itemToEdit);
			return "adminEditItem";
		}
		return "redirect:getUserBucket";
	}

	@RequestMapping(path = "adminDeletePollFromItem.do", method = RequestMethod.POST)
	public String adminDeletePollReturnToItem(HttpSession session, Model model, int idToDelete, int itemId) {
		if (((User) session.getAttribute("loggedInUser")).getRole().equals("admin")) {
			Poll pollToDelete = pollDao.findById(idToDelete);
			pollDao.deletePoll(pollToDelete);
			BucketItem itemToEdit = bucketItemDao.findBucketItemById(itemId);
			model.addAttribute("item", itemToEdit);
			return "adminEditItem";
		}
		return "redirect:getUserBucket";
	}

	@RequestMapping(path = "adminFilterItemsByCreatedByUser", method = RequestMethod.GET)
	public String adminFilterItemsByUser(HttpSession session, Model model, Integer userId) {
		if (((User) session.getAttribute("loggedInUser")).getRole().equals("admin")) {
			List<User> allUsers = userDao.getAllUsers();
			model.addAttribute("allUsers", allUsers);
			if (userId == -1) {
				List<BucketItem> allBucketItems = bucketItemDao.getAllBucketItems();
				model.addAttribute("allBucketItems", allBucketItems);
			} else {
				User userToFilterBy = userDao.findById(userId);
				List<BucketItem> allBucketItems = bucketItemDao.getFilteredByUserBucketItems(userToFilterBy);
				model.addAttribute("allBucketItems", allBucketItems);
			}
			model.addAttribute("returnToTab", "item");
			return "adminHome";
		}
		return "redirect:getUserBucket";
	}

}
