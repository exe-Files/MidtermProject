package com.skilldistillery.buckit.dao;

import com.skilldistillery.buckit.entities.Location;

public interface LocationDAO {
	
	Location findById(int id);
	Location createLocation(Location location);
	Location updateLocation(Location location);
	boolean deleteLocation(Location location);

}
