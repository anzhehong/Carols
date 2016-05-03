package com.Singing.DAO;

import com.Singing.entity.Artist;
import com.Singing.entity.Song;
import com.Singing.entity.Tag;

import java.util.List;

/**
 * Created by Harold_LIU on 4/30/16.
 */
public interface TagDAO extends GeneralDAO<Tag>{
    public List<Song> queryAllSongs();
    public List<Song> queryJazzSongs();
    public List<Song> queryPopSongs();
    public List<Song> queryRBSongs();
}
