package com.Singing.controller;

import com.Singing.service.MainService;
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
@RequestMapping("/Main")
public class MainController {

    @Autowired
    private MainService mainService;

    @RequestMapping("/ByStars")
    @ResponseBody
    public Map<String, Object> requireByStars(String artistName)
    {
        Map<String ,Object> result = new HashMap<String, Object>();


        return result;
    }

    @RequestMapping("/ByGroup")
    @ResponseBody
    public Map<String, Object> requireByGroup(String GroupName)
    {
        Map<String ,Object> result = new HashMap<String, Object>();


        return result;
    }

    @RequestMapping("/ByName")
    @ResponseBody
    public Map<String, Object> requireByName(String SongName)
    {
        Map<String ,Object> result = new HashMap<String, Object>();


        return result;
    }

    @RequestMapping("/ByRecommend")
    @ResponseBody
    public Map<String, Object> requireByRecommend()
    {
        Map<String ,Object> result = new HashMap<String, Object>();


        return result;
    }

    @RequestMapping("")
    public String homePage()
    {
        return "Hallo";
    }

}
