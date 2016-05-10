package com.Singing.service;

import com.Singing.entity.User;

import java.util.Map;

/**
 * Created by Harold_LIU on 4/26/16.
 */
public interface LoginService {

    public User login(String username,String password);
    public User loginWithWechat(String openId,String username,String avatorURL,int gender);
    public User loginWithQQ(String openId,String username,String avatorURL,int gender);

    public Map<String, Object> getLoginResult(User theUser);

    public User signUp(String username,String password,String phoneNumber);


}
