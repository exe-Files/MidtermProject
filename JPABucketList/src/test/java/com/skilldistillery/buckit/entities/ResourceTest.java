package com.skilldistillery.buckit.entities;

import static org.junit.jupiter.api.Assertions.*;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class ResourceTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Resource resource;
	
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
		resource = em.find(Resource.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		resource = null;
		em.close();
	}

	@Test
	void test_resource_mappings() {
		assertNotNull(resource);
		assertEquals("https://cpw.state.co.us/moose-country", resource.getUrl());
	}
	
//	@Test
//	void test_resource_country_mappings() {
//		assertNotNull(resource.());
//		assertEquals("Europe", resource;
//		
//		
//	}

}
