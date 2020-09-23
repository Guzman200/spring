package com.mx.qd.controller;

import com.mx.qd.model.Modulo_sistema_model;
import com.mx.qd.model.Permiso_model;
import org.json.JSONObject;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class Permiso_controller {
    
    @RequestMapping (value = "select_permiso.do", method = RequestMethod.GET)
    @ResponseBody
    public String select(){
        
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        Permiso_model permiso = (Permiso_model) ctx.getBean("Permiso_model");
        
        JSONObject retorno = new JSONObject();
        retorno.put("data", permiso.select());
        
        return retorno.toString();
    }
    
    @RequestMapping(value = "add_permiso.do", method = RequestMethod.POST)
    @ResponseBody
    public String insert(@RequestParam() String nombre, @RequestParam() String descripcion){
         ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        Permiso_model permiso = (Permiso_model) ctx.getBean("Permiso_model");
        String retorno = "OK";
        
        if(!permiso.insert(nombre, descripcion))
        {
            retorno = "Error al ingresar registro";
        }
        
        return retorno; 
        
    }
    
    @RequestMapping(value = "update_permiso.do", method = RequestMethod.POST)
    @ResponseBody
    public String update(String id, String nombre, @RequestParam() String descripcion){
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        Permiso_model permiso = (Permiso_model) ctx.getBean("Permiso_model");
        String retorno = "OK";
        if(!permiso.update(id, nombre, descripcion)){
            retorno = "Error al modificar";
        }
        
        return retorno;
    }
    
    @RequestMapping(value = "delete_permiso.do", method = RequestMethod.POST)
    @ResponseBody
    public String delete(String id){
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        Permiso_model permiso = (Permiso_model) ctx.getBean("Permiso_model");
        String retorno = "OK";
        
        if(!permiso.delete(id)){
            retorno = "Error al eliminar";
        }
        
        return retorno;
    }
    
}
