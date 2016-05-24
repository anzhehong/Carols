package com.Singing.DAO;

import com.Singing.entity.RankTable;
import com.Singing.entity.Recommendation;
import com.Singing.entity.Tag;
import com.sun.javafx.scene.control.skin.VirtualFlow;
import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by fowafolo
 * Date: 16/5/12
 * Time: 21:22
 */

@Repository
public class RankTableDAOImp extends GeneralDAOImp<RankTable> implements RankTableDAO {
    public RankTableDAOImp() {
        super(RankTable.class);
    }

    @Override
    public List<RankTable> getSongsByTrackName(String name) {
        String hql = "from RankTable where track_name like :m";
        Query query = super.sessionFactory.getCurrentSession().createQuery(hql);
        query.setString("m", "%" + name + "%");
        List<RankTable> list = query.list();
        if (list.size() == 0) {
            return null;
        }else {
            return list;
        }
    }

    @Override
    public List<RankTable> getSongsByArtistName(String name) {
        String hql = "from RankTable where artist_name like :m";
        Query query = super.sessionFactory.getCurrentSession().createQuery(hql);
        query.setString("m", "%" + name + "%");
        List<RankTable> list = query.list();
        if (list.size() == 0) {
            return null;
        }else {
            return list;
        }
    }

    @Override
    public List<RankTable> getSongByTrackId(String trackId) {
        String hql = "from RankTable where track_id = :m";
        Query query = super.sessionFactory.getCurrentSession().createQuery(hql);
        query.setString("m", trackId);
        List<RankTable> list = query.list();
        if (list.size() == 0) {
            return null;
        }else {
            return list;
        }
    }

    @Override
    public List<RankTable> getSongsByTrackIds(List<String> ids) {
        String hql = "from RankTable where track_id in (:ids)";
        Query query = super.sessionFactory.getCurrentSession().createQuery(hql);
        query.setParameterList("ids", ids);
//        System.out.println(ids);
        List<RankTable> list = query.list();
        if (list.size() == 0) {
            return null;
        }else {
            return list;
        }
    }

}
