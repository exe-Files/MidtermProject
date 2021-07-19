package com.skilldistillery.buckit.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.skilldistillery.buckit.dao.BucketItemDAO;
import com.skilldistillery.buckit.entities.BucketItem;

@Controller
public class ExploreController {

	@Autowired
	private BucketItemDAO bucketItemDao;

	@RequestMapping(path = "exploreAll.do")
	public String exploreAllBucketItems(Model model) {
		List<BucketItem> allPublicBucketItems = null;
		allPublicBucketItems = bucketItemDao.getAllPublicBucketItems();
		model.addAttribute("DEBUG", allPublicBucketItems);
		return "exploreAll";
	}


}
