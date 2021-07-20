package com.skilldistillery.buckit.dao;

import java.util.List;

import com.skilldistillery.buckit.entities.Category;
import com.skilldistillery.buckit.entities.Comment;

public interface CategoryDAO {

	Category addCategory(Category category);

	Category updateCategory(Category category, int idToUpdate);

	Boolean deleteCategory(int idToDelete);

	List<Category> getAllCategories();

	Category findCategoryById(int id);
	
	
}
