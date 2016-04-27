package com.Singing.entity;

import javax.jws.soap.SOAPBinding;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Created by Harold_LIU on 4/26/16.
 */

@Table
@Entity
public class User {

    @Id
    private int id;

    private String nickName;
    private int gender;
    private String avatorUrl;
    private int loginWay;
    private String password;
    private String phoneNumber;

    public User(String Username, String Password, String PhoneNumber)
    {
        nickName = Username;
        password = Password;
        phoneNumber = PhoneNumber;
    }


    public int getId() {
        return id;
    }

    public String getNickName() {
        return nickName;
    }

    public int getGender() {
        return gender;
    }

    public String getAvatorUrl() {
        return avatorUrl;
    }

    public int getLoginWay() {
        return loginWay;
    }

    public String getPassword() {return password;}

    public void setId(int id) {
        this.id = id;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }

    public void setGender(int gender) {
        this.gender = gender;
    }

    public void setAvatorUrl(String avatorUrl) {
        this.avatorUrl = avatorUrl;
    }

    public void setLoginWay(int loginWay) {
        this.loginWay = loginWay;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
