package com.icia.pro.service;

import com.icia.pro.dto.UsersDTO;
import com.icia.pro.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserService {
    @Autowired
    private UserRepository userRepository;

    public boolean findId(UsersDTO usersDTO) {
        usersDTO = userRepository.findId(usersDTO);
        if(usersDTO !=null){
            return true;
        }
        return false;
    }

    public UsersDTO login(UsersDTO usersDTO) {
        return userRepository.login(usersDTO);
    }
}
