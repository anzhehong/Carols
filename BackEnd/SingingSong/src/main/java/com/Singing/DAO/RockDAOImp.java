package com.Singing.DAO;

import com.Singing.entity.RockTable;
import org.hibernate.Criteria;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by fowafolo
 * Date: 16/5/25
 * Time: 17:05
 */

@Repository
public class RockDAOImp extends GeneralDAOImp<RockTable> implements RockDAO {

    public RockDAOImp() {
        super(RockTable.class);
    }

    @Override
    public List<RockTable> getRockRankList(int limit) {
        Criteria criteria = sessionFactory.getCurrentSession().createCriteria(RockTable.class);
        criteria.setMaxResults(limit);
        if (criteria.list().size() == 0)
            return null;
        else return criteria.list();
    }

}
