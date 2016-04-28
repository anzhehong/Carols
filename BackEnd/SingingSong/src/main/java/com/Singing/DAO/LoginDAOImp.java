package com.Singing.DAO;

import com.Singing.entity.User;
import org.springframework.stereotype.Repository;

import javax.management.Query;

/**
 * Created by Harold_LIU on 4/27/16.
 */
@Repository
public class LoginDAOImp extends GeneralDAOImp<User> implements LoginDAO{
    public LoginDAOImp()
    {super(User.class);}

    @Override
    public User queryByPhonenumber(String phonenumber) {
        String hql = "from User where phoneNumber = :m";
        org.hibernate.Query query = super.sessionFactory.getCurrentSession().createQuery(hql);
        query.setString("m",phonenumber);
        if (query.list().size() == 0)
            return  null;
        else
        return (User)query.list().get(0);
    }

    @Override
    public User queryByOpenId(String openId) {
        String hql = "from User where openId = :m";
        org.hibernate.Query query = super.sessionFactory.getCurrentSession().createQuery(hql);
        query.setString("m",openId);
        if (query.list().size() == 0)
            return  null;
        else
            return (User)query.list().get(0);
    }
}
