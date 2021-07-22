package com.skilldistillery.buckit.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.skilldistillery.buckit.dao.BucketItemDAO;
import com.skilldistillery.buckit.dao.CommentDAO;
import com.skilldistillery.buckit.dao.PollDAO;
import com.skilldistillery.buckit.dao.UserBucketItemDAO;
import com.skilldistillery.buckit.dao.UserDAO;
import com.skilldistillery.buckit.entities.BucketItem;
import com.skilldistillery.buckit.entities.Poll;
import com.skilldistillery.buckit.entities.User;

@Controller
public class SettingsController {
	@Autowired
	private BucketItemDAO bucketItemDao;
	@Autowired
	private UserDAO userDao;
	@Autowired
	private CommentDAO commentDao;
	@Autowired
	private PollDAO pollDao;
	
	@RequestMapping(path = "settings.do", method = RequestMethod.GET)
	public String getUserSettings(Model model, HttpSession session, String returnToTab) {
		User user = null;
		user = userDao.findById(((User)session.getAttribute("loggedInUser")).getId());
		model.addAttribute("user", user);
		if (returnToTab != null && !returnToTab.equals("")) {
			model.addAttribute("returnToTab", returnToTab);
		}
		return "settings";
	}
	
	@RequestMapping(path = "updatedSettings.do", method = RequestMethod.POST)
	public String postUserSettings(Model model, HttpSession session, User user) {
		User userUpdate = null;
		userUpdate = userDao.updateUser(user);
		boolean result;
		System.out.println(userUpdate);
		if(userUpdate == null) {
			result = false;
			model.addAttribute("updateResult", result);
			return "settings";
		} else {
			// userUpdate = userDao.findById(((User)session.getAttribute("loggedInUser")).getId());
			// TODO update current HttpSession to reflect changes
			result = true;
			session.setAttribute("loggedInUser", userUpdate);
			model.addAttribute("updateResult", result);
			model.addAttribute("user", userUpdate);
			return "settings";
		}
	}
	
	@RequestMapping(path = "userDeleteCommentFromUser.do", method=RequestMethod.POST)
	public String userDeleteCommentReturnToItem(HttpSession session, Model model, int idToDelete, int userId) {
		if (((User) session.getAttribute("loggedInUser")) != null) {
			boolean commentDeleted;
			commentDeleted = commentDao.deleteComment(idToDelete);
			if(commentDeleted ) {
				model.addAttribute("commentResult", commentDeleted);
			}
			User user = null;
			user = userDao.findById(((User)session.getAttribute("loggedInUser")).getId());
			model.addAttribute("returnToTab", "comment");
			model.addAttribute("user", user);
			return "settings";
		}
		return "redirect:getUserBucket";
	}
	
	@RequestMapping(path = "userDeletePollFromUser.do", method=RequestMethod.POST)
	public String userDeletePollReturnToItem(HttpSession session, Model model, int idToDelete, int userId) {
		if (((User) session.getAttribute("loggedInUser")) != null) {
			Poll pollToDelete = pollDao.findById(idToDelete);
			boolean pollDeleted;
			pollDeleted = pollDao.deletePoll(pollToDelete);
			if(pollDeleted) {
				model.addAttribute("pollResult", pollDeleted);
			}
			
			User user = null;
			user = userDao.findById(((User)session.getAttribute("loggedInUser")).getId());
			model.addAttribute("returnToTab", "poll");
			model.addAttribute("user", user);
			return "settings";
		}
		return "redirect:getUserBucket";
	}
	
}
