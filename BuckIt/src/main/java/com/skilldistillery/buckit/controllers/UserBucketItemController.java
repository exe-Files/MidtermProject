package com.skilldistillery.buckit.controllers;

import java.time.LocalDate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.skilldistillery.buckit.dao.UserBucketItemDAO;
import com.skilldistillery.buckit.entities.Note;
import com.skilldistillery.buckit.entities.Resource;
import com.skilldistillery.buckit.entities.UserBucketItem;

@Controller
public class UserBucketItemController {

	@Autowired
	private UserBucketItemDAO daoUBI;

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
		}
		if (!targetDate.equals("")) {
			LocalDate dateTargeted = LocalDate.parse(targetDate);
//			DateTimeFormatter.ISO_LOCAL_DATE.format(LocalDate.parse(targetDate));
			userBucketItem.setTargetDate(dateTargeted);
		}
		if (isCompleted.equals("true")) {
			userBucketItem.setCompleted(true);
		} else {
			userBucketItem.setCompleted(false);
		}

		System.out.println(userBucketItem);

		daoUBI.updateBucketItem(userBucketItem);
		model.addAttribute("userBucketItem", userBucketItem);

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

	@RequestMapping(path = "viewUserBucketItem.do", method = RequestMethod.GET)
	public String viewUserBucketItemDetails(Integer itemId, Model model) {
		UserBucketItem userBucketItem = daoUBI.findByID(itemId);
		model.addAttribute("userBucketItem", userBucketItem);
		model.addAttribute("avgStarRating", userBucketItem.getBucketItem().getAverageStarRating());
		model.addAttribute("avgCostRating", userBucketItem.getBucketItem().getAverageCostRating());
		model.addAttribute("bestTimeToDo", userBucketItem.getBucketItem().getMostFrequentBestTime());
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
		return "userBucketListItem";
	}

	@RequestMapping(path = "addResource.do", method = RequestMethod.POST)
	public String addResource(Integer bucketItemId, Resource resource, Model model) {
		UserBucketItem userBucketItem = daoUBI.addResourceToUserBucketItem(bucketItemId, resource);
		model.addAttribute("userBucketItem", userBucketItem);
		model.addAttribute("avgStarRating", userBucketItem.getBucketItem().getAverageStarRating());
		model.addAttribute("avgCostRating", userBucketItem.getBucketItem().getAverageCostRating());
		model.addAttribute("bestTimeToDo", userBucketItem.getBucketItem().getMostFrequentBestTime());
		return "userBucketListItem";
	}

}
