package com.Singing.controller;

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


    @RequestMapping("")
    public String homePage()
    {
        return "home";
    }

}
