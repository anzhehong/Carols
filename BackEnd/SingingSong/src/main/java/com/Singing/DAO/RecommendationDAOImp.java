package com.Singing.DAO;

import com.Singing.entity.RankTable;
import com.Singing.entity.Recommendation;
import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by fowafolo
 * Date: 16/5/24
 * Time: 11:17
 */

@Repository
public class RecommendationDAOImp extends GeneralDAOImp<Recommendation> implements RecommendationDAO {

    public RecommendationDAOImp (){
        super(Recommendation.class);
    }

    @Override
    public List<Recommendation> getByTrackId(String id) {
        String hql = "from Recommendation where track_id = :m";
        Query query = super.sessionFactory.getCurrentSession().createQuery(hql);
        query.setString("m", id);
        List<Recommendation> list = query.list();
        if (list.size() == 0) {
            return null;
        }else {
            return list;
        }
    }

    @Override
    public Recommendation getByTrackOneId(String id) {
        String hql = "from Recommendation where track_id = :m";
        Query query = super.sessionFactory.getCurrentSession().createQuery(hql);
        query.setString("m", id);
        Recommendation recommendation = (Recommendation) query.uniqueResult();
        if (recommendation != null ) {
            return recommendation;
        }
        return null;
    }

    @Override
    public List<Recommendation> getByIds(List<String> ids) {
        String hql = "from Recommendation where track_id in (:ids)";
        Query query = super.sessionFactory.getCurrentSession().createQuery(hql);
        query.setParameterList("ids", ids);
        List<Recommendation> list = query.list();
        if (list.size() == 0) {
            return null;
        }else {
            return list;
        }
    }
}
