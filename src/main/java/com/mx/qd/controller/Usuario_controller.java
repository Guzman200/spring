package com.mx.qd.controller;

import com.mx.qd.model.Usuario_model;
import org.json.JSONObject;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class Usuario_controller {
    
    @RequestMapping(value = "select_usuarios.do", method = RequestMethod.GET)
    @ResponseBody
    public String select(){
        
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext();
        Usuario_model usuario = (Usuario_model) ctx.getBean("Usuario_model");
        
        JSONObject retorno = new JSONObject();
        retorno.put("data", usuario.select());
        
        return retorno.toString();
        
    }
    
}
