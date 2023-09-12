package com.icia.pro.repository;

import com.icia.pro.dto.CustomerDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class CustomerRepository {
    @Autowired
    private SqlSessionTemplate sql;

    public List<CustomerDTO> read(String cphone) {
        return sql.selectList("Customer.read", cphone);
    }
}
