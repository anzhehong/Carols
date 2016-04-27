package com.Singing.service;

/**
 * Created by Harold_LIU on 4/26/16.
 */
public interface LoginService {

    public int login(String username,String password);
    public int signUp(String username,String password,String phoneNumber);

}
