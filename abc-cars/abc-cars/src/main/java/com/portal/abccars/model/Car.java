package com.portal.abccars.model;

import jakarta.persistence.*;
import org.springframework.data.annotation.CreatedDate;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

@Entity
public class Car {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = true, length = 64)
    private String photos;

    @Column(nullable = true, length = 64)
    private String photoImagePath;

    @OneToMany(mappedBy = "car")
    private Set<CarBidding> biddings = new HashSet<>();

    private String name;
    
    private String make;
    
    private String model;

    private String registration;

    private String price;
    
    private Long sellerId;

    private String sellStatus;

    @CreatedDate
    private String postDate;

    // Constructor
    public Car() {
    }

    public Car(Long id, String photos, String photoImagePath, String name, String make, String model,
               String registration, String price, Long sellerId) {
        this.id = id;
        this.photos = photos;
        this.photoImagePath = photoImagePath;
        this.name = name;
        this.make = make;
        this.model = model;
        this.registration = registration;
        this.price = price;
        this.sellerId = sellerId;
    }

    //Life cycle callback to set the post date
    @PrePersist
    private void onCreate() {
        DateFormat dateOnly = new SimpleDateFormat("EEEEE dd MMMMM yyyy");
        postDate = dateOnly.format(new Date());
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getPhotos() {
        return photos;
    }

    public void setPhotos(String photos) {
        this.photos = photos;
    }

    public String getPhotoImagePath() {
        return photoImagePath;
    }

    public void setPhotoImagePath(String photoImagePath) {
        this.photoImagePath = photoImagePath;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getMake() {
        return make;
    }

    public void setMake(String make) {
        this.make = make;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public String getRegistration() {
        return registration;
    }

    public void setRegistration(String registration) {
        this.registration = registration;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public Long getSellerId() {
        return sellerId;
    }

    public void setSellerId(Long sellerId) {
        this.sellerId = sellerId;
    }

    public String getSellStatus() {
        return sellStatus;
    }

    public void setSellStatus(String sellStatus) {
        this.sellStatus = sellStatus;
    }

    public String getPostDate() {
        return postDate;
    }

    public void setPostDate(String postDate) {
        this.postDate = postDate;
    }

    public Set<CarBidding> getBiddings() {
        return biddings;
    }

    public void setBiddings(Set<CarBidding> biddings) {
        this.biddings = biddings;
    }

    @Override
    public String toString() {
        return "Car [id=" + id + ", photos=" + photos + ", photoImagePath=" + photoImagePath + ", name=" + name
                + ", make=" + make + ", model=" + model + ", registration=" + registration + ", price=" + price
                + ", sellerId=" + sellerId + ", sellStatus=" + sellStatus + ", postDate=" + postDate + "]";
    }
}
