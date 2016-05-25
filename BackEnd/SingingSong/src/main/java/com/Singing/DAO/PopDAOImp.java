package com.Singing.DAO;

import com.Singing.entity.PopTable;
import org.hibernate.Criteria;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by fowafolo
 * Date: 16/5/25
 * Time: 17:03
 */

@Repository

public class PopDAOImp extends GeneralDAOImp<PopTable> implements PopDAO {
    public PopDAOImp() {
        super(PopTable.class);
    }

    @Override
    public List<PopTable> getPopRankList(int limit) {
        Criteria criteria = sessionFactory.getCurrentSession().createCriteria(PopTable.class);
        criteria.setMaxResults(limit);
        if (criteria.list().size() == 0)
            return null;
        else return criteria.list();
    }

}
