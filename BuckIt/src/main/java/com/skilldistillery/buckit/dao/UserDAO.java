package com.skilldistillery.buckit.dao;

import java.util.List;

import com.skilldistillery.buckit.entities.User;

public interface UserDAO {
	
	User findById(int id);
	List<User> findUsernameBySearchString(String string);
	
	User createUser(User user);
	User updateUser(User user);
	boolean deleteUser(User user);
	User findUserByUsernameAndPassword(String username, String password);

}
