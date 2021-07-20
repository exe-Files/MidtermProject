package com.skilldistillery.buckit.dao;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.buckit.entities.Location;
import com.skilldistillery.buckit.entities.Location;
import com.skilldistillery.buckit.entities.Location;

@Service
@Transactional
public class LocationDAOImpl implements LocationDAO {

	@PersistenceContext
	private EntityManager em;

	@Override
	public Location findById(int id) {
		return em.find(Location.class, id);
	}

	@Override
	public Location createLocation(Location location) {
		em.persist(location);
		return location;
	}

	@Override
	public Location updateLocation(Location location) {
		Location dbLocation = em.find(Location.class, location.getId());
		
		dbLocation.setCityArea(location.getCityArea());
		dbLocation.setCountryCode(location.getCountryCode());
		dbLocation.setSpecificLocation(location.getSpecificLocation());
		
		em.flush();


		return null;
	}

	@Override
	public boolean deleteLocation(Location location) {
		boolean deleted = false;

		Location itemTBD = em.find(Location.class, location.getId());
		if (itemTBD != null) {
			em.remove(itemTBD);
			deleted = !em.contains(itemTBD);
		}

		return deleted;
	}
	
	

}
