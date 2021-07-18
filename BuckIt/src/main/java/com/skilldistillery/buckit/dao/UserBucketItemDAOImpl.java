package com.skilldistillery.buckit.dao;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.buckit.entities.UserBucketItem;

@Service
@Transactional
public class UserBucketItemDAOImpl implements UserBucketItemDAO {
	
	@PersistenceContext
	private EntityManager em;

	@Override
	public UserBucketItem createBucketItem(UserBucketItem bucketItem) {
		em.persist(bucketItem);
		return bucketItem;
	}

	@Override
	public UserBucketItem updateBucketItem(UserBucketItem bucketItem) {
		UserBucketItem bucketItemDB = em.find(UserBucketItem.class, bucketItem.getId());
		
		bucketItemDB.setDateAdded(bucketItem.getDateAdded());
		bucketItemDB.setDateCompleted(bucketItem.getDateCompleted());
		bucketItemDB.setTargetDate(bucketItem.getTargetDate());
		bucketItemDB.setCompleted(bucketItem.isCompleted());
		bucketItemDB.setNotes(bucketItem.getNotes());
		bucketItemDB.setResources(bucketItem.getResources());
		bucketItemDB.setUser(bucketItem.getUser());
		bucketItemDB.setBucketItem(bucketItem.getBucketItem());
		
		em.flush();
		
		return bucketItemDB;
	}

	@Override
	public boolean deleteBucketItem(int id) {
		boolean deleted = false;
		
		UserBucketItem itemTBD = em.find(UserBucketItem.class, id);
		if(itemTBD != null) {
			em.remove(itemTBD);
			deleted = !em.contains(itemTBD);
		}
		
		return deleted;
	}

	@Override
	public UserBucketItem findByID(int id) {
		return em.find(UserBucketItem.class, id);
	}
	
}
