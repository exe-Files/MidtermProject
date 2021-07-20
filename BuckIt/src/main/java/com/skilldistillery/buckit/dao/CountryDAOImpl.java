package com.skilldistillery.buckit.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.buckit.entities.Category;
import com.skilldistillery.buckit.entities.Country;

@Service
@Transactional
public class CountryDAOImpl implements CountryDAO {
	@PersistenceContext
	private EntityManager em;
	
	@Override
	public Country findById(int id) {
		return em.find(Country.class, id);
	}

	@Override
	public Country createCountry(Country country) {
		em.persist(country);
		return country;
	}

	@Override
	public Country updateCountry(Country country) {
		Country dbCountry = em.find(Country.class, country.getCountryCode());
		
		dbCountry.setContinent(country.getContinent());
		dbCountry.setCountryName(country.getCountryName());
		
		return null;
	}

	@Override
	public boolean deleteCountry(Country country) {
		Country dbCountry = em.find(Country.class, country.getCountryCode());
		boolean removed = false;
		
		em.remove(dbCountry);
		removed = !em.contains(dbCountry);

		return removed;
	}

	@Override
	public List<Country> getAllCountries() {
		List<Country> allCountries = null;
		String jpqlQuery = "SELECT c FROM Country c ORDER BY countryName";
		allCountries = em.createQuery(jpqlQuery, Country.class).getResultList();
		return allCountries;
	}

}
