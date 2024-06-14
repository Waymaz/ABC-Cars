package com.portal.abccars.repository;

import com.portal.abccars.model.Car;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CarRepository extends JpaRepository<Car, Long> {

    List<Car> findBySellerId(Long uid);

    @Query(value = "SELECT c FROM Car c WHERE LOWER(c.make) LIKE CONCAT('%', LOWER(:keyword), '%')"
            + " OR LOWER(c.model) LIKE CONCAT('%', LOWER(:keyword), '%')"
            + " OR LOWER(c.price) LIKE CONCAT('%', LOWER(:keyword), '%')"
            + " OR LOWER(c.registration) LIKE CONCAT('%', LOWER(:keyword), '%')")
	
	public List<Car> search(@Param("keyword") String keyword);
    List<Car> findByNameContainingIgnoreCase(String keyword);

    List<Car> findAllByBiddingsIsNotNull(); 
}
