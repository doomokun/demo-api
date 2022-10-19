package com.example.apidemo.code.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(path = "/health-check")
public class HealthCheckController {
    @Autowired
    private Environment environment;

    @GetMapping
    public @ResponseBody String get() {
        return environment.getRequiredProperty("app-version");
    }
}
