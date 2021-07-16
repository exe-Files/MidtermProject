package com.skilldistillery.buckit.dao;

import com.skilldistillery.buckit.entities.User;

public interface UserDAO {
	
	User findById(int id);

}
