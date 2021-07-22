package com.skilldistillery.buckit.controllers;

import java.time.LocalDate;

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
import com.skilldistillery.buckit.dao.UserBucketItemDAO;
import com.skilldistillery.buckit.entities.BucketItem;
import com.skilldistillery.buckit.entities.Comment;
import com.skilldistillery.buckit.entities.Note;
import com.skilldistillery.buckit.entities.Poll;
import com.skilldistillery.buckit.entities.Resource;
import com.skilldistillery.buckit.entities.User;
import com.skilldistillery.buckit.entities.UserBucketItem;

@Controller
public class UserBucketItemController {

	@Autowired
	private UserBucketItemDAO daoUBI;
	@Autowired
	private BucketItemDAO bucketItemDao;
	@Autowired
	private CommentDAO commentDao;
	@Autowired
	private PollDAO pollDao;

	@RequestMapping(path = "editUserBucketItem.do", method = RequestMethod.GET)
	public String editUserBucketItemForm(Integer id, Model model) {
		model.addAttribute("userBucketItem", daoUBI.findByID(id));
		return "editUserBucketItemForm";
	}

	@RequestMapping(path = "updateUserBucketItem.do", method = RequestMethod.POST)
	public String updateUserBucketItem(Integer id, String dateCompleted, String targetDate, String isCompleted,
			Model model) {
		UserBucketItem userBucketItem = daoUBI.findByID(id);
		System.out.println(userBucketItem);
		if (!dateCompleted.equals("")) {
			LocalDate dateComplete = LocalDate.parse(dateCompleted);
//			DateTimeFormatter.ISO_LOCAL_DATE.format(LocalDate.parse(targetDate));
			userBucketItem.setDateCompleted(dateComplete);
			userBucketItem.setCompleted(true);
		} else {
			userBucketItem.setCompleted(false);
		}
		
		if (!targetDate.equals("")) {
			LocalDate dateTargeted = LocalDate.parse(targetDate);
//			DateTimeFormatter.ISO_LOCAL_DATE.format(LocalDate.parse(targetDate));
			userBucketItem.setTargetDate(dateTargeted);
		}
		
		System.out.println(userBucketItem);

		daoUBI.updateBucketItem(userBucketItem);
		model.addAttribute("editSuccessful", "Successfully updated item in your bucket!");
		model.addAttribute("userBucketItem", userBucketItem);
		model.addAttribute("avgStarRating", userBucketItem.getBucketItem().getAverageStarRating());
		model.addAttribute("avgCostRating", userBucketItem.getBucketItem().getAverageCostRating());
		model.addAttribute("bestTimeToDo", userBucketItem.getBucketItem().getMostFrequentBestTime());
		
		// Check if bucketItem has a location or country associated and assign to map, if not assign world map
		String mapSearch = "";
		String iFrame = "";
		if (userBucketItem.getBucketItem().getLocation() != null && !userBucketItem.getBucketItem().getLocation().getCityArea().isEmpty() && !userBucketItem.getBucketItem().getLocation().getCityArea().equals("")) {	
			mapSearch = userBucketItem.getBucketItem().getLocation().getCityArea();
			iFrame = "https://www.google.com/maps/embed/v1/search?q=" + mapSearch + "&key=AIzaSyBf2VmxfBNxs1HkJpnNGHwYL36EM3V9R_U";
		} 
		
		else if (userBucketItem.getBucketItem().getLocation() != null && userBucketItem.getBucketItem().getLocation().getCountryCode() != null) {
			mapSearch = userBucketItem.getBucketItem().getLocation().getCountryCode().getCountryName();
			iFrame = "https://www.google.com/maps/embed/v1/search?q=" + mapSearch + "&key=AIzaSyBf2VmxfBNxs1HkJpnNGHwYL36EM3V9R_U";
		}	
		else {
			iFrame = "https://www.google.com/maps/embed/v1/view?key=AIzaSyBf2VmxfBNxs1HkJpnNGHwYL36EM3V9R_U&center=0,0&zoom=1";
		}
		model.addAttribute("map", iFrame);

//		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM-DD-YYYY");
//		LocalDate completedDate = LocalDate.parse(dateCompleted, formatter);
//		System.out.println(completedDate);
		return "userBucketListItem";
	}

	@RequestMapping(path = "deleteUserBucketItem.do", method = RequestMethod.POST)
	public String deleteUserBucketItem(Integer id, Model model) {
		boolean deleted = daoUBI.deleteBucketItem(id);
		if (deleted) {
//			return "success";
		}
//		return "fail";
		return "redirect:getUserBucket.do";
	}

	
	@RequestMapping(path="viewUserBucketItem.do", method=RequestMethod.GET)
	public String viewUserBucketItemDetails(Integer itemId, Model model, String addSuccessful) {
		UserBucketItem userBucketItem = daoUBI.findByID(itemId);
		model.addAttribute("userBucketItem", userBucketItem);
		model.addAttribute("avgStarRating", userBucketItem.getBucketItem().getAverageStarRating());
		model.addAttribute("avgCostRating", userBucketItem.getBucketItem().getAverageCostRating());
		model.addAttribute("bestTimeToDo", userBucketItem.getBucketItem().getMostFrequentBestTime());
		// Check if bucketItem has a location or country associated and assign to map, if not assign world map
				String mapSearch = "";
				String iFrame = "";
				if (userBucketItem.getBucketItem().getLocation() != null && !userBucketItem.getBucketItem().getLocation().getCityArea().isEmpty() && !userBucketItem.getBucketItem().getLocation().getCityArea().equals("")) {	
					mapSearch = userBucketItem.getBucketItem().getLocation().getCityArea();
					iFrame = "https://www.google.com/maps/embed/v1/search?q=" + mapSearch + "&key=AIzaSyBf2VmxfBNxs1HkJpnNGHwYL36EM3V9R_U";
				} 
				
				else if (userBucketItem.getBucketItem().getLocation() != null && userBucketItem.getBucketItem().getLocation().getCountryCode() != null) {
					mapSearch = userBucketItem.getBucketItem().getLocation().getCountryCode().getCountryName();
					iFrame = "https://www.google.com/maps/embed/v1/search?q=" + mapSearch + "&key=AIzaSyBf2VmxfBNxs1HkJpnNGHwYL36EM3V9R_U";
				}	
				else {
					iFrame = "https://www.google.com/maps/embed/v1/view?key=AIzaSyBf2VmxfBNxs1HkJpnNGHwYL36EM3V9R_U&center=0,0&zoom=1";
				}
				model.addAttribute("map", iFrame);
		if (addSuccessful != null && !addSuccessful.equals("")) {
			model.addAttribute("addSuccessful", addSuccessful);
		}
		return "userBucketListItem";
	}

	@RequestMapping(path = "deleteNote.do", method = RequestMethod.POST)
	public String deleteNote(int bucketItemId, int noteId, Model model) {
		UserBucketItem userBucketItem = daoUBI.removeNoteFromUserBucketItem(bucketItemId, noteId);
		model.addAttribute("userBucketItem", userBucketItem);
		return "editUserBucketItemForm";
	}

	@RequestMapping(path = "deleteResource.do", method = RequestMethod.POST)
	public String deleteResource(int bucketItemId, int resourceId, Model model) {
		UserBucketItem userBucketItem = daoUBI.removeResourceFromUserBucketItem(bucketItemId, resourceId);
		model.addAttribute("userBucketItem", userBucketItem);
		return "editUserBucketItemForm";
	}

	@RequestMapping(path = "addNote.do", method = RequestMethod.POST)
	public String addNote(Integer bucketItemId, Note note, Model model) {
		UserBucketItem userBucketItem = daoUBI.addNoteToUserBucketItem(bucketItemId, note);
		model.addAttribute("userBucketItem", userBucketItem);
		model.addAttribute("avgStarRating", userBucketItem.getBucketItem().getAverageStarRating());
		model.addAttribute("avgCostRating", userBucketItem.getBucketItem().getAverageCostRating());
		model.addAttribute("bestTimeToDo", userBucketItem.getBucketItem().getMostFrequentBestTime());

		model.addAttribute("returnToTab", "noteAdded");
		
		return "userBucketListItem";
	}

	@RequestMapping(path = "addResource.do", method = RequestMethod.POST)
	public String addResource(Integer bucketItemId, Resource resource, Model model) {
		UserBucketItem userBucketItem = daoUBI.addResourceToUserBucketItem(bucketItemId, resource);
		model.addAttribute("userBucketItem", userBucketItem);
		model.addAttribute("avgStarRating", userBucketItem.getBucketItem().getAverageStarRating());
		model.addAttribute("avgCostRating", userBucketItem.getBucketItem().getAverageCostRating());
		model.addAttribute("bestTimeToDo", userBucketItem.getBucketItem().getMostFrequentBestTime());
		model.addAttribute("returnToTab", "resourceAdded");
		return "userBucketListItem";
	}
	
	@RequestMapping(path="addCommentFromUserItem.do", method=RequestMethod.GET)
	public String addCommentToBucketItemFromUser(String commentText, Integer bucketItemId, Model model, HttpSession session, RedirectAttributes ra, Integer userBucketItemId) {
		User user = (User)session.getAttribute("loggedInUser");
		BucketItem bucketItem = bucketItemDao.findBucketItemById(bucketItemId);
		Comment comment = new Comment();
		comment.setBucketItem(bucketItem);
		comment.setUser(user);
		comment.setCommentText(commentText);
		commentDao.addComment(comment);
		ra.addAttribute("itemId", userBucketItemId);
		return "redirect:viewUserBucketItem.do";
	}
	
	@RequestMapping(path="addPoleFromUserItem.do", method=RequestMethod.GET)
	public String addPoleToBucketItemFromUser(Poll poll, Integer bucketItemId, Model model, HttpSession session, RedirectAttributes ra, Integer userBucketItemId) {
		User user = (User)session.getAttribute("loggedInUser");
		BucketItem bucketItem = bucketItemDao.findBucketItemById(bucketItemId);
		poll.setUser(user);
		poll.setBucketItem(bucketItem);
		pollDao.createPoll(poll);
		ra.addAttribute("itemId", userBucketItemId);
		return "redirect:viewUserBucketItem.do";		
	}
	

}
