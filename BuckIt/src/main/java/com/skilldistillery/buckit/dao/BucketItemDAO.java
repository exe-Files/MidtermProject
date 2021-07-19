package com.skilldistillery.buckit.dao;

import java.util.List;

import com.skilldistillery.buckit.entities.BucketItem;

public interface BucketItemDAO {
	
	BucketItem createBucketItem(BucketItem bucketItem);
	
	BucketItem updateBucketItem(BucketItem bucketItem);
	
	boolean deleteBucketItem(int id);

	List<BucketItem> getAllPublicBucketItems();
}
