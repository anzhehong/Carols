package com.Singing.DAO;

import com.Singing.entity.Artist;
import com.Singing.entity.History;
import com.Singing.entity.Song;
import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Harold_LIU on 4/30/16.
 */
@Repository
public class HistoryDAOImp extends GeneralDAOImp<History> implements HistoryDAO{
    public HistoryDAOImp() {
        super(History.class);
    }

    @Override
    public List<Song> queryHistory(String userId) {
        return null;
    }
}
