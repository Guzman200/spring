package com.mx.qd.controller;

import com.mx.qd.model.Usuario_model;
import org.json.JSONObject;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class Usuario_controller {
    
    @RequestMapping(value = "select_usuarios.do", method = RequestMethod.GET)
    @ResponseBody
    public String select(){
        
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        Usuario_model usuario = (Usuario_model) ctx.getBean("Usuario_model");
        
        JSONObject retorno = new JSONObject();
        retorno.put("data", usuario.select());
        
        return retorno.toString();
        
    }
    
    @RequestMapping(value = "add_usuarios.do", method = RequestMethod.POST)
    @ResponseBody
    public String insert(
            @RequestParam () String login,
            @RequestParam () String password,
            @RequestParam () String id_pe
    ){
        
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        Usuario_model usuario = (Usuario_model) ctx.getBean("Usuario_model");
        String retorno = "OK";
        if(!usuario.insert(login, password, id_pe)){
            retorno = "Error al ingresar registro";
        }
      
        return retorno;
    }
    
    @RequestMapping(value = "update_usuarios.do", method = RequestMethod.POST)
    @ResponseBody
    public String update(
            @RequestParam () String login,
            @RequestParam () String password,
            @RequestParam () String id_pe,
            @RequestParam () String id_u
    ){
        
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        Usuario_model usuario = (Usuario_model) ctx.getBean("Usuario_model");
        String retorno = "OK";
        if(!usuario.update(login, password, id_pe, id_u)){
            retorno = "Error al modificar";
        }
      
        return retorno;
    }
    
    @RequestMapping(value = "delete_usuarios.do", method = RequestMethod.POST)
    @ResponseBody
    public String delte(@RequestParam () String id_u){
        
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        Usuario_model usuario = (Usuario_model) ctx.getBean("Usuario_model");
        String retorno = "OK";
        if(!usuario.delete(id_u)){
            retorno = "Error al eliminar";
        }
      
        return retorno;
    }
    
}
