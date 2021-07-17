package com.skilldistillery.buckit.entities;

import java.time.LocalDate;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

@Entity
public class Comment {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	@Column(name="comment_text")
	private String commentText;
	@Column(name="date_created")
	private LocalDate dateCreated;
	@Column(name="date_updated")
	private LocalDate dateUpdated;
	@Column(name="image_url")
	private String imageUrl;
	@ManyToOne
	@JoinColumn(name="user_id")
	private User user;
//	@ManyToOne							// TODO: Test Once BucketItem entity is complete
//	@JoinColumn(name="bucket_item_id")
//	private BucketItem bucketItem;
	
	// Methods
	public Comment() {} // No-arg Constructor

	// Getters & Setters
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getCommentText() {
		return commentText;
	}

	public void setCommentText(String commentText) {
		this.commentText = commentText;
	}

	public LocalDate getDateCreated() {
		return dateCreated;
	}

	public void setDateCreated(LocalDate dateCreated) {
		this.dateCreated = dateCreated;
	}

	public LocalDate getDateUpdated() {
		return dateUpdated;
	}

	public void setDateUpdated(LocalDate dateUpdated) {
		this.dateUpdated = dateUpdated;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	@Override
	public String toString() {
		return "Comment [id=" + id + ", commentText=" + commentText + ", dateCreated=" + dateCreated + ", dateUpdated="
				+ dateUpdated + ", imageUrl=" + imageUrl + "]";
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

//	public BucketItem getBucketItem() {			//TODO: Don't forget to uncomment
//		return bucketItem;
//	}
//
//	public void setBucketItem(BucketItem bucketItem) {
//		this.bucketItem = bucketItem;
//	}
	
}
