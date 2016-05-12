package com.Singing.service;

import com.Singing.DAO.ArtistDAO;
import com.Singing.DAO.RankTableDAO;
import com.Singing.DAO.TagDAO;
import com.Singing.DAO.TrackDAO;
import com.Singing.entity.RankTable;
import com.Singing.entity.Song;
import com.Singing.entity.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Harold_LIU on 4/30/16.
 */
@Transactional
@Service
public class MainServiceImp implements MainService {


    @Autowired
    private ArtistDAO artistDAO;
    @Autowired
    private TrackDAO trackDAO;
    @Autowired
    private RankTableDAO rankTableDAO;
    @Autowired
    private TagDAO tagDAO;

    @Override
    public List<Song> queryByArtist(String star) {
        List<Song>songs = trackDAO.querySongsByArtistName(star);
        return songs;
    }


    @Override
    public List<Song> queryByAlbum(String album) {
        List<Song>songs = trackDAO.querySongsByAlbum(album);
        return songs;
    }

    @Override
    public List<Song> queryByName(String name) {
        List<Song>songs = trackDAO.querySongsBySongName(name);
        return songs;
    }

    @Override
    public List<RankTable> getSongsByTrackName(String name) {
        return rankTableDAO.getSongsByTrackName(name);
    }

    @Override
    public List<RankTable> getSongsByArtistName(String name) {
        return rankTableDAO.getSongsByArtistName(name);
    }

    @Override
    public List<RankTable> getSongsByTagName(String tag) {
        List<Tag> tags = tagDAO.getTagsByName(tag);
        if (tags.size() == 0) {
            return null;
        }else {
            List<RankTable> results = new ArrayList<RankTable>();
            for (Tag thisTag: tags) {
                String trackId = thisTag.getTrack_id();
                List<RankTable> tables = rankTableDAO.getSongByTrackId(trackId);
                if (tables != null)
                    if (tables.size() != 0 )
                        results.addAll(tables);
            }
            if ( results.size() == 0 ) {
                return null;
            }else {
                return results;
            }
        }
    }
}
