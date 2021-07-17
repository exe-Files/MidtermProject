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

class PollTest {
	
	private static EntityManagerFactory emf;
	private EntityManager em;
	private Poll poll;

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
		poll = em.find(Poll.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		poll = null;
		em.close();
	}

	@Test
	void test_poll_mappings() {
		assertNotNull(poll);
		assertNull(poll.getDateCreated());
		assertNull(poll.getDateUpdated());
		assertNull(poll.getCostDollarSigns());
		assertEquals("Fall", poll.getBestTimeToDo());
	}
	
	@Test
	void test_poll_to_user_mappings() {
		assertNotNull(poll);
		assertEquals("admin", poll.getUser().getUsername());
	}
	
	@Test
	void test_poll_to_bucketItem_mappings() {
		assertNotNull(poll);
		assertEquals("Hunt a Moose", poll.getBucketItem().getName());
	}

}
