package com.portal.abccars.service;

import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.portal.abccars.model.Car;
import com.portal.abccars.model.CarBidding;
import com.portal.abccars.model.User;
import com.portal.abccars.repository.BidRepository;
import com.portal.abccars.repository.CarRepository;

import java.util.List;
import java.util.Optional;
import java.util.Comparator;
import java.util.stream.Collectors;

@Service
@Transactional
public class CarService {

    @Autowired
    private CarRepository carRepository;

    @Autowired
    private BidRepository bidRepository;

    // Method to retrieve all cars
    public List<Car> getAllCars() {
        return carRepository.findAll();
    }

    // Method to save a car
    public Car save(Car car) {
        return carRepository.save(car);
    }

    // Method to retrieve car information by ID
    public Optional<Car> getCarInfo(long carId) {
        return carRepository.findById(carId);
    }

    // Method to retrieve car posts by seller ID
    public List<Car> findCarPosts(long sellerId) {
        return carRepository.findBySellerId(sellerId);
    }

    // Method to delete a car by ID
    public void deleteCar(long carId) {
        carRepository.deleteById(carId);
    }

    // Method to search for cars by keyword
    public List<Car> search(String keyword) {
        return carRepository.findByNameContainingIgnoreCase(keyword);
    }

    // Method to save a car bidding
    public CarBidding saveBid(CarBidding bid) {
        return bidRepository.save(bid);
    }

    // Method to retrieve all bids, sorted by highest bidder price
    public List<CarBidding> getAllBids() {
        return bidRepository.findAll().stream()
                .sorted(Comparator.comparingDouble(CarBidding::getBidderPrice).reversed())
                .collect(Collectors.toList());
    }

    // Method to find user bids for a specific car
    public List<CarBidding> findUserBid(User user, Car car) {
        return bidRepository.findByUserAndCar(user, car);
    }

    // Method to retrieve bid information by ID
    public Optional<CarBidding> getBidInfo(long bidId) {
        return bidRepository.findById(bidId);
    }

    // Method to retrieve user bids
    public List<CarBidding> getUserBids(User user) {
        return bidRepository.findByUser(user);
    }

    // Method to delete a bid by ID
    public void deleteBid(long bidId) {
        bidRepository.deleteById(bidId);
    }
    
    @Transactional
    public List<Car> getAllCarsWithBiddings() {
        return carRepository.findAllByBiddingsIsNotNull();
    }
    
}
