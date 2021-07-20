package com.skilldistillery.buckit.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.buckit.entities.Category;

@Service
@Transactional
public class CategoryDAOImpl implements CategoryDAO {

	@PersistenceContext
	private EntityManager em;

	@Override
	public Category addCategory(Category category) {
		em.persist(category);
		return category;
	}

	@Override
	public Category updateCategory(Category category, int idToUpdate) {
		Category categoryToUpdate = em.find(Category.class, idToUpdate);
		categoryToUpdate.setCategoryName(category.getCategoryName());
		return categoryToUpdate;
	}

	@Override
	public Boolean deleteCategory(int idToDelete) {
		boolean successful = false;
		Category categoryToDelete = em.find(Category.class, idToDelete);
		if (categoryToDelete != null) {
			em.remove(categoryToDelete);
			successful = !em.contains(categoryToDelete);
		}
		return successful;
	}
	
	@Override
	public List<Category> getAllCategories() {
		List<Category> allCategories = null;
		String jpqlQuery = "SELECT c FROM Category c ORDER BY categoryName";
		allCategories = em.createQuery(jpqlQuery, Category.class).getResultList();
		return allCategories;
	}
	
	@Override
	public Category findCategoryById(int id) {
		Category category = null;
		category = em.find(Category.class, id);
		return category;
	}

	
}
