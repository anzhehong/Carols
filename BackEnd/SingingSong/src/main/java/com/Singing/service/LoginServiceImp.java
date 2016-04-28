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
    public int loginWithWeibo(String username) {


        return 0;
    }


    @Override
    public int signUp(String username, String password, String phoneNumber) {
        if (username.equals(loginDAO.queryById(username)))
            return 101;
        else {
          //  loginDAO.insert(new User());
            return 100;
        }
    }


}

