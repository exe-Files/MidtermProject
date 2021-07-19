package com.skilldistillery.buckit.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.skilldistillery.buckit.dao.BucketItemDAO;
import com.skilldistillery.buckit.dao.CommentDAO;
import com.skilldistillery.buckit.dao.UserBucketItemDAO;
import com.skilldistillery.buckit.dao.UserDAO;
import com.skilldistillery.buckit.entities.BucketItem;
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

	@RequestMapping(path = "adminHome.do")
	public String goToAdminHomeView(HttpSession session, Model model) {
		if (((User) session.getAttribute("loggedInUser")).getRole().equals("admin")) {
			List<User> allUsers = userDao.getAllUsers();
			model.addAttribute("allUsers", allUsers);
			List<BucketItem> allBucketItems = bucketItemDao.getAllBucketItems();
			model.addAttribute("allBucketItems", allBucketItems);
			return "adminHome";
		}
		return "redirect:getUserBucket";
	}
	
	@RequestMapping(path = "adminEditUser.do", method=RequestMethod.GET)
	public String goToEditUser(HttpSession session, Model model, int adminUserToEdit) {
		if (((User) session.getAttribute("loggedInUser")).getRole().equals("admin")) {
			User userToEdit = userDao.findById(adminUserToEdit);
			model.addAttribute("user", userToEdit);
			return "adminEditUser";
		}
		return "redirect:getUserBucket";
	}
	
	@RequestMapping(path = "editUserDetails.do", method=RequestMethod.POST)
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
	
	@RequestMapping(path = "adminDeleteComment.do", method=RequestMethod.POST)
	public String adminDeleteComment(HttpSession session, Model model, int idToDelete, int userId) {
		if (((User) session.getAttribute("loggedInUser")).getRole().equals("admin")) {
			commentDao.deleteComment(idToDelete);
			User userToEdit = userDao.findById(userId);
			model.addAttribute("user", userToEdit);
			return "adminEditUser";
		}
		return "redirect:getUserBucket";
	}

}
