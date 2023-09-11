package com.icia.pro.repository;

import com.icia.pro.dto.UsersDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class UserRepository {
    @Autowired
    private SqlSessionTemplate sql;

    public UsersDTO findId(UsersDTO usersDTO) {
        return sql.selectOne("Users.findId", usersDTO);
    }

    public UsersDTO login(UsersDTO usersDTO) {
        return sql.selectOne("Users.login", usersDTO);
    }
}
