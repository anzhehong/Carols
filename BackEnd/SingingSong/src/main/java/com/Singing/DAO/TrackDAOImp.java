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
    public List<Song> querySongsByArtistName(String artist_name) {
        Session sessionHb = super.sessionFactory.getCurrentSession();
        String sql = "SELECT Track.track_name,Artist.artist_name,Album.album_name,Album.album_image,Track.original_url FROM carols.Track, carols.Artist,carols.Album where Artist.artist_name LIKE :m and Artist.artist_id = Track.artist_id and Track.album_id = Album.album_id";
        SQLQuery query = sessionHb.createSQLQuery(sql);
        query.setParameter("m", "%"+artist_name+"%");
        query.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
        List<Song> songs = query.list();
        return songs;
    }

    @Override
    public List<Song> querySongsByAlbum(String albumName) {
        Session sessionHb = super.sessionFactory.getCurrentSession();
        String sql = "SELECT Track.track_name,Artist.artist_name,Album.album_name,Album.album_image,Track.original_url FROM carols.Track, carols.Artist,carols.Album where Album.album_name LIKE :m and Artist.artist_id = Track.artist_id and Track.album_id = Album.album_id";
        SQLQuery query = sessionHb.createSQLQuery(sql);
        query.setParameter("m", "%"+albumName+"%");
        query.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
        List<Song> songs = query.list();
        return songs;
    }

    @Override
    public List<Song> querySongsBySongName(String name) {
        Session sessionHb = super.sessionFactory.getCurrentSession();
        String sql = "SELECT Track.track_name,Artist.artist_name,Album.album_name,Album.album_image,Track.original_url FROM carols.Track, carols.Artist,carols.Album where Track.track_name LIKE :m and Artist.artist_id = Track.artist_id and Track.album_id = Album.album_id";
        SQLQuery query = sessionHb.createSQLQuery(sql);
        query.setParameter("m", "%"+name+"%");
        query.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
        List<Song> songs = query.list();
        return songs;
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
