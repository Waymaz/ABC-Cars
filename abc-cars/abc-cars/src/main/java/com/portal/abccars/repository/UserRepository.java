package com.portal.abccars.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.portal.abccars.model.User;

public interface UserRepository extends JpaRepository<User, Long>{

	User findByUserName(String name);
}

