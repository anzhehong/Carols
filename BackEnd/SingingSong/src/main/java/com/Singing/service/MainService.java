package com.Singing.service;

import com.Singing.entity.Song;

import java.util.List;

/**
 * Created by Harold_LIU on 4/30/16.
 */
public interface MainService {
    public List<Song> queryByArtist(String star);
    public List<Song> queryByAlbum(String album);
    public List<Song> queryByName(String name);

}
