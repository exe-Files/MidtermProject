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

class CountryTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Country country;
	
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
		country = em.find(Country.class, "FRA");
	}

	@AfterEach
	void tearDown() throws Exception {
		country = null;
		em.close();
	}

	@Test
	void test_country_mappings() {
		assertNotNull(country);
		assertEquals("France, French Republic", country.getCountryName());
		assertEquals("Europe", country.getContinent());
	}

}
