package com.example.apidemo.code.service;

import com.example.apidemo.code.dao.UserDao;
import com.example.apidemo.code.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService {
    @Autowired
    UserDao userDao;

    public List<User> get() {
        return userDao.findAll();
    }
}
