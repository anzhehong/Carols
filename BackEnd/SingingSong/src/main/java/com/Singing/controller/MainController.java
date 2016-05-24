package com.Singing.controller;

import com.Singing.entity.AAError;
import com.Singing.entity.History;
import com.Singing.entity.RankTable;
import com.Singing.entity.Recommendation;
import com.Singing.service.MainService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by fowafolo
 * Date: 16/1/3
 */

@Controller
@RequestMapping("/Main")
public class MainController {

    @Autowired
    private MainService mainService;

//    @RequestMapping("/ByStars")
//    @ResponseBody
//    public Map<String, Object> requireByStars(String artistName)
//    {
//        Map<String ,Object> result = new HashMap<String, Object>();
//
//        List<Song>songs = mainService.queryByArtist(artistName);
//        result.put("songs",songs);
//        if (songs.size() == 0 )
//            result.put("status",201);
//        else
//            result.put("status",200);
//        return result;
//    }
//
//    @RequestMapping("/ByGroup")
//    @ResponseBody
//    public Map<String, Object> requireByGroup(String GroupName)
//    {
//        Map<String ,Object> result = new HashMap<String, Object>();
//        List<Song>songs = mainService.queryByAlbum(GroupName);
//        result.put("songs",songs);
//        if (songs.size() == 0 )
//            result.put("status",201);
//        else
//            result.put("status",200);
//        return result;
//    }
//
//    @RequestMapping("/ByName")
//    @ResponseBody
//    public Map<String, Object> requireByName(String SongName)
//    {
//        Map<String ,Object> result = new HashMap<String, Object>();
//        List<Song>songs = mainService.queryByName(SongName);
//        result.put("songs",songs);
//        if (songs.size() == 0 )
//            result.put("status",201);
//        else
//            result.put("status",200);
//        return result;
//    }
//
//    @RequestMapping("/ByRecommend")
//    @ResponseBody
//    public Map<String, Object> requireByRecommend()
//    {
//        Map<String ,Object> result = new HashMap<String, Object>();
//
//        return result;
//    }

    @RequestMapping("/SongsByStarName")
    @ResponseBody
    public Map<String, Object> songsByStarName(String artistName)
    {
        List<RankTable>songs = mainService.getSongsByArtistName(artistName);
        return querySongsHandler(songs);
    }

    @RequestMapping("/SongsBySongName")
    @ResponseBody
    public Map<String, Object> songsBySongName(String name)
    {
        List<RankTable>songs = mainService.getSongsByTrackName(name);
        return querySongsHandler(songs);
    }

    @RequestMapping("/SongsByTagName")
    @ResponseBody
    public Map<String, Object> songsByTagName(String name)
    {
        List<RankTable>songs = mainService.getSongsByTagName(name);
        return querySongsHandler(songs);
    }

    public Map<String, Object> querySongsHandler(List<RankTable> songs) {
        Map<String ,Object> result = new HashMap<String, Object>();
        if (songs != null) {
            if (songs.size() != 0 ) {
                result.put("status",200);
                result.put("songs",songs);
                return result;
            }
        }
        result.put("status",201);
        AAError aaError = new AAError("No songs related");
        result.put("error", aaError);
        return result;
    }

    @RequestMapping("getRecommendByUserId")
    @ResponseBody
    public Map<String, Object> getRecommendByUserId(int userId) {
        Map<String ,Object> result = new HashMap<String, Object>();



        String pythonPath = System.getProperty("web.root") + "WEB-INF";
        System.out.println(pythonPath);
        List<String> trackIds = RecommendUtil.getTrackIds(userId, pythonPath);
        List<RankTable> songs = transforFromRecommendation(mainService.getSongsByTrackIds(trackIds));
        return querySongsHandler(songs);
    }

    private List<RankTable> transforFromRecommendation(List<Recommendation> list) {
        List<RankTable> result = new ArrayList<>();
        for (int i = 0 ; i < list.size(); i++ ) {
            Recommendation recommendation = list.get(i);
            RankTable rankTable = new RankTable(
                    recommendation.getTrack_id(),
                    recommendation.getTrack_name(),
                    recommendation.getArtist_name(),
                    recommendation.getAlbum_image(),
                    recommendation.getOriginal_url(),
                    recommendation.getInstra_url(),
                    recommendation.getLyrics());
            result.add(rankTable);
        }
        return result;
    }

    @RequestMapping("recordHistory")
    @ResponseBody
    public Map<String, Object> recordByUserIdAndTrackId(int userId, String trackId) {
        Map<String ,Object> result = new HashMap<String, Object>();

        boolean flag = mainService.recordUserHistory(userId, trackId);
        if (flag == true) {
            result.put("status", 200);
            result.put("message", "Done");
            return result;
        }
        result.put("status",202);
        AAError aaError = new AAError("Record User History Error.");
        result.put("error", aaError);
        return result;
    }

    @RequestMapping("getHistory")
    @ResponseBody
    public Map<String, Object> getHistoryByUserIdAndTrackId(int userId) {
        Map<String ,Object> result = new HashMap<String, Object>();

        List<History> list = mainService.getHistory(userId);
        if (list!=null ){
            if (list.size()!=0) {
                List<String> trackIds = new ArrayList<>();
                for (int i = 0 ; i < list.size() ; i ++ ) {
                    trackIds.add(list.get(i).getTrack_id());
                }

                if (trackIds.size() > 0 ) {
                    List<RankTable> songs = transforFromRecommendation(mainService.getSongsByTrackIds(trackIds));
                    return querySongsHandler(songs);
                }
            }
        }
        result.put("status",203);
        AAError aaError = new AAError("Cannot get this record now.");
        result.put("error", aaError);
        return result;
    }

    @RequestMapping("")
    public String homePage()
    {

        return "Hallo";
    }
}
