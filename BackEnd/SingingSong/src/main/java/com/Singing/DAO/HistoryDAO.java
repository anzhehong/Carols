package com.Singing.DAO;

import com.Singing.entity.Artist;
import com.Singing.entity.History;
import com.Singing.entity.Song;

import java.util.List;

/**
 * Created by Harold_LIU on 4/30/16.
 */
public interface HistoryDAO extends GeneralDAO<History>{
   public List<Song> queryHistory(String userId);
}
