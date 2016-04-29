package com.Singing.service;

import com.Singing.DAO.LoginDAO;
import com.Singing.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by Harold_LIU on 4/26/16.
 */

@Transactional
@Service
public class LoginServiceImp implements LoginService {

    @Autowired
    private LoginDAO loginDAO;

    @Override
    public User login(String phonenumber, String password) {
        if (loginDAO.queryByPhonenumber(phonenumber)!=null)
        {
            if (password.equals(loginDAO.queryByPhonenumber(phonenumber).getPassword()))
              return loginDAO.queryByPhonenumber(phonenumber);
            else
              return  null;
        }
        else
            return null;
    }

    @Override
    public User loginWithWechat(String openId,String username,String avatorURL,int gender) {
       if(loginDAO.queryByOpenId(openId)==null)
           loginDAO.insert(new User(username,gender,avatorURL,1,"","",openId));
           return loginDAO.queryByOpenId(openId);
    }

    @Override
    public User loginWithQQ(String openId, String username, String avatorURL, int gender) {
        if(loginDAO.queryByOpenId(openId)==null)
            loginDAO.insert(new User(username,gender,avatorURL,2,"","",openId));
        return loginDAO.queryByOpenId(openId);
    }

    @Override
    public User signUp(String username, String password, String phoneNumber) {
        if (phoneNumber.equals(loginDAO.queryByPhonenumber(phoneNumber)))
            return null;
        else {
            User newUser = new User(username,0,"http://cl.ly/3f1h1C102v3n",0,password,phoneNumber,null);
            loginDAO.insert(newUser);
            return newUser;
        }
    }
}

