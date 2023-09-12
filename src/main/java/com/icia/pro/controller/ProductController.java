package com.icia.pro.controller;

import com.icia.pro.dto.ProductDTO;
import com.icia.pro.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/product")
public class ProductController {
    @Autowired
    private ProductService productService;

    @GetMapping("/read")
    public ResponseEntity read(@RequestParam("key") String key,@RequestParam("query") String query){
        Map<String, String> map = new HashMap<>();
        map.put("key", key);
        map.put("query", query);
        ProductDTO productDTO = productService.read(map);
        if(productDTO!=null){
            return new ResponseEntity<>(productDTO, HttpStatus.OK);
        }else{
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
}
