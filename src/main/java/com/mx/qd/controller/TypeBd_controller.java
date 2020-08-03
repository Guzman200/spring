package com.mx.qd.controller;

import com.mx.qd.model.TypeBd_model;
import org.json.JSONObject;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class TypeBd_controller {

    @RequestMapping(value = "type_bd.do")
    public ModelAndView typebd() {
        
        ModelAndView mv = new ModelAndView();
        mv.setViewName("type_bd");

        return mv;
    }

    @RequestMapping(value = "select_bd.do", method = RequestMethod.GET)
    @ResponseBody
    public String select() {
        
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        TypeBd_model type_bd = (TypeBd_model) ctx.getBean("TypeBd_model");
        
        JSONObject retorno = new JSONObject();
        retorno.put("data", type_bd.select());
        
        return retorno.toString();
    }
    
    @RequestMapping(value = "add_bd.do", method = RequestMethod.POST)
    @ResponseBody
    public String add(@RequestParam(required = false) String nombre, @RequestParam(required = false) String desc){
        
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        TypeBd_model typebd = (TypeBd_model) ctx.getBean("TypeBd_model");
        String retorno = "OK";
        
        if(!typebd.insert(nombre, desc))
        {
            retorno = "Error al ingresar registro";
        }
        
        return retorno;   
    }
    
    @RequestMapping ( value = "edit_bd.do", method = RequestMethod.POST)
    @ResponseBody
    public String edit(@RequestParam() String id, @RequestParam() String nombre, @RequestParam() String desc){
        
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        TypeBd_model typedb = (TypeBd_model) ctx.getBean("TypeBd_model");
        String retorno = "OK";
        
        if(!typedb.update(id, nombre, desc)){
            retorno = "Error al intentar modificar";
        }
  
        return retorno;
    }
    
    @RequestMapping( value = "delete_bd.do", method = RequestMethod.POST)
    @ResponseBody
    public String delete(@RequestParam() String id){
        // Agregar status
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        TypeBd_model typebd = (TypeBd_model) ctx.getBean("TypeBd_model");
        String retorno = "OK";
        if(!typebd.delete(id)){
             retorno = "Error al intentar eliminar";
        }
        
        return retorno;
    }
    
    
}
