package com.Singing.controller;

import com.Singing.entity.Song;
import com.Singing.service.MainService;
import com.Singing.service.RankService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Harold_LIU on 5/3/16.
 */
@Controller
@RequestMapping("/Rank")
public class RankListController {

    @Autowired
    private RankService rankService;

    @RequestMapping("/All")
    @ResponseBody
    public Map<String, Object> requireAllRank()
    {
        Map<String ,Object> result = new HashMap<String, Object>();
        List<Song> songs = rankService.queryAllSongs();
        result.put("songs",songs);
        if (songs.size() == 0 )
            result.put("status",201);
        else
            result.put("status",200);
        return result;
    }

    @RequestMapping("/pop")
    @ResponseBody
    public Map<String, Object> requirePopRank()
    {
        Map<String ,Object> result = new HashMap<String, Object>();
        List<Song> songs = rankService.queryPopSongs();
        result.put("songs",songs);
        if (songs.size() == 0 )
            result.put("status",201);
        else
            result.put("status",200);
        return result;
    }

    @RequestMapping("/jazz")
    @ResponseBody
    public Map<String, Object> requireJazzRank()
    {
        Map<String ,Object> result = new HashMap<String, Object>();
        List<Song> songs = rankService.queryJazzSongs();
        result.put("songs",songs);
        if (songs.size() == 0 )
            result.put("status",201);
        else
            result.put("status",200);
        return result;
    }

    @RequestMapping("/r&b")
    @ResponseBody
    public Map<String, Object> requireRBRank()
    {
        Map<String ,Object> result = new HashMap<String, Object>();
        List<Song> songs = rankService.queryRBSongs();
        result.put("songs",songs);
        if (songs.size() == 0 )
            result.put("status",201);
        else
            result.put("status",200);
        return result;
    }




}
