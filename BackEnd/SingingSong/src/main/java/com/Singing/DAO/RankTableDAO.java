package com.Singing.DAO;

import com.Singing.entity.RankTable;

import java.util.List;

/**
 * Created by fowafolo
 * Date: 16/5/12
 * Time: 21:22
 */
public interface RankTableDAO extends GeneralDAO<RankTable> {

    public List<RankTable> getSongsByTrackName(String name);
    public List<RankTable> getSongsByArtistName(String name);
    public List<RankTable> getSongByTrackId(String trackId);
}
