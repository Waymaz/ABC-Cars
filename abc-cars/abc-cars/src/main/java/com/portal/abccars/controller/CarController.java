package com.portal.abccars.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.portal.abccars.model.Car;
import com.portal.abccars.model.CarBidding;
import com.portal.abccars.model.User;
import com.portal.abccars.service.CarService;
import com.portal.abccars.service.UserService;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.security.Principal;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Controller
public class CarController {

    @Autowired
    private CarService carService;

    @Autowired
    private UserService userService;

    @GetMapping("/")
    public String redirectToCars() {
        return "redirect:cars";
    }

    @GetMapping("/cars")
    public ModelAndView viewCars(@ModelAttribute("car") Car car) {
        List<Car> cars = carService.getAllCars();
        return new ModelAndView("viewCars", "cars", cars);
    }

    @GetMapping("/car_detail")
    public String viewCarDetail(@RequestParam long cid, Model model) {
        Optional<Car> carInfoOptional = carService.getCarInfo(cid);
        if (carInfoOptional.isPresent()) {
            Car car = carInfoOptional.get();
            model.addAttribute("car", List.of(car));
            List<CarBidding> biddings = carService.getAllBids().stream()
                    .filter(bid -> bid.getCar().equals(car))
                    .collect(Collectors.toList());
            model.addAttribute("bid", biddings);
            model.addAttribute("highest", biddings.stream().mapToDouble(CarBidding::getBidderPrice).max().orElse(0));
        }
        return "carDetail";
    }

    @PostMapping("/car_post")
    public String saveCar(@ModelAttribute("car") Car car, RedirectAttributes ra,
                          @RequestParam("fileImage") MultipartFile multipartFile, Principal principal) throws IOException {

        String fileName = multipartFile.getOriginalFilename();
        car.setPhotos(fileName);

        Car savedCar = carService.save(car);
        String uploadDir = "./src/main/resources/static/images/car-photo/" + savedCar.getId();
        Path uploadPath = Paths.get(uploadDir);
        Files.createDirectories(uploadPath);

        try (var inputStream = multipartFile.getInputStream()) {
            Path filePath = uploadPath.resolve(fileName);
            Files.copy(inputStream, filePath, StandardCopyOption.REPLACE_EXISTING);
        }

        car.setPhotoImagePath("/images/car-photo/" + savedCar.getId() + "/" + savedCar.getPhotos());

        String username = principal.getName();
        User user = userService.findLoginUser(username);
        car.setSellerId(user.getId());
        carService.save(car);

        ra.addFlashAttribute("success_post", "Post has been saved successfully");
        return "redirect:cars";
    }

    @PostMapping("/bid")
    public String carBidding(@ModelAttribute("bidding") CarBidding bid,
                             @RequestParam long cid, Principal principal,
                             @RequestParam("bidderPrice") double price, Model model) {

        User user = userService.findLoginUser(principal.getName());
        Optional<Car> carInfoOptional = carService.getCarInfo(cid);

        if (carInfoOptional.isPresent()) {
            Car car = carInfoOptional.get();
            bid.setBidderName(user.getName());
            bid.setUser(user);
            bid.setCar(car);

            List<CarBidding> userBids = carService.findUserBid(user, car);

            if (!userBids.isEmpty()) {
                CarBidding existingBid = userBids.get(0);
                existingBid.setBidderPrice(price);
                carService.saveBid(existingBid);
            } else {
                carService.saveBid(bid);
            }

            model.addAttribute("car", List.of(car));
            List<CarBidding> biddings = carService.getAllBids().stream()
                    .filter(bidItem -> bidItem.getCar().equals(car))
                    .collect(Collectors.toList());
            model.addAttribute("bid", biddings);
            model.addAttribute("highest", biddings.stream().mapToDouble(CarBidding::getBidderPrice).max().orElse(0));
        }
        return "carDetail";
    }

    @PostMapping("/book")
    public String carBooking(@ModelAttribute("booking") CarBidding book, @RequestParam long cid,
                             Principal principal, Model model,
                             @RequestParam("bookDate") String date) {

        User user = userService.findLoginUser(principal.getName());
        Optional<Car> carInfoOptional = carService.getCarInfo(cid);

        if (carInfoOptional.isPresent()) {
            Car car = carInfoOptional.get();
            book.setUser(user);
            book.setCar(car);
            book.setBidderName(user.getName());

            List<CarBidding> userBookings = carService.findUserBid(user, car);

            if (!userBookings.isEmpty()) {
                CarBidding existingBook = userBookings.get(0);
                existingBook.setBookDate(date);
                carService.saveBid(existingBook);
            } else {
                carService.saveBid(book);
            }

            model.addAttribute("car", List.of(car));
            List<CarBidding> biddings = carService.getAllBids().stream()
                    .filter(bid -> bid.getCar().equals(car))
                    .collect(Collectors.toList());
            model.addAttribute("bid", biddings);
            model.addAttribute("highest", biddings.stream().mapToDouble(CarBidding::getBidderPrice).max().orElse(0));
        }
        return "carDetail";
    }

    @GetMapping("/deletecar")
    public String deleteCar(@RequestParam long cid) {
        carService.deleteCar(cid);
        return "redirect:cars";
    }

    @GetMapping("all_cars")
    public ModelAndView showAllCar(@ModelAttribute("car") Car car) {
        List<Car> cars = carService.getAllCarsWithBiddings();
        return new ModelAndView("allCar", "cars", cars);
    }

    @PostMapping("/edit_car")
    public String editCar(@ModelAttribute("car") Car car, @RequestParam long cid) {
        Optional<Car> carInfoOptional = carService.getCarInfo(cid);
        if (carInfoOptional.isPresent()) {
            Car existingCar = carInfoOptional.get();
            existingCar.setMake(car.getMake());
            existingCar.setModel(car.getModel());
            existingCar.setName(car.getName());
            existingCar.setPrice(car.getPrice());
            existingCar.setRegistration(car.getRegistration());
            existingCar.setSellerId(car.getSellerId());
            existingCar.setPhotos(car.getPhotos());
            existingCar.setPhotoImagePath(car.getPhotoImagePath());
            carService.save(existingCar);
        }
        return "redirect:all_cars";
    }

    @GetMapping("/delete_car")
    public String deletePostCar(@RequestParam long cid) {
        carService.deleteCar(cid);
        return "redirect:all_cars";
    }

    @PostMapping("/booking_status")
    public String setCarBookingStatus(@RequestParam long bid,
                                      @ModelAttribute("book") CarBidding book) {
        Optional<CarBidding> bidOptional = carService.getBidInfo(bid);
        bidOptional.ifPresent(bidData -> {
            bidData.setBookStatus(book.getBookStatus());
            carService.saveBid(bidData);
        });
        return "redirect:all_cars";
    }

    @PostMapping("/sale_status")
    public String setCarSaleStatus(@RequestParam long cid,
                                   @ModelAttribute("car") Car car) {
        Optional<Car> carInfoOptional = carService.getCarInfo(cid);
        carInfoOptional.ifPresent(carData -> {
            carData.setSellStatus(car.getSellStatus());
            carService.save(carData);
        });
        return "redirect:all_cars";
    }

    @GetMapping("/search")
    public ModelAndView searchCars(@RequestParam String keyword, Model model) {
        List<Car> searchCar = carService.search(keyword);
        model.addAttribute("keyword", keyword);
        return new ModelAndView("searchResults", "searchCar", searchCar);
    }
}
