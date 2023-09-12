package com.icia.pro.service;

import com.icia.pro.dto.ProductDTO;
import com.icia.pro.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
public class ProductService {
    @Autowired
    private ProductRepository productRepository;


    public ProductDTO read(Map<String, String> map) {
        return productRepository.read(map);
    }
}
