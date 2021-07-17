package com.skilldistillery.buckit.dao;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.buckit.entities.Poll;

@Service
@Transactional
public class PollDAOImpl implements PollDAO {
	@PersistenceContext
	private EntityManager em;

	@Override
	public Poll findById(int id) {
		return em.find(Poll.class, id);
	}

	@Override
	public Poll createPoll(Poll poll) {
		em.persist(poll);
		return poll;
	}

	@Override
	public boolean deletePoll(Poll poll) {
		Poll dbPoll = em.find(Poll.class, poll.getId());
		boolean removed = false;
		
		em.remove(dbPoll);
		removed = !em.contains(dbPoll);

		return removed;
	}

	@Override
	public Poll updatePoll(Poll poll) {
		Poll dbPoll = em.find(Poll.class, poll.getId());
		
		dbPoll.setRatingStars(poll.getRatingStars());
		dbPoll.setCostDollarSigns(poll.getCostDollarSigns());
		dbPoll.setBestTimeToDo(poll.getBestTimeToDo());
		dbPoll.setDateCreated(poll.getDateCreated());
		dbPoll.setDateUpdated(poll.getDateUpdated());
		dbPoll.setBucketItem(poll.getBucketItem());
		dbPoll.setUser(poll.getUser());
		
		return poll;
	}

}
