package com.skilldistillery.buckit.dao;

import java.util.List;

import com.skilldistillery.buckit.entities.BucketItem;
import com.skilldistillery.buckit.entities.Category;
import com.skilldistillery.buckit.entities.Note;
import com.skilldistillery.buckit.entities.Resource;
import com.skilldistillery.buckit.entities.User;
import com.skilldistillery.buckit.entities.UserBucketItem;

public interface UserBucketItemDAO {
	
	UserBucketItem findByID(int id);
	
	UserBucketItem createBucketItem(UserBucketItem bucketItem);
	
	UserBucketItem updateBucketItem(UserBucketItem bucketItem);
	
	boolean deleteBucketItem(int id);
	
	BucketItem getBucketItemFromUserBucketItem(UserBucketItem bucketItem);
	
	public Note findNoteById(int id);
	
	public Resource findResourceById(int id);

	List<UserBucketItem> getAllUserBucketItemsForLoggedInUser(User user);

	public UserBucketItem addPublicBucketItemToUserBucket(UserBucketItem userBucketItem);
	
	UserBucketItem addNoteToUserBucketItem(int id, Note note);
	
	UserBucketItem addResourceToUserBucketItem(int id, Resource resource);

	UserBucketItem removeNoteFromUserBucketItem(int bucketId, int noteId);
	
	UserBucketItem removeResourceFromUserBucketItem(int bucketId, int resourceId);

	List<UserBucketItem> getUserBucketItemsWithCategory(Category category);
	
}
