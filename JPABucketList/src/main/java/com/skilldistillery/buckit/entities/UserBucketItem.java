package com.skilldistillery.buckit.entities;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
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

	public boolean getIsCompleted() {
		return isCompleted;
	}

	public void setIsCompleted(boolean isCompleted) {
		this.isCompleted = isCompleted;
	}

	@Override
	public String toString() {
		return "UserBucketItem [id=" + id + ", dateAdded=" + dateAdded + ", dateCompleted=" + dateCompleted
				+ ", targetDate=" + targetDate + ", isCompleted=" + isCompleted + "]";
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
}
