package com.Singing.controller;

import com.Singing.service.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by Harold_LIU on 4/26/16.
 */
@Controller
@RequestMapping("/Login")
public class LoginController {

    @Autowired
    private LoginService loginService;

    @RequestMapping("/SignIn")
    @ResponseBody
    public Map<String, Object> Login(String username,String password)
    {
        Map<String ,Object> result = new HashMap<String, Object>();
        result.put("Status",loginService.login(username,password));
        return result;
    }

    @RequestMapping("/SignUp")
    @ResponseBody
    public Map<String, Object> SignUp(String username,String password,String phoneNumber)
    {
        Map<String ,Object> result = new HashMap<String, Object>();
        result.put("Status",loginService.signUp(username,password,phoneNumber));
        return result;
    }

}
