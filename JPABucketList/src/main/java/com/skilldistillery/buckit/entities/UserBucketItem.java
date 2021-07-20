package com.skilldistillery.buckit.entities;

import java.time.LocalDate;
import java.util.ArrayList;
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

import org.hibernate.annotations.CreationTimestamp;

@Entity
@Table(name="user_bucket_item")
public class UserBucketItem {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	@Column(name = "date_added")
	@CreationTimestamp
	private LocalDate dateAdded;
	@Column(name = "date_completed")
	private LocalDate dateCompleted;
	@Column(name = "target_date")
	private LocalDate targetDate;
	@Column(name = "is_completed")
	private boolean isCompleted;
	@OneToMany(mappedBy="userBucketItem")
	private List<Note> notes;
	@OneToMany(mappedBy="userBucketItem")
	private List<Resource> resources;
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
	
	public void addNote(Note note) {
		if(notes == null) {
			notes = new ArrayList<>();
		}
		if(!notes.contains(note)) {
			notes.add(note);
			if(note.getUserBucketItem() != null) {
				note.getUserBucketItem().getNotes().remove(note);
			}
			note.setUserBucketItem(this);
		}
	}
	
	public void removeNote(Note note) {
		note.setUserBucketItem(null);
		if(notes != null) {
			notes.remove(note);
		}
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
				+ ", bucketItem=" + bucketItem + "]";
	}

	public BucketItem getBucketItem() {
		return bucketItem;
	}

	public void setBucketItem(BucketItem bucketItem) {
		this.bucketItem = bucketItem;
	}

	public List<Resource> getResources() {
		return resources;
	}

	public void setResources(List<Resource> resources) {
		this.resources = resources;
	}
	
	public void addResource(Resource resource) {
		if(resources == null) {
			resources = new ArrayList<>();
		}
		if(!resources.contains(resource)) {
			resources.add(resource);
			if(resource.getUserBucketItem() != null) {
				resource.getUserBucketItem().getResources().remove(resource);
			}
			resource.setUserBucketItem(this);
		}
	}
	
	public void removeResource(Resource resource) {
		resource.setUserBucketItem(null);
		if(resources != null) {
			resources.remove(resource);
		}
	}
	
	public int getStarRating() {
		return bucketItem.getAverageStarRating();
	}
	
	public int getCostRating() {
		return bucketItem.getAverageCostRating();
	}
	
	public String getBestTime() {
		return bucketItem.getMostFrequentBestTime();
	}
}
