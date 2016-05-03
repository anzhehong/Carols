package com.Singing.service;

import com.Singing.DAO.LoginDAO;
import com.Singing.DAO.TagDAO;
import com.Singing.entity.Song;
import com.Singing.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by Harold_LIU on 4/26/16.
 */

@Transactional
@Service
public class RankServiceImp implements RankService {

    @Autowired
    private TagDAO tagDAO;

    @Override
    public List<Song> queryAllSongs() {
        List<Song>songs = tagDAO.queryAllSongs();
        return  songs;
    }

    @Override
    public List<Song> queryJazzSongs() {
        List<Song>songs = tagDAO.queryJazzSongs();
        return  songs;
    }

    @Override
    public List<Song> queryPopSongs() {
        List<Song>songs = tagDAO.queryPopSongs();
        return  songs;
    }

    @Override
    public List<Song> queryRBSongs() {
        List<Song>songs = tagDAO.queryRBSongs();
        return  songs;
    }
}

