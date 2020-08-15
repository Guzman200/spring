package com.mx.qd.controller;

import com.mx.qd.model.ControlUno_model;
import com.mx.qd.model.Formato_model;
import org.json.JSONObject;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class Formato_controller {
    
    @RequestMapping(value = "select_formato.do")
    @ResponseBody
    public String select(){
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        Formato_model formato = (Formato_model) ctx.getBean("Formato_model");
        
        JSONObject retorno = new JSONObject();
        retorno.put("data", formato.select());
        
        return retorno.toString();
    }
}
