package com.shopping.controller;

import com.shopping.entity.User;
import com.shopping.service.UserService;
import com.shopping.util.Result;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/user")
public class UserController {

    private static final Logger logger = LoggerFactory.getLogger(UserController.class);

    @Autowired
    private UserService userService;

    @GetMapping("/login")
    public String loginPage() {
        return "user/login";
    }

    @GetMapping("/register")
    public String registerPage() {
        return "user/register";
    }

    @PostMapping("/doLogin")
    @ResponseBody
    public Result<User> doLogin(@RequestParam String username, 
                                @RequestParam String password, 
                                HttpSession session) {
        User user = userService.login(username, password);
        session.setAttribute("user", user);
        logger.info("用户登录成功: {}", username);
        return Result.success("登录成功", user);
    }

    @PostMapping("/doRegister")
    @ResponseBody
    public Result<User> doRegister(@RequestBody User user) {
        User newUser = userService.register(user);
        logger.info("用户注册成功: {}", user.getUsername());
        return Result.success("注册成功", newUser);
    }

    @GetMapping("/doRegisterByGet")
    @ResponseBody
    public Result<User> registerByGet(@RequestParam String username,
                                      @RequestParam String password,
                                      @RequestParam(required = false) String realName,
                                      @RequestParam(required = false) String email,
                                      @RequestParam(required = false) String phone,
                                      @RequestParam(required = false) String address) {
        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setRealName(realName);
        user.setEmail(email);
        user.setPhone(phone);
        user.setAddress(address);
        
        User newUser = userService.register(user);
        logger.info("用户注册成功: {}", user.getUsername());
        return Result.success("注册成功", newUser);
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.removeAttribute("user");
        session.invalidate();
        return "redirect:/user/login";
    }

    @GetMapping("/info")
    @ResponseBody
    public Result<User> getUserInfo(HttpSession session) {
        User user = (User) session.getAttribute("user");
        return Result.success(user);
    }

    @GetMapping("/profile")
    public String profilePage() {
        return "user/profile";
    }

    @PostMapping("/updateProfile")
    @ResponseBody
    public Result<?> updateProfile(@RequestBody User user, HttpSession session) {
        User currentUser = (User) session.getAttribute("user");
        user.setId(currentUser.getId());
        boolean success = userService.updateUser(user);
        if (success) {
            User updatedUser = userService.getUserById(currentUser.getId());
            session.setAttribute("user", updatedUser);
            return Result.success("更新成功");
        }
        return Result.error("更新失败");
    }

    @PostMapping("/update")
    @ResponseBody
    public Result<?> updateUser(@RequestBody User user, HttpSession session) {
        User currentUser = (User) session.getAttribute("user");
        user.setId(currentUser.getId());
        boolean success = userService.updateUser(user);
        if (success) {
            User updatedUser = userService.getUserById(currentUser.getId());
            session.setAttribute("user", updatedUser);
            return Result.success("更新成功");
        }
        return Result.error("更新失败");
    }
}
