package com.yidagv.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AgvController {
    
    @GetMapping(value = "/agv")
    public String index()  {
        return "agv";
    }
    
}
