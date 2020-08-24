package com.mx.qd.controller;

import com.mx.qd.model.TipoCampo_model;
import org.json.JSONObject;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class TipoCampo_controller {
    
    @RequestMapping( value = "select_tipoCampo.do")
    @ResponseBody
    public String select_tipoCampo(){
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        TipoCampo_model tipoCampo = (TipoCampo_model) ctx.getBean("TipoCampo_model");
        JSONObject retorno = new JSONObject();
        retorno.put("data", tipoCampo.select());
        
        return retorno.toString();
    }
    
}
