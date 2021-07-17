package com.skilldistillery.buckit.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class CommentTest {
	
	private static EntityManagerFactory emf;
	private EntityManager em;
	private Comment comment;

	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		emf = Persistence.createEntityManagerFactory("JPABucketList");
	}

	@AfterAll
	static void tearDownAfterClass() throws Exception {
		emf.close();
	}

	@BeforeEach
	void setUp() throws Exception {
		em = emf.createEntityManager();
		comment = em.find(Comment.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		comment = null;
		em.close();
	}

	@Test
	void test_comment_mappings() {
		assertNotNull(comment);
		assertNull(comment.getDateCreated());
		assertNull(comment.getDateUpdated());
		assertEquals("Roaring Fork Valley is full of moose", comment.getCommentText());
	}
	
	@Test
	void test_comment_to_user_mappings() {
		assertNotNull(comment);
		assertEquals("admin", comment.getUser().getUsername());
		assertEquals("adminbucketpass", comment.getUser().getPassword());
	}
	
//	@Test
//	void test_comment_to_BucketItem_mappings() {
//		assertNotNull(comment);
//		assertEquals("Fill the freezer", comment.getBucketItem().getDescription());
//		assertEquals("Hunt a Moose", comment.getBucketItem().getName());
//	}

}
