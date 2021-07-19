package com.skilldistillery.buckit.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.buckit.entities.User;

@Service
@Transactional
public class UserDAOImpl implements UserDAO {

	@PersistenceContext
	private EntityManager em;

	@Override
	public User findById(int id) {
		return em.find(User.class, id);
	}

	@Override
	public User createUser(User user) {
		em.persist(user);
		return user;
	}

	@Override
	public User updateUser(User user) {
		User dbUser = em.find(User.class, user.getId());

		dbUser.setActive(user.getIsActive());
//		dbUser.setDateCreated(user.getDateCreated());
		dbUser.setUsername(user.getUsername());
		dbUser.setPassword(user.getPassword());
		dbUser.setEmail(user.getEmail());
		dbUser.setRole(user.getRole());
		dbUser.setFirstName(user.getFirstName());
		dbUser.setLastName(user.getLastName());
		dbUser.setImageUrl(user.getImageUrl());

		return dbUser;
	}

	@Override
	public boolean deleteUser(User user) {
		User dbUser = em.find(User.class, user.getId());
		boolean removed = false;

		em.remove(dbUser);
		removed = !em.contains(dbUser);

		return removed;
	}

	@Override
	public List<User> findUsernameBySearchString(String string) {
		List<User> userList = null;

		String query = "SELECT u FROM User u WHERE username LIKE :kw";

		userList = em.createQuery(query, User.class).setParameter("kw", "%" + string + "%")
				.getResultList();

		return userList;
	}
	

	@Override
	public User findUserByUsernameAndPassword(String username, String password) {
	User user = null;
	String query = "SELECT u FROM User u WHERE username = :username AND password = :password";
	try {
		user = em.createQuery(query, User.class).setParameter("username", username)
				.setParameter("password", password).getSingleResult();
	}
	catch (NoResultException e) {
		e.printStackTrace();
		return user;
	}
	return user;
	}
	
	@Override
	public List<User> getAllUsers() {
		List<User> userList = null;
		String jpqlQuery = "SELECT u FROM User u";
		userList = em.createQuery(jpqlQuery, User.class).getResultList();
		return userList;
	}

}
