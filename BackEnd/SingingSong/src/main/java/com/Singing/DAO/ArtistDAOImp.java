package com.Singing.DAO;

import com.Singing.entity.Artist;
import com.Singing.entity.Track;
import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Harold_LIU on 4/30/16.
 */
@Repository
public class ArtistDAOImp extends GeneralDAOImp<Artist> implements ArtistDAO{
    public ArtistDAOImp() {
        super(Artist.class);
    }

    @Override
    public List<Artist> queryByArtistName(String ArtistName) {
        String hql = "from Artist where artist_name = :m";
        Query query = super.sessionFactory.getCurrentSession().createQuery(hql);
        query.setString("m",ArtistName);
        if (query.list().size() == 0)
         return null;
        else return query.list();
    }

    @Override
    public List<Artist> queryByArtistId(String ArtistId) {
        String hql = "from Artist where artist_id = :m";
        Query query = super.sessionFactory.getCurrentSession().createQuery(hql);
        query.setString("m",ArtistId);
        if (query.list().size() == 0)
            return null;
        else return query.list();
    }
}
