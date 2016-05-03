package com.Singing.service;

import com.Singing.DAO.HistoryDAO;
import com.Singing.DAO.LoginDAO;
import com.Singing.entity.History;
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
public class HistoryServiceImp implements HistoryService {

    @Autowired
    private HistoryDAO historyDAO;

    @Override
    public List<Song> queryHistory(String userId) {
        List<Song>songs = historyDAO.queryHistory(userId);
        return  songs;
    }
}

