package com.Singing.DAO;

import com.Singing.entity.Song;
import com.Singing.entity.Track;

import java.util.List;

/**
 * Created by Harold_LIU on 4/30/16.
 */
public interface TrackDAO extends GeneralDAO<Track>{
    public List<Track> queryByStar(String artist_id);
    public List<Track> queryByGroup(String album_id);
    public List<Track> queryByName(String track_name);
    public List<Track> queryByHot(float hotness);
    public List<Track> queryByYear(String year);
    public List<Track> queryByTrackId(String track_id);

}
