package com.icia.pro.service;

import com.icia.pro.dto.ProductDTO;
import com.icia.pro.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ProductService {
    @Autowired
    private ProductRepository productRepository;

    public ProductDTO read(String key, String query) {
        return productRepository.read(key, query);
    }
}
