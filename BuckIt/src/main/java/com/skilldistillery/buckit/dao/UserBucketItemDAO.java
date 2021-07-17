package com.skilldistillery.buckit.dao;

import com.skilldistillery.buckit.entities.UserBucketItem;

public interface UserBucketItemDAO {
	
	UserBucketItem createBucketItem(UserBucketItem bucketItem);
	
	UserBucketItem updateBucketItem(UserBucketItem bucketItem);
	
	boolean deleteBucketItem(int id);
	
}
