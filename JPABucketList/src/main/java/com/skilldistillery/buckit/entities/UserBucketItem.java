package com.skilldistillery.buckit.entities;

import java.time.LocalDate;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name="user_bucket_item")
public class UserBucketItem {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	@Column(name = "date_added")
	private LocalDate dateAdded;
	@Column(name = "date_completed")
	private LocalDate dateCompleted;
	@Column(name = "target_date")
	private LocalDate targetDate;
	@Column(name = "is_completed")
	private boolean isCompleted;
	@OneToMany(mappedBy="userBucketItem")
	private List<Note> notes;
	@ManyToOne
	@JoinColumn(name="user_id")
	private User user;
	@ManyToOne
	@JoinColumn(name="bucket_item_id")
	private BucketItem bucketItem;
	
	// Methods
	public UserBucketItem() {} // No-Arg Constructor

	// Getters & Setters
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public LocalDate getDateAdded() {
		return dateAdded;
	}

	public void setDateAdded(LocalDate dateAdded) {
		this.dateAdded = dateAdded;
	}

	public LocalDate getDateCompleted() {
		return dateCompleted;
	}

	public void setDateCompleted(LocalDate dateCompleted) {
		this.dateCompleted = dateCompleted;
	}

	public LocalDate getTargetDate() {
		return targetDate;
	}

	public void setTargetDate(LocalDate targetDate) {
		this.targetDate = targetDate;
	}

	public boolean isCompleted() {
		return isCompleted;
	}

	public void setCompleted(boolean isCompleted) {
		this.isCompleted = isCompleted;
	}

	public List<Note> getNotes() {
		return notes;
	}

	public void setNotes(List<Note> notes) {
		this.notes = notes;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@Override
	public String toString() {
		return "UserBucketItem [id=" + id + ", dateAdded=" + dateAdded + ", dateCompleted=" + dateCompleted
				+ ", targetDate=" + targetDate + ", isCompleted=" + isCompleted + ", notes=" + notes + ", user=" + user
				+ "]";
	}

	public BucketItem getBucketItem() {
		return bucketItem;
	}

	public void setBucketItem(BucketItem bucketItem) {
		this.bucketItem = bucketItem;
	}
	
	
	
}
