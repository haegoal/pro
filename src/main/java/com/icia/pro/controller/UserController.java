package com.icia.pro.controller;

import com.icia.pro.dto.UsersDTO;
import com.icia.pro.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Controller
public class UserController {
    @Autowired
    private UserService userService;
    @PostMapping("/user/login")
    public @ResponseBody int login(@ModelAttribute UsersDTO usersDTO, @RequestParam("keep") boolean keep,HttpSession session, HttpServletResponse response){
        int result = 0;
        boolean login = userService.findId(usersDTO);
        if(login){
            usersDTO = userService.login(usersDTO);
            if(usersDTO!=null){
                session.setAttribute("user", usersDTO.getUid());
                result=1;
                if(keep){
                    Cookie cookie=new Cookie("uid", usersDTO.getUid());
                    cookie.setMaxAge(60*60*24*7);
                    cookie.setPath("/");
                    response.addCookie(cookie);
                }
            }else{
                result=2;
            }
        }
        return result;
    }

    @GetMapping("/user/logout")
    public String logout(HttpSession session, HttpServletResponse response){
        session.removeAttribute("user");
        Cookie cookie=new Cookie("uid", "");
        cookie.setPath("/");
        cookie.setMaxAge(0);
        response.addCookie(cookie);
        return "home";
    }
}
