package com.Singing.DAO;

import com.Singing.entity.Artist;
import com.Singing.entity.Track;

import java.util.List;

/**
 * Created by Harold_LIU on 4/30/16.
 */
public interface ArtistDAO extends GeneralDAO<Artist>{
    public List<Artist> queryByArtistName(String artist_id);
    public List<Artist> queryByArtistId(String ArtistId);
}
