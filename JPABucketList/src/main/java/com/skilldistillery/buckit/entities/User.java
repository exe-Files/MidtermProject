                                                    package com.skilldistillery.buckit.entities;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

import org.hibernate.annotations.CreationTimestamp;

@Entity
public class User {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String username;
	private String password;
	private String email;
	private String role;

	@Column(name = "first_name")
	private String firstName;
	@Column(name = "last_name")
	private String lastName;
	@Column(name = "date_created")
	@CreationTimestamp
	private LocalDateTime dateCreated;
	@Column(name = "is_active")
	private boolean isActive;
	@Column(name = "image_url")
	private String imageUrl;
	@OneToMany(mappedBy = "user")
	private List<UserBucketItem> userBucketItems;
	@OneToMany(mappedBy = "user")
	private List<Comment> userComments;
	@OneToMany(mappedBy = "user")
	private List<Poll> userPolls;

	// CONSTRUCTOR
	public User() {
		super();
	}

	// GETTERS AND SETTERS
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public LocalDateTime getDateCreated() {
		return dateCreated;
	}

	public void setDateCreated(LocalDateTime dateCreated) {
		this.dateCreated = dateCreated;
	}

	public boolean getIsActive() {
		return isActive;
	}

	public void setActive(boolean isActive) {
		this.isActive = isActive;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public List<UserBucketItem> getUserBucketItems() {
		return userBucketItems;
	}

	public void setUserBucketItems(List<UserBucketItem> userBucketItems) {
		this.userBucketItems = userBucketItems;
	}

	public void addUserBucketItem(UserBucketItem userBucketItem) {
		if (userBucketItems == null) {
			userBucketItems = new ArrayList<>();
		}

		if (!userBucketItems.contains(userBucketItem)) {
			userBucketItems.add(userBucketItem);
			if (userBucketItem.getUser() != null) {
				userBucketItem.getUser().getUserBucketItems().remove(userBucketItem);
			}
			userBucketItem.setUser(this);
		}
	}

	public void removeUserBucketItem(UserBucketItem userBucketItem) {
		userBucketItem.setUser(null);
		if (userBucketItems != null && userBucketItems.contains(userBucketItem)) {
			userBucketItems.remove(userBucketItem);
		}
	}

	public List<Comment> getUserComments() {
		return userComments;
	}

	public void setUserComments(List<Comment> userComments) {
		this.userComments = userComments;
	}

	public void addComment(Comment comment) {
		// If this entity doesn't have a comment list, make one
		if (userComments == null)
			userComments = new ArrayList<>();

		// If the entity's comment list doesn't contain the comment, add it
		if (!userComments.contains(comment)) {
			userComments.add(comment);
			// If the comment is associated with another user remove the comment from their
			// list
			if (comment.getUser() != null) {
				comment.getUser().getUserComments().remove(comment);
			}
			comment.setUser(this);
		}
	}

	public void removeComment(Comment comment) {
		comment.setUser(null);
		if (userComments != null) {
			userComments.remove(comment);
		}
	}

	public List<Poll> getUserPolls() {
		return userPolls;
	}

	public void setUserPolls(List<Poll> userPolls) {
		this.userPolls = userPolls;
	}

	public void addPoll(Poll poll) {
		// If this entity doesn't have a rental list, make one
		if (userPolls == null)
			userPolls = new ArrayList<>();

		// If the entity's rental list doesn't contain the rental, add it
		if (!userPolls.contains(poll)) {
			userPolls.add(poll);
			// If the rental is associated with another customer remove the rental from
			// their list
			if (poll.getUser() != null) {
				poll.getUser().getUserPolls().remove(poll);
			}
			poll.setUser(this);
		}
	}

	public void removePoll(Poll poll) {
		poll.setUser(null);
		if (userPolls != null) {
			userPolls.remove(poll);
		}
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("User [id=");
		builder.append(id);
		builder.append(", username=");
		builder.append(username);
		builder.append(", password=");
		builder.append(password);
		builder.append(", email=");
		builder.append(email);
		builder.append(", role=");
		builder.append(role);
		builder.append(", firstName=");
		builder.append(firstName);
		builder.append(", lastName=");
		builder.append(lastName);
		builder.append(", dateCreated=");
		builder.append(dateCreated);
		builder.append(", isActive=");
		builder.append(isActive);
		builder.append(", imageUrl=");
		builder.append(imageUrl);
		builder.append("]");
		return builder.toString();
	}

	// EQUALS & HASHCODE
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
		User other = (User) obj;
		if (id != other.id)
			return false;
		return true;
	}

}
