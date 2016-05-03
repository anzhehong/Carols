package com.Singing.controller;

import com.Singing.entity.Song;
import com.Singing.service.HistoryService;
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
@RequestMapping("/Playhistory")
public class HistoryListController {

    @Autowired
    private HistoryService historyService;

    @RequestMapping("")
    @ResponseBody
    public Map<String, Object> requireHistory(String userId)
    {
        Map<String ,Object> result = new HashMap<String, Object>();
        List<Song> songs = historyService.queryHistory(userId);
        result.put("songs",songs);
        if (songs.size() == 0 )
            result.put("status",201);
        else
            result.put("status",200);
        return result;
    }


}
