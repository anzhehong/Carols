package com.Singing.DAO;

import com.Singing.entity.User;

/**
 * Created by Harold_LIU on 4/27/16.
 */
public interface LoginDAO extends GeneralDAO<User> {
    public User queryByPhonenumber(String phonenumber);
    public User queryByOpenId(String openId);
}
