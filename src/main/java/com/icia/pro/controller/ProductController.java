package com.icia.pro.controller;

import com.icia.pro.dto.ProductDTO;
import com.icia.pro.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ProductController {
    @Autowired
    private ProductService productService;

    public ProductDTO read(@RequestParam("key") String key,@RequestParam("query") String query){
        ProductDTO productDTO = productService.read(key, query);
        System.out.println(productDTO);
        return productDTO;
    }
}
