package com.Singing.DAO;

import com.Singing.entity.Artist;
import com.Singing.entity.Song;

import java.util.List;

/**
 * Created by Harold_LIU on 4/30/16.
 */
public interface IntegratedDAO extends GeneralDAO<Song>{
    public List<Song> querySongsByArtistName(String artist_name);
    public List<Song> querySongsByAlbum(String albumName);
    public List<Song> querySongsBySongName(String name);
}
