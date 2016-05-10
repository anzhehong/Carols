package com.Singing.controller;

import com.Singing.entity.User;
import com.Singing.service.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Map;

/**
 * Created by Harold_LIU on 4/26/16.
 */
@Controller
@RequestMapping("/LogIn")
public class LoginController {

    @Autowired
    private LoginService loginService;

    @RequestMapping("/SignIn")
    @ResponseBody
    public Map<String, Object> Login(String phonenumber,String password)
    {
        User theUser = loginService.login(phonenumber,password);
        Map<String ,Object> result;
        result = loginService.getLoginResult(theUser);
        return result;
    }

    @RequestMapping("/SignInWeChat")
    @ResponseBody
    public Map<String, Object> LoginWithWeChat(String openId,String username,String avatorURL,int gender)
    {
        User theUser = loginService.loginWithWechat(openId,username,avatorURL,gender);
        Map<String ,Object> result;
        result = loginService.getLoginResult(theUser);
        return result;
    }

    @RequestMapping("/SignInQQ")
    @ResponseBody
    public Map<String, Object> LoginWithQQ(String openId,String username,String avatorURL,int gender)
    {
        User theUser = loginService.loginWithQQ(openId,username,avatorURL,gender);
        Map<String ,Object> result;
        result = loginService.getLoginResult(theUser);
        return result;
    }

    @RequestMapping("/SignUp")
    @ResponseBody
    public Map<String, Object> SignUp(String username,String password,String phoneNumber)
    {
        User theUser = loginService.signUp(username,password,phoneNumber);
        Map<String ,Object> result;
        result = loginService.getLoginResult(theUser);
        return result;
    }
}
