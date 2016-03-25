package com.Singing.service;

import com.Singing.DAO.MusicDAO;
import com.Singing.entity.Music;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

/**
 * Created by fowafolo
 * Date: 16/3/25
 * Time: 11:35
 */

@Transactional
@Service
public class MusicServiceImp implements MusicService {

    @Autowired
    private MusicDAO musicDAO;

    @Override
    public List<Music> getAllMusics() {
        return musicDAO.queryAll();
    }
}
