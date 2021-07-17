package com.skilldistillery.buckit.dao;

import com.skilldistillery.buckit.entities.Comment;

public interface CommentDAO {
	
	Comment addComment(Comment comment);
	
	Comment updateComment(Comment comment);
	
	boolean deleteComment(int id);
}
