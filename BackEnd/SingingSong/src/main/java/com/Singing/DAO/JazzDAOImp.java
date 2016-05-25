package com.Singing.DAO;

import com.Singing.entity.JazzTable;
import com.Singing.entity.Recommendation;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by fowafolo
 * Date: 16/5/25
 * Time: 16:05
 */

@Repository
public class JazzDAOImp extends GeneralDAOImp<JazzTable> implements JazzDAO {

    public JazzDAOImp() {
        super(JazzTable.class);
    }

    @Override
    public List<JazzTable> getJazzRankList(int limit) {
        Criteria criteria = sessionFactory.getCurrentSession().createCriteria(JazzTable.class);
        criteria.setMaxResults(limit);
        if (criteria.list().size() == 0)
            return null;
        else return criteria.list();
    }

    @Override
    public List<JazzTable> getByIds(List<String> ids) {
        String hql = "from JazzTable where track_id in (:ids)";
        Query query = super.sessionFactory.getCurrentSession().createQuery(hql);
        query.setParameterList("ids", ids);
        List<JazzTable> list = query.list();
        if (list.size() == 0) {
            return null;
        }else {
            return list;
        }
    }
}
