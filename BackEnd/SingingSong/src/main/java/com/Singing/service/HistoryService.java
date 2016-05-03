package com.Singing.service;

import com.Singing.entity.Song;
import com.Singing.entity.User;

import java.util.List;

/**
 * Created by Harold_LIU on 4/26/16.
 */
public interface HistoryService {
    public List<Song> queryHistory(String userId);
}
