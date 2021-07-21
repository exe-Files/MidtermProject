package com.skilldistillery.buckit.dao;

import java.util.List;

import com.skilldistillery.buckit.entities.BucketItem;
import com.skilldistillery.buckit.entities.Category;
import com.skilldistillery.buckit.entities.User;

public interface BucketItemDAO {
	
	BucketItem createBucketItem(BucketItem bucketItem);
	
	BucketItem updateBucketItem(BucketItem bucketItem);
	
	boolean deleteBucketItem(int id);

	List<BucketItem> getAllPublicBucketItems();

	BucketItem findBucketItemById(int id);

	List<BucketItem> getAllBucketItems();

	List<BucketItem> getAllBucketItemsWithCategory(Category category);

	List<BucketItem> getFilteredByUserBucketItems(User user);
}
