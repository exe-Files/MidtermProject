package com.skilldistillery.buckit.dao;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.buckit.entities.Comment;

@Service
@Transactional
public class CommentDAOImpl implements CommentDAO {
	
	@PersistenceContext
	private EntityManager em;

	@Override
	public Comment addComment(Comment comment) {
		em.persist(comment);
		return comment;
	}

	@Override
	public Comment updateComment(Comment comment) {
		Comment commentDB = em.find(Comment.class, comment.getId());
		
		commentDB.setCommentText(comment.getCommentText());
		commentDB.setDateCreated(comment.getDateCreated());
		commentDB.setDateUpdated(comment.getDateUpdated());
		commentDB.setImageUrl(comment.getImageUrl());
		commentDB.setUser(comment.getUser());
		commentDB.setBucketItem(comment.getBucketItem());
		
		em.flush();
		
		return commentDB;
	}

	@Override
	public boolean deleteComment(int id) {
		boolean deleted = false;
		
		Comment commentTBD = em.find(Comment.class, id);
		if(commentTBD != null) {
			em.remove(commentTBD);
			deleted = !em.contains(commentTBD);
		}
		
		return deleted;
	}
	
}
