package com.skilldistillery.buckit.dao;

import java.util.List;

import com.skilldistillery.buckit.entities.Country;

public interface CountryDAO {

	Country findByCountryCode(String countryCode);
	Country createCountry(Country country);
	Country updateCountry(Country country);
	boolean deleteCountry(Country country);
	List<Country> getAllCountries();
}
