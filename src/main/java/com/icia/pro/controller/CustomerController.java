package com.icia.pro.controller;

import com.icia.pro.dto.CustomerDTO;
import com.icia.pro.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/customer")
public class CustomerController {
    @Autowired
    private CustomerService customerService;

    @GetMapping("/read")
    private ResponseEntity read(@RequestParam("cphone") String cphone){
        List<CustomerDTO> customerDTOList = customerService.read(cphone);
        if(customerDTOList.size()==0){
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }else{
            return new ResponseEntity<>(customerDTOList, HttpStatus.OK);
        }

    }
}
