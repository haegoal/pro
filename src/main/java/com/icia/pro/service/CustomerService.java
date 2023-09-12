package com.icia.pro.service;

import com.icia.pro.dto.CustomerDTO;
import com.icia.pro.repository.CustomerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CustomerService {
    @Autowired
    private CustomerRepository customerRepository;

    public List<CustomerDTO> read(String cphone) {
        return customerRepository.read(cphone);
    }
}
