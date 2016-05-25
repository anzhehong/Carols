package com.Singing.service;

import com.Singing.DAO.*;
import com.Singing.controller.RecommendUtil;
import com.Singing.entity.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Harold_LIU on 4/30/16.
 */
@Transactional
@Service
public class MainServiceImp implements MainService {


    @Autowired
    private ArtistDAO artistDAO;
    @Autowired
    private TrackDAO trackDAO;
    @Autowired
    private RankTableDAO rankTableDAO;
    @Autowired
    private TagDAO tagDAO;
    @Autowired
    private RecommendationDAO recommendationDAO;
    @Autowired
    private HistoryDAO historyDAO;

    @Autowired
    private JazzDAO jazzDAO;
    @Autowired
    private PopDAO popDAO;
    @Autowired
    private RockDAO rockDAO;

    @Override
    public List<Song> queryByArtist(String star) {
        List<Song>songs = trackDAO.querySongsByArtistName(star);
        return songs;
    }


    @Override
    public List<Song> queryByAlbum(String album) {
        List<Song>songs = trackDAO.querySongsByAlbum(album);
        return songs;
    }

    @Override
    public List<Song> queryByName(String name) {
        List<Song>songs = trackDAO.querySongsBySongName(name);
        return songs;
    }

    @Override
    public List<RankTable> getSongsByTrackName(String name) {
        return rankTableDAO.getSongsByTrackName(name);
    }

    @Override
    public List<RankTable> getSongsByArtistName(String name) {
        return rankTableDAO.getSongsByArtistName(name);
    }

    @Override
    public List<RankTable> getSongsByTagName(String tag) {
        List<Tag> tags = tagDAO.getTagsByName(tag);
        if (tags.size() == 0) {
            return null;
        }else {
            List<RankTable> results = new ArrayList<RankTable>();
            List<String> strings = new ArrayList<>();
            for (Tag thisTag: tags) {
                strings.add(thisTag.getTrack_id());
            }
            List<RankTable> tables = rankTableDAO.getSongsByTrackIds(strings);

            if ( tables.size() == 0 ) {
                return null;
            }else {
                return tables;
            }
        }
    }

    @Override
    public List<RankTable> getSongsByTrackIdCollection(List<String> ids) {
        return rankTableDAO.getSongsByTrackIds(ids);
    }

    @Override
    public List<Recommendation> getSongsByTrackId(String id) {
        return recommendationDAO.getByTrackId(id);
    }

    @Override
    public List<Recommendation> getSongsByTrackIds(List<String> ids) {
        return recommendationDAO.getByIds(ids);
    }

    @Override
    public List<JazzTable> getSongsByTrackIdsForJazz(List<String> ids) {
        return jazzDAO.getByIds(ids);
    }

    @Override
    public boolean recordUserHistory(int userId, String trackId) {
        List<History> histories = historyDAO.getHistoriesByUserId(RecommendUtil.transforToStrUserId(userId));
        for (int i = 0; i< histories.size(); i ++) {
            if (histories.get(i).getTrack_id().equals(trackId)) {
                History history = historyDAO.queryByIntId(histories.get(i).getHistory_id());
                history.setPlays(history.getPlays() + 1);
                historyDAO.update(history);
                return true;
            }
        }

        History newHistory = new History();
        newHistory.setUser_id(RecommendUtil.transforToStrUserId(userId));
        newHistory.setTrack_id(trackId);
        newHistory.setPlays(1);
        historyDAO.insert(newHistory);
        return true;
    }

    @Override
    public List<History> getHistory(int userId) {
        String id = RecommendUtil.transforToStrUserId(userId);
        return historyDAO.getHistoriesByUserId(id);
    }

    @Override
    public List<JazzTable> getJazzRankList(int limit) {
        return jazzDAO.getJazzRankList(limit);
    }

    @Override
    public List<PopTable> getPopRankList(int limit) {
        return popDAO.getPopRankList(limit);
    }

    @Override
    public List<RockTable> getRockRankList(int limit) {
        return rockDAO.getRockRankList(limit);
    }
}
