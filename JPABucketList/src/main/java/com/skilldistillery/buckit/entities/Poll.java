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
public class Poll {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	@Column(name="rating_stars")
	private Integer ratingStars;
	@Column(name="cost_dollar_signs")
	private Integer costDollarSigns;
	@Column(name="best_time_todo")
	private String bestTimeToDo;
	@Column(name="date_created")
	private LocalDate dateCreated;
	@Column(name="date_updated")
	private LocalDate dateUpdated;
	@ManyToOne								// Test Once BucketItem is complete
	@JoinColumn(name="bucket_item_id") 
	private BucketItem bucketItem;
	@ManyToOne
	@JoinColumn(name="user_id")
	private User user;
	
	// Methods 
	
	public Poll() {} // No-Arg Constructor

	// Getters & Setters
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Integer getRatingStars() {
		return ratingStars;
	}

	public void setRatingStars(Integer ratingStars) {
		this.ratingStars = ratingStars;
	}

	public Integer getCostDollarSigns() {
		return costDollarSigns;
	}

	public void setCostDollarSigns(Integer costDollarSigns) {
		this.costDollarSigns = costDollarSigns;
	}

	public String getBestTimeToDo() {
		return bestTimeToDo;
	}

	public void setBestTimeToDo(String bestTimeToDo) {
		this.bestTimeToDo = bestTimeToDo;
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

	@Override
	public String toString() {
		return "Poll [id=" + id + ", ratingStars=" + ratingStars + ", costDollarSigns=" + costDollarSigns
				+ ", bestTimeToDo=" + bestTimeToDo + ", dateCreated=" + dateCreated + ", dateUpdated=" + dateUpdated
				+ "]";
	}

	public BucketItem getBucketItem() {							// TODO: Uncomment before testing
		return bucketItem;
	}

	public void setBucketItem(BucketItem bucketItem) {
		this.bucketItem = bucketItem;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
}
