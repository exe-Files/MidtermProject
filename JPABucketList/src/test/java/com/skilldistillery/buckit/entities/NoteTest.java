package com.skilldistillery.buckit.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class NoteTest {
	
	private static EntityManagerFactory emf;
	private EntityManager em;
	private Note note;

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
		note = em.find(Note.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		note = null;
		em.close();
	}

	@Test
	void test_note_mappings() {
		assertNotNull(note);
		assertEquals("Get Tag", note.getNoteTitle());
		assertEquals("Apply for big game tag", note.getNoteText());
	}
	
	@Test
	void test_note_to_bucketItem_mappings() {
		assertNotNull(note);
		assertEquals(2, note.getUserBucketItem().getId());
	}

}
