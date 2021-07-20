package com.skilldistillery.buckit.entities;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

@Entity
@Table(name = "bucket_item")
public class BucketItem {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String name;
	private String description;

	@Column(name = "date_created")
	@CreationTimestamp
	private LocalDateTime dateCreated;

	@Column(name = "date_updated")
	@UpdateTimestamp
	private LocalDateTime dateUpdated;

	@Column(name = "is_public_at_creation")
	private Boolean isPublicAtCreation;

	@Column(name = "is_active")
	private Boolean isActive;

	@Column(name = "image_url")
	private String imageUrl;

	@ManyToOne
	@JoinColumn(name = "location_id")
	private Location location;

	@ManyToOne
	@JoinColumn(name = "created_by_user")
	private User createdByUser;

	@ManyToMany
	@JoinTable(name = "bucket_item_has_category", joinColumns = @JoinColumn(name = "bucket_item_id"), inverseJoinColumns = @JoinColumn(name = "category_id"))
	List<Category> categories;

	@OneToMany(mappedBy = "bucketItem")
	List<Poll> polls;

	@OneToMany(mappedBy = "bucketItem")
	List<Comment> comments;

	// CONSTRUCTOR
	public BucketItem() {
		super();
	}

	// GETTERS AND SETTERS
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public LocalDateTime getDateCreated() {
		return dateCreated;
	}

	public void setDateCreated(LocalDateTime dateCreated) {
		this.dateCreated = dateCreated;
	}

	public LocalDateTime getDateUpdated() {
		return dateUpdated;
	}

	public void setDateUpdated(LocalDateTime dateUpdated) {
		this.dateUpdated = dateUpdated;
	}

	public Boolean getIsPublicAtCreation() {
		return isPublicAtCreation;
	}

	public void setIsPublicAtCreation(Boolean isPublicAtCreation) {
		this.isPublicAtCreation = isPublicAtCreation;
	}

	public Boolean getIsActive() {
		return isActive;
	}

	public void setIsActive(Boolean isActive) {
		this.isActive = isActive;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public Location getLocation() {
		return location;
	}

	public void setLocation(Location location) {
		this.location = location;
	}

	public User getCreatedByUser() {
		return createdByUser;
	}

	public void setCreatedByUser(User createdByUser) {
		this.createdByUser = createdByUser;
	}

	public List<Category> getCategories() {
		return categories;
	}

	public void setCategories(List<Category> categories) {
		this.categories = categories;
	}

	public List<Poll> getPolls() {
		return polls;
	}

	public void setPolls(List<Poll> polls) {
		this.polls = polls;
	}

	public List<Comment> getComments() {
		return comments;
	}

	public void setComments(List<Comment> comments) {
		this.comments = comments;
	}

	public void addCategory(Category category) {
		if (categories == null) {
			categories = new ArrayList<Category>();
		}
		if (!categories.contains(category)) {
			categories.add(category);
			category.addBucketItem(this);
		}
	}

	public void removeCategory(Category category) {
		if (categories != null && categories.contains(category)) {
			categories.remove(category);
			category.removeBucketItem(this);
		}
	}

	public void addPoll(Poll poll) {
		if (polls == null) {
			polls = new ArrayList<>();
		}
		if (!polls.contains(poll)) {
			polls.add(poll);
			if (poll.getBucketItem() != null) {
				poll.getBucketItem().getPolls().remove(poll);
			}
			poll.setBucketItem(this);
		}
	}

	public void removePoll(Poll poll) {
		poll.setBucketItem(null);
		if (polls != null && polls.contains(poll)) {
			polls.remove(poll);
		}
	}

	public void addComment(Comment comment) {
		if (comments == null) {
			comments = new ArrayList<>();
		}
		if (!comments.contains(comment)) {
			comments.add(comment);
			if (comment.getBucketItem() != null) {
				comment.getBucketItem().getComments().remove(comment);
			}
			comment.setBucketItem(this);
		}
	}

	public void removeComment(Comment comment) {
		comment.setBucketItem(null);
		if (comments != null && comments.contains(comment)) {
			comments.remove(comment);
		}
	}

	// TO STRING
	@Override
	public String toString() {
		return "BucketItem [id=" + id + ", name=" + name + ", description=" + description + ", dateCreated="
				+ dateCreated + ", dateUpdated=" + dateUpdated + ", isPublicAtCreation=" + isPublicAtCreation
				+ ", isActive=" + isActive + ", imageUrl=" + imageUrl + ", createdByUser=" + createdByUser + "]";
	}

	// HASHCODE AND EQUALS
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
		BucketItem other = (BucketItem) obj;
		if (id != other.id)
			return false;
		return true;
	}

}
