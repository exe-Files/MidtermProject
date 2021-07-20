package com.skilldistillery.buckit.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.buckit.entities.BucketItem;
import com.skilldistillery.buckit.entities.Category;
import com.skilldistillery.buckit.entities.User;

@Service
@Transactional
public class BucketItemDAOImpl implements BucketItemDAO {

	@PersistenceContext
	private EntityManager em;

	@Override
	public BucketItem createBucketItem(BucketItem bucketItem) {
		em.persist(bucketItem);
		return bucketItem;
	}

	@Override
	public BucketItem updateBucketItem(BucketItem bucketItem) {
		BucketItem bucketItemDB = em.find(BucketItem.class, bucketItem.getId());

		bucketItemDB.setName(bucketItem.getName());
		bucketItemDB.setDescription(bucketItem.getDescription());
		bucketItemDB.setDateCreated(bucketItem.getDateCreated());
		bucketItemDB.setDateUpdated(bucketItem.getDateUpdated());
		bucketItemDB.setIsPublicAtCreation(bucketItem.getIsPublicAtCreation());
		bucketItemDB.setIsActive(bucketItem.getIsActive());
		bucketItemDB.setImageUrl(bucketItem.getImageUrl());
//		bucketItemDB.setLocation(bucketItem.getLocation());
//		bucketItemDB.setCreatedByUser(bucketItem.getCreatedByUser());
//		bucketItemDB.setCategories(bucketItem.getCategories());
//		bucketItemDB.setPolls(bucketItem.getPolls());
//		bucketItemDB.setComments(bucketItem.getComments());

		em.flush();

		return bucketItemDB;
	}

	@Override
	public boolean deleteBucketItem(int id) {
		boolean deleted = false;

		BucketItem itemTBD = em.find(BucketItem.class, id);
		if (itemTBD != null) {
			em.remove(itemTBD);
			deleted = !em.contains(itemTBD);
		}

		return deleted;
	}

	@Override
	public List<BucketItem> getAllPublicBucketItems() {
		List<BucketItem> allPublicBucketItemsList = null;

		String jpqlQuery = "SELECT bi FROM BucketItem bi WHERE isPublicAtCreation = :flag ORDER BY name";
		allPublicBucketItemsList = em.createQuery(jpqlQuery, BucketItem.class).setParameter("flag", true)
				.getResultList();
		return allPublicBucketItemsList;
	}

	@Override
	public BucketItem findBucketItemById(int id) {
		BucketItem resultBucketItem = null;
		String jpqlQuery = "SELECT bi FROM BucketItem bi WHERE id = :id";
		try {
			resultBucketItem = em.createQuery(jpqlQuery, BucketItem.class).setParameter("id", id).getSingleResult();
			return resultBucketItem;
		}
		catch (NoResultException e) {
			e.printStackTrace();
			return resultBucketItem;
		}
	}
	
	@Override
	public List<BucketItem> getAllBucketItems() {
		List<BucketItem> allBucketItemsList = null;

		String jpqlQuery = "SELECT bi FROM BucketItem bi";
		allBucketItemsList = em.createQuery(jpqlQuery, BucketItem.class).getResultList();
		return allBucketItemsList;
	}
	
	@Override
	public List<BucketItem> getAllBucketItemsWithCategory(Category category) {
		List<BucketItem> filteredBucketItemList = null;
		String jpqlQuery = "SELECT bi FROM BucketItem bi WHERE :category MEMBER OF categories";
		filteredBucketItemList = em.createQuery(jpqlQuery, BucketItem.class).setParameter("category", category).getResultList();
		return filteredBucketItemList;
	}
	
	@Override
	public List<BucketItem> getFilteredByUserBucketItems(User user) {
		List<BucketItem> filteredBucketItemList = null;
		String jpqlQuery = "SELECT bi FROM BucketItem bi WHERE createdByUser = :user";
		filteredBucketItemList = em.createQuery(jpqlQuery, BucketItem.class).setParameter("user", user).getResultList();
		return filteredBucketItemList;
	}

}
