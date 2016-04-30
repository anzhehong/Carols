package com.Singing.DAO;

import com.Singing.entity.Track;
import org.hibernate.Query;

import java.util.List;

/**
 * Created by Harold_LIU on 4/30/16.
 */
public class TrackDAOImp extends GeneralDAOImp<Track> implements TrackDAO{
    public TrackDAOImp(Class<Track> classes) {
        super(Track.class);
    }

    @Override
    public List<Track> queryByStar(String artist_id) {
        String hql = "from Artist where artist_id = :m";
        Query query = super.sessionFactory.getCurrentSession().createQuery(hql);
        query.setString("m",artist_id);


        return null;
    }

    @Override
    public List<Track> queryByGroup(String album_id) {
        return null;
    }

    @Override
    public List<Track> queryByName(String track_name) {
        return null;
    }
}
