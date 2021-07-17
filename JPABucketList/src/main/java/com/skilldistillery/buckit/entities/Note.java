package com.skilldistillery.buckit.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

@Entity
public class Note {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	@Column(name="note_title")
	private String noteTitle;
	@Column(name="note_text")
	private String noteText;
	@ManyToOne
	@JoinColumn(name="user_bucket_item_id")
	private UserBucketItem userBucketItem;
	
	// Methods
	
	public Note() {} // No-Arg Constructor

	// Getters & Setters
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getNoteTitle() {
		return noteTitle;
	}

	public void setNoteTitle(String noteTitle) {
		this.noteTitle = noteTitle;
	}

	public String getNoteText() {
		return noteText;
	}

	public void setNoteText(String noteText) {
		this.noteText = noteText;
	}

	@Override
	public String toString() {
		return "Note [id=" + id + ", noteTitle=" + noteTitle + ", noteText=" + noteText + "]";
	}

	public UserBucketItem getUserBucketItem() {
		return userBucketItem;
	}

	public void setUserBucketItem(UserBucketItem userBucketItem) {
		this.userBucketItem = userBucketItem;
	}

}
