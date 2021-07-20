package com.skilldistillery.buckit.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.skilldistillery.buckit.dao.BucketItemDAO;
import com.skilldistillery.buckit.dao.CommentDAO;
import com.skilldistillery.buckit.dao.PollDAO;
import com.skilldistillery.buckit.entities.BucketItem;
import com.skilldistillery.buckit.entities.Comment;
import com.skilldistillery.buckit.entities.Poll;
import com.skilldistillery.buckit.entities.User;

@Controller
public class BucketItemController {
	
	@Autowired
	private BucketItemDAO bucketItemDao;
	@Autowired
	private CommentDAO commentDao;
	@Autowired
	private PollDAO pollDao;
	
//	@RequestMapping(path="editUserBucketItem.do", method=RequestMethod.GET)
//	public String editUserBucketItemForm(Integer id, Model model) {
//		model.addAttribute("userBucketItem", daoUBI.findByID(id));
//		return "editUserBucketItemForm";
//	}
	
	@RequestMapping(path="addComment.do", method=RequestMethod.GET)
	public String addCommentToBucketItem(String commentText, Integer bucketItemId, Model model, HttpSession session, RedirectAttributes ra) {
		User user = (User)session.getAttribute("loggedInUser");
		BucketItem bucketItem = bucketItemDao.findBucketItemById(bucketItemId);
		Comment comment = new Comment();
		comment.setBucketItem(bucketItem);
		comment.setUser(user);
		comment.setCommentText(commentText);
		commentDao.addComment(comment);
		ra.addAttribute("bucketItemIdToView", bucketItemId);
		return "redirect:viewDetailed.do";
	}
	
	@RequestMapping(path="addPole.do", method=RequestMethod.GET)
	public String addPoleToBucketItem(Poll poll, Integer bucketItemId, Model model, HttpSession session, RedirectAttributes ra) {
		User user = (User)session.getAttribute("loggedInUser");
		BucketItem bucketItem = bucketItemDao.findBucketItemById(bucketItemId);
		poll.setUser(user);
		poll.setBucketItem(bucketItem);
		pollDao.createPoll(poll);
		ra.addAttribute("bucketItemIdToView", bucketItemId);
		return "redirect:viewDetailed.do";
		
	}
	
}
