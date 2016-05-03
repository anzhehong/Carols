package com.Singing.service;

import com.Singing.DAO.ArtistDAO;
import com.Singing.DAO.IntegratedDAO;
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
    private IntegratedDAO integratedDAO;

    @Override
    public List<Song> queryByArtist(String star) {
        List<Song>songs = integratedDAO.querySongsByArtistName(star);
        return songs;
    }

    @Override
    public List<Song> queryByAlbum(String album) {
        List<Song>songs = integratedDAO.querySongsByAlbum(album);
        return songs;
    }

    @Override
    public List<Song> queryByName(String name) {
        List<Song>songs = integratedDAO.querySongsBySongName(name);
        return songs;
    }

    @Override
    public List<Song> queryByRecommend() {
        return null;
    }
}
