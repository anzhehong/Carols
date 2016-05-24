package com.Singing.DAO;

import com.Singing.entity.History;
import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by fowafolo
 * Date: 16/5/24
 * Time: 13:26
 */

@Repository
public class HistoryDAOImp extends GeneralDAOImp<History> implements HistoryDAO {

    public HistoryDAOImp() {
        super(History.class);
    }

    @Override
    public List<History> getHistoriesByUserId(String userId) {
        String hql = "from History where user_id = :m";
        Query query = super.sessionFactory.getCurrentSession().createQuery(hql);
        query.setString("m",userId);
        if (query.list().size() == 0)
            return null;
        else return query.list();
    }
}
