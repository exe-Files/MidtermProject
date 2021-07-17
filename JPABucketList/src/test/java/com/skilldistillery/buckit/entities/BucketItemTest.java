package com.skilldistillery.buckit.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class BucketItemTest {
	
	private static EntityManagerFactory emf;
	private EntityManager em;
	private BucketItem item;

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
		item = em.find(BucketItem.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		item = null;
		em.close();
	}

	@Test
	void test_bucket_item_standalone_mappings() {
		assertNotNull(item);
		assertEquals("Climb the Eiffel Tower", item.getName());
		assertEquals("Lookout from the top of the Eiffel Tower", item.getDescription());
		assertTrue(item.getIsActive());
		assertTrue(item.getIsPublicAtCreation());
		assertNull(item.getImageUrl());
	}
	
	@Test
	void test_bucket_item_to_user_mappings() {
		assertEquals("steven", item.getCreatedByUser().getUsername());
	}
	
	@Test
	void test_bucket_item_to_location_mappings() {
		assertEquals("Paris", item.getLocation().getCityArea());
	}

}
