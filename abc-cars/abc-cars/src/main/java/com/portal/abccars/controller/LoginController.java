package com.portal.abccars.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.portal.abccars.model.Car;
import com.portal.abccars.model.CarBidding;
import com.portal.abccars.model.User;

import com.portal.abccars.service.CarService;
import com.portal.abccars.service.UserService;
import com.portal.abccars.service.RoleService;

import java.security.Principal;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

@Controller
public class LoginController {

    private final RoleService roleService;

    @Autowired
    private UserService userService;

    @Autowired
    public LoginController(RoleService roleService) {
        this.roleService = roleService;
    }

    @Autowired
    private CarService carService;

    @GetMapping(value = "/login")
    public String showLogin(Model model) {
        model.addAttribute("user", new User());
        return "login";
    }

    @GetMapping("/login_error")
    public String handleLoginError(Model model) {
        model.addAttribute("error_string", "Incorrect username or password. Try Again.");
        return "login";
    }

    @GetMapping("/register")
    public String showRegistrationForm(Model model) {
        model.addAttribute("user", new User());
        return "register";
    }

    @PostMapping("/register")
    public String registerNewUser(@ModelAttribute User user, Model model) {
        userService.save(user);
        model.addAttribute("success_register", "Registration Successful!");
        return "register";
    }

    @GetMapping("/profile")
    public String showProfile(Model model, Principal principal) {
        String username = principal.getName();
        User user = userService.findLoginUser(username);
        List<User> userList = Arrays.asList(user);
        model.addAttribute("user", userList);
        List<Car> cars = carService.findCarPosts(user.getId());
        model.addAttribute("cars", cars);
        List<CarBidding> bids = carService.getUserBids(user);
        model.addAttribute("bids", bids);
        return "profile";
    }

    @PostMapping("/update")
    public String updateUser(Principal principal, @ModelAttribute User user) {
        String username = principal.getName();
        User existingUser = userService.findLoginUser(username);
        existingUser.setName(user.getName());
        existingUser.setUserName(user.getUserName());
        existingUser.setEmail(user.getEmail());
        existingUser.setMobile(user.getMobile());
        existingUser.setAddress(user.getAddress());
        userService.update(existingUser);
        return "redirect:/profile";
    }

    @GetMapping("/users")
    public String showAllUsers(Model model) {
        List<User> users = userService.showAllUser();
        model.addAttribute("user", users);
        return "allUser";
    }

    @GetMapping("/view")
    public String viewUserProfile(@RequestParam long uid, Model model) {
        Optional<User> user = userService.getUserInfo(uid);
        if (user.isPresent()) {
            model.addAttribute("user", user.get());
            List<Car> cars = carService.findCarPosts(uid);
            model.addAttribute("cars", cars);
            return "profile";
        } else {
            model.addAttribute("error", "User not found");
            return "error";
        }
    }

    @GetMapping("/delete")
    public String deleteUser(@RequestParam long uid) {
        userService.deleteUser(uid);
        return "redirect:/users";
    }

    @PostMapping("/edit")
    public String editUser(@RequestParam long uid, @ModelAttribute User user) {
        Optional<User> existingUser = userService.getUserInfo(uid);
        if (existingUser.isPresent()) {
            User userToEdit = existingUser.get();
            userToEdit.setName(user.getName());
            userToEdit.setUserName(user.getUserName());
            userToEdit.setEmail(user.getEmail());
            userToEdit.setMobile(user.getMobile());
            userToEdit.setAddress(user.getAddress());
            userService.update(userToEdit);
            return "redirect:/users";
        } else {
            return "error";
        }
    }

    @PostMapping("/assign_role")
    public String assignRoleToUser(@RequestParam long userId, @RequestParam String roleName) {
        boolean success = roleService.assignRoleToUser(userId, roleName);
        if (success) {
            return "redirect:/users"; // Redirect to user list or profile page
        } else {
            return "error";
        }
    }

    @GetMapping("/about_us")
    public String showAboutUsPage() {
        return "aboutUs";
    }

    @GetMapping("/contact_us")
    public String showContactUsPage() {
        return "contactUs";
    }
}
