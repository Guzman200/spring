package com.mx.qd.controller;

import com.mx.qd.model.Modulo_sistema_model;
import com.mx.qd.model.Modulo_model;
import com.mx.qd.model.Perfil_model;
import org.json.JSONObject;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class Modulo_sistema_controller {
    
    @RequestMapping (value = "select_modulo_sistema.do", method = RequestMethod.GET)
    @ResponseBody
    public String select(){
        
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        Modulo_sistema_model modulo = (Modulo_sistema_model) ctx.getBean("Modulo_sistema_model");
        
        JSONObject retorno = new JSONObject();
        retorno.put("data", modulo.select());
        
        return retorno.toString();
    }
    
    @RequestMapping(value = "add_modulo_sistema.do", method = RequestMethod.POST)
    @ResponseBody
    public String insert(@RequestParam() String nombre,@RequestParam() String descripcion){
         ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        Modulo_sistema_model modulo = (Modulo_sistema_model) ctx.getBean("Modulo_sistema_model");
        String retorno = "OK";
        
        if(!modulo.insert(nombre,descripcion))
        {
            retorno = "Error al ingresar registro";
        }
        
        return retorno; 
        
    }
    
    @RequestMapping(value = "update_modulo_sistema.do", method = RequestMethod.POST)
    @ResponseBody
    public String update(String id, String nombre,@RequestParam() String descripcion){
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        Modulo_sistema_model modulo = (Modulo_sistema_model) ctx.getBean("Modulo_sistema_model");
        String retorno = "OK";
        if(!modulo.update(id, nombre,descripcion)){
            retorno = "Error al modificar";
        }
        
        return retorno;
    }
    
    @RequestMapping(value = "delete_modulo_sistema.do", method = RequestMethod.POST)
    @ResponseBody
    public String delete(String id){
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        Modulo_sistema_model modulo = (Modulo_sistema_model) ctx.getBean("Modulo_sistema_model");
        String retorno = "OK";
        
        if(!modulo.delete(id)){
            retorno = "Error al eliminar";
        }
        
        return retorno;
    }
}
