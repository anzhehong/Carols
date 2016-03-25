package com.Singing.controller;

import com.Singing.service.MusicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by fowafolo
 * Date: 16/1/3
 */

@Controller
@RequestMapping("")
public class MainController {

    @Autowired
    private MusicService musicService;

    @RequestMapping("")
    public String homePage()
    {
        return "home";
    }

    @RequestMapping("/getAllMusics")
    @ResponseBody
    public Map<String, Object> showContractInServiceByElderId()
    {
        Map<String ,Object> result = new HashMap<String, Object>();

        result.put("error",false);
        result.put("musics",musicService.getAllMusics());

        return result;
    }
}
