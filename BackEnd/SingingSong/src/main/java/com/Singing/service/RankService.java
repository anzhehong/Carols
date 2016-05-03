package com.Singing.service;

import com.Singing.entity.Song;
import com.Singing.entity.User;

import java.util.List;

/**
 * Created by Harold_LIU on 4/26/16.
 */
public interface RankService {
    public List<Song> queryAllSongs();
    public List<Song> queryJazzSongs();
    public List<Song> queryPopSongs();
    public List<Song> queryRBSongs();

}
