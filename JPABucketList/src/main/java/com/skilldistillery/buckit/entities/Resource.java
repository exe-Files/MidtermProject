package com.skilldistillery.buckit.entities;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

@Entity
public class Resource {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String url;
	
	@ManyToOne // Many Resources to one user bucket item
	@JoinColumn(name="user_bucket_item") 
//	@Column(name="user_bucket_item") 
	private UserBucketItem userBucketItem;

	public Resource() { // No-Arg Constructor
		super();
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public UserBucketItem getUserBucketItem() {
		return userBucketItem;
	}

	public void setUserBucketItem(UserBucketItem userBucketItem) {
		this.userBucketItem = userBucketItem;
	}

	@Override
	public String toString() {
		return "Resource [id=" + id + ", url=" + url + ", userBucketItem=" + userBucketItem + "]";
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
		Resource other = (Resource) obj;
		if (id != other.id)
			return false;
		return true;
	}
	
	
	
}
