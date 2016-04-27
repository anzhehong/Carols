package com.Singing.DAO;

import com.Singing.entity.User;

/**
 * Created by Harold_LIU on 4/27/16.
 */
public class LoginDAOImp extends GeneralDAOImp<User> implements LoginDAO{
    public LoginDAOImp()
    {super(User.class);}

}
