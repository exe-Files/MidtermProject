package com.skilldistillery.buckit.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.buckit.entities.BucketItem;
import com.skilldistillery.buckit.entities.Note;
import com.skilldistillery.buckit.entities.Resource;
import com.skilldistillery.buckit.entities.User;
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
		if (itemTBD != null) {
			em.remove(itemTBD);
			deleted = !em.contains(itemTBD);
		}

		return deleted;
	}

	@Override
	public UserBucketItem findByID(int id) {
		return em.find(UserBucketItem.class, id);
	}

	@Override
	public BucketItem getBucketItemFromUserBucketItem(UserBucketItem bucketItem) {
		return bucketItem.getBucketItem();
	}
	
	public Note findNoteById(int id) {
		return em.find(Note.class, id);
	}

	@Override
	public Resource findResourceById(int id) {
		return em.find(Resource.class, id);
	}
	
	@Override
	public List<UserBucketItem> getAllUserBucketItemsForLoggedInUser(User user) {
		List<UserBucketItem> allUserBucketItemsList = null;

		String jpqlQuery = "SELECT ubi FROM UserBucketItem ubi WHERE user = :user ORDER BY targetDate";
		allUserBucketItemsList = em.createQuery(jpqlQuery, UserBucketItem.class).setParameter("user", user)
				.getResultList();
		return allUserBucketItemsList;
	}

}
