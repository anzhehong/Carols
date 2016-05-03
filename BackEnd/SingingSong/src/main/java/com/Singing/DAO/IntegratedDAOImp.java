package com.Singing.DAO;

import com.Singing.entity.Artist;
import com.Singing.entity.Song;
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
public class IntegratedDAOImp extends GeneralDAOImp<Song> implements IntegratedDAO{

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
}
