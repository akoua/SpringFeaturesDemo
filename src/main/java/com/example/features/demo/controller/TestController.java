package com.example.features.demo.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;


@RestController
@RequestMapping("/test")
public class TestController {

    
    @GetMapping("/path")
    public String test() {
        return "Hello from test";
    }

    @PostMapping("/add")
    public String postMethodName(@RequestBody String entity) {        
        return entity;
    }
    
}
