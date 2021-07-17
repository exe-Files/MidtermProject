package com.skilldistillery.buckit.dao;

import com.skilldistillery.buckit.entities.Poll;

public interface PollDAO {
	Poll findById(int id);
	Poll createPoll(Poll poll);
	boolean deletePoll(Poll poll);
	Poll updatePoll(Poll poll);

}
