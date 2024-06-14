package com.portal.abccars.service;

import java.util.HashSet;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import jakarta.persistence.EntityManager;

import jakarta.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.portal.abccars.model.Role;
import com.portal.abccars.model.User;
import com.portal.abccars.repository.RoleRepository;
import com.portal.abccars.repository.UserRepository;

@Service
@Transactional
public class UserService {

	@Autowired
	private UserRepository userRepository;

	@Autowired
	private RoleRepository roleRepository;

	@Autowired
	private PasswordEncoder passwordEncoder;

	@Autowired
	private EntityManager entityManager;


	// Save a new user and automatically assign the "USER" role
	public String save(User user) {
		// Encode the password
		String encodedPassword = passwordEncoder.encode(user.getPassword());
		user.setPassword(encodedPassword);

		// Retrieve the "USER" role from the RoleRepository
		Role userRole = roleRepository.findByName("USER");
		if (userRole == null) {
			throw new IllegalStateException("The 'USER' role could not be found in the database.");
		}

		// Assign the "USER" role to the user
		Set<Role> roles = new HashSet<>();
		roles.add(userRole);
		user.setRoles(roles);

		// Save the user
		userRepository.save(user);

		return "User saved successfully";
	}

	public User findLoginUser(String username) {
		return userRepository.findByUserName(username);
	}

	public List<User> showAllUser() {
		return userRepository.findAll();
	}

	public void update(User user) {
		userRepository.save(user);
	}

	public Optional<User> getUserInfo(long uid) {
		return userRepository.findById(uid);
	}

	public void deleteUser(long uid) {
		userRepository.deleteById(uid);
	}

	public void assignNewRole(User user, String roleName) {
		// Retrieve the specified role from the RoleRepository
		Role newRole = roleRepository.findByName(roleName);
		if (newRole == null) {
			throw new IllegalStateException(
					"The specified role '" + roleName + "' could not be found in the database.");
		}

		// Add the new role to the user's existing roles
		user.getRoles().add(newRole);

		// Save the user to persist the updated roles
		userRepository.save(user);
	}
	
	 @Transactional
	 public void resetAutoIncrement() {
	 entityManager.createNativeQuery("ALTER TABLE user AUTO_INCREMENT = 2").
	 executeUpdate(); }

}
