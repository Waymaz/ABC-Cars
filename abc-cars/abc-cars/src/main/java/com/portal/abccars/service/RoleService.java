package com.portal.abccars.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.portal.abccars.model.Role;
import com.portal.abccars.model.User;
import com.portal.abccars.repository.RoleRepository;
import com.portal.abccars.repository.UserRepository;

import java.util.Optional;

@Service
public class RoleService {
    
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private RoleRepository roleRepository;

    @Transactional
    public boolean assignRoleToUser(long userId, String roleName) {
        // Find the user by ID
        Optional<User> userOptional = userRepository.findById(userId);
        if (!userOptional.isPresent()) {
            return false; // User not found
        }
        
        // Find the role by name
        Optional<Role> roleOptional = Optional.of(roleRepository.findByName(roleName));
        if (!roleOptional.isPresent()) {
            return false; // Role not found
        }
        
        User user = userOptional.get();
        Role role = roleOptional.get();
        
        // Remove all existing roles from the user
        user.getRoles().clear();
        
        // Assign the new role to the user
        user.getRoles().add(role);
        userRepository.save(user);
        
        return true;
    }
}
