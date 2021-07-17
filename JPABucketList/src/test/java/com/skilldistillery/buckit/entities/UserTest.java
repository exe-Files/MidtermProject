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
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

class UserTest {
	
	private static EntityManagerFactory emf;
	private EntityManager em;
	private User user;

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
		user = em.find(User.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		user = null;
		em.close();
	}

	@Test
	void test_user_mappings() {
		assertNotNull(user);
		assertEquals("admin", user.getUsername());
		assertEquals("adminbucketpass", user.getPassword());
		assertNull(user.getEmail());
		assertNull(user.getImageUrl());
		assertNull(user.getDateCreated());
		assertEquals("admin", user.getRole());
		assertEquals("Admin", user.getFirstName());
		assertEquals("Admin", user.getLastName());
		assertEquals(true, user.isActive());
		
	}
	
	@Test
	void test_user_userBucketItem_mapping() {
		assertNotNull(user);
		assertEquals(0, user.getUserBucketItems().size());
	}
	@Test
	void test_user_userPoll_mapping() {
		assertNotNull(user);
		assertEquals(1, user.getUserPolls().size());
	}
	@Test
	void test_user_userComment_mapping() {
		assertNotNull(user);
		assertEquals(1, user.getUserComments().size());
	}

}
