package com.Singing.service;

import com.Singing.entity.RankTable;
import com.Singing.entity.Recommendation;
import com.Singing.entity.Song;

import java.util.List;

/**
 * Created by Harold_LIU on 4/30/16.
 */
public interface MainService {
    public List<Song> queryByArtist(String star);
    public List<Song> queryByAlbum(String album);
    public List<Song> queryByName(String name);


    public List<RankTable> getSongsByTrackName(String name);
    public List<RankTable> getSongsByArtistName(String name);
    public List<RankTable> getSongsByTagName(String tag);

    public List<Recommendation> getSongsByTrackId(String id);
    public List<Recommendation> getSongsByTrackIds(List<String> ids);

    public boolean recordUserHistory(int userId, String trackId);

}
