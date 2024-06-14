package com.portal.abccars.repository;

import com.portal.abccars.model.Car;
import com.portal.abccars.model.CarBidding;
import com.portal.abccars.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BidRepository extends JpaRepository<CarBidding, Long> {
    List<CarBidding> findByUserAndCar(User user, Car car);

    List<CarBidding> findByUser(User user);

}
