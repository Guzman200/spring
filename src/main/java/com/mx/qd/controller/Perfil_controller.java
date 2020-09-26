package com.mx.qd.controller;

import com.mx.qd.model.Perfil_model;
import org.json.JSONObject;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class Perfil_controller {
    
    @RequestMapping (value = "select_perfil.do", method = RequestMethod.GET)
    @ResponseBody
    public String select(){
        
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        Perfil_model perfil = (Perfil_model) ctx.getBean("Perfil_model");
        
        JSONObject retorno = new JSONObject();
        retorno.put("data", perfil.select());
        
        return retorno.toString();
    }
    
    @RequestMapping(value = "add_perfil.do", method = RequestMethod.POST)
    @ResponseBody
    public String insert(@RequestParam() String nombre){
         ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        Perfil_model perfil = (Perfil_model) ctx.getBean("Perfil_model");
        String retorno = "OK";
        
        if(!perfil.insert(nombre))
        {
            retorno = "Error al ingresar registro";
        }
        
        return retorno; 
        
    }
    
    @RequestMapping(value = "update_perfil.do", method = RequestMethod.POST)
    @ResponseBody
    public String update(String id, String nombre){
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        Perfil_model perfil = (Perfil_model) ctx.getBean("Perfil_model");
        String retorno = "OK";
        if(!perfil.update(id, nombre)){
            retorno = "Error al modificar";
        }
        
        return retorno;
    }
    
    @RequestMapping(value = "delete_perfil.do", method = RequestMethod.POST)
    @ResponseBody
    public String delete(String id){
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        Perfil_model perfil = (Perfil_model) ctx.getBean("Perfil_model");
        String retorno = "OK";
        
        if(!perfil.delete(id)){
            retorno = "Error al eliminar";
        }
        
        return retorno;
    }
    
    @RequestMapping (value = "select_permisos_perfil.do", method = RequestMethod.GET)
    @ResponseBody
    public String select_permisos_perfil(@RequestParam(required = true) String id_pe){
        
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        Perfil_model perfil = (Perfil_model) ctx.getBean("Perfil_model");
        
        JSONObject retorno = new JSONObject();
        retorno.put("data", perfil.select_permisos_perfil(id_pe));
        
        return retorno.toString();
    }
    
    @RequestMapping(value = "modificar_permisos_perfil.do", method = RequestMethod.POST)
    @ResponseBody
    public String modificar_permisos_perfil(String id_pe, String cadena_permisos){
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        Perfil_model perfil = (Perfil_model) ctx.getBean("Perfil_model");
        String retorno = "OK";
        
        if(!perfil.modificar_permisos_perfil(id_pe, cadena_permisos)){
            retorno = "Error al modificar los permisos";
        }
        
        return retorno;
    }
    
    
    
}
