package com.Singing.service;

import com.Singing.DAO.LoginDAO;
import com.Singing.entity.User;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * Created by Harold_LIU on 4/26/16.
 */
public class LoginServiceImp implements LoginService {

    @Autowired
    private LoginDAO loginDAO;

    @Override
    public int login(String username, String password)
    {
        if(password.equals(loginDAO.queryById(username)))
            return 100 ;
        else
            return 101;
    }

    @Override
    public int signUp(String username, String password, String phoneNumber)
    {
        if(username.equals(loginDAO.queryById(username)))
            return 101;
        else
        {
            loginDAO.insert(new User(username,password,phoneNumber));
            return 100;
        }
    }


}
