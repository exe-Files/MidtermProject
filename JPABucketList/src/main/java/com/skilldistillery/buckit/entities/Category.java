package com.skilldistillery.buckit.entities;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;

@Entity
public class Category {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@Column(name = "category_name")
	private String categoryName;

	@ManyToMany(mappedBy = "categories")
	private List<BucketItem> bucketItems;

	public Category() { // No-Arg constructor
		super();
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public List<BucketItem> getBucketItems() {
		return bucketItems;
	}

	public void setBucketItems(List<BucketItem> bucketItems) {
		this.bucketItems = bucketItems;
	}

	public void addBucketItem(BucketItem bucketItem) {
		if (bucketItems == null) {
			bucketItems = new ArrayList<>();
		}
		if (!bucketItems.contains(bucketItem)) {
			bucketItems.add(bucketItem);
			bucketItem.addCategory(this);
		}
	}

	public void removeBucketItem(BucketItem bucketItem) {
		if (bucketItems != null && bucketItems.contains(bucketItem)) {
			bucketItems.remove(bucketItem);
			bucketItem.removeCategory(this);
		}
	}

	@Override
	public String toString() {
		return "Category [id=" + id + ", categoryName=" + categoryName + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + id;
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Category other = (Category) obj;
		if (id != other.id)
			return false;
		return true;
	}

}
