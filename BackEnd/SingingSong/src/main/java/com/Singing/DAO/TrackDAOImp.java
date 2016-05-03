package com.Singing.DAO;

import com.Singing.entity.Song;
import com.Singing.entity.Track;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Harold_LIU on 4/30/16.
 */
@Repository
public class TrackDAOImp extends GeneralDAOImp<Track> implements TrackDAO{
    public TrackDAOImp() {
        super(Track.class);
    }

    @Override
    public List<Track> queryByStar(String artist_id) {
        String hql = "from Track where artist_id = :m";
        Query query = super.sessionFactory.getCurrentSession().createQuery(hql);
        query.setString("m",artist_id);
        if (query.list().size() == 0)
            return null;
        else return query.list();
    }

    @Override
    public List<Track> queryByGroup(String album_id) {
        String hql = "from Track where album_id = :m";
        Query query = super.sessionFactory.getCurrentSession().createQuery(hql);
        query.setString("m",album_id);
        if (query.list().size() == 0)
            return null;
        else return query.list();
    }

    @Override
    public List<Track> queryByName(String track_name) {
        String hql = "from Track where track_name = :m";
        Query query = super.sessionFactory.getCurrentSession().createQuery(hql);
        query.setString("m", track_name);
        if (query.list().size() == 0)
            return null;
        else return query.list();
    }

    @Override
    public List<Track> queryByHot(float hotness) {
        String hql = "from Track where track_hotness = :m";
        Query query = super.sessionFactory.getCurrentSession().createQuery(hql);
        query.setFloat("m", hotness);
        if (query.list().size() == 0)
            return null;
        else return query.list();
    }

    @Override
    public List<Track> queryByYear(String year) {
        String hql = "from Track where year = :m";
        Query query = super.sessionFactory.getCurrentSession().createQuery(hql);
        query.setString("m",year);
        if (query.list().size() == 0)
            return null;
        else return query.list();
    }

    @Override
    public List<Track> queryByTrackId(String track_id) {
        String hql = "from Track where track_id = :m";
        Query query = super.sessionFactory.getCurrentSession().createQuery(hql);
        query.setString("m", track_id);
        if (query.list().size() == 0)
            return null;
        else return query.list();
    }

}
