package com.Singing.service;

import com.Singing.DAO.ArtistDAO;
import com.Singing.DAO.TrackDAO;
import com.Singing.entity.Artist;
import com.Singing.entity.Song;
import com.Singing.entity.Track;
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
}
