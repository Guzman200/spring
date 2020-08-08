package com.mx.qd.controller;

import com.mx.qd.model.Modulo_model;
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
public class Modulo_controller {
    
     @RequestMapping(value = "modulo.do")
    public ModelAndView typebd() {
        
        ModelAndView mv = new ModelAndView();
        mv.setViewName("modulo");

        return mv;
    }

    @RequestMapping(value = "select_modulo.do", method = RequestMethod.GET)
    @ResponseBody
    public String select() {
        
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        Modulo_model modulo = (Modulo_model) ctx.getBean("Modulo_model");
        
        JSONObject retorno = new JSONObject();
        retorno.put("data", modulo.select());
        
        return retorno.toString();
    }
    
    @RequestMapping(value = "add_modulo.do", method = RequestMethod.POST)
    @ResponseBody
    public String add(@RequestParam(required = false) String nombre, @RequestParam(required = false) String desc){
        
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        Modulo_model modulo = (Modulo_model) ctx.getBean("Modulo_model");
        String retorno = "OK";
        
        if(!modulo.insert(nombre, desc))
        {
            retorno = "Error al ingresar registro";
        }
        
        return retorno;   
    }
    
    @RequestMapping ( value = "edit_modulo.do", method = RequestMethod.POST)
    @ResponseBody
    public String edit(@RequestParam() String id, @RequestParam() String nombre, @RequestParam() String desc){
        
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        Modulo_model modulo = (Modulo_model) ctx.getBean("Modulo_model");
        String retorno = "OK";
        
        if(!modulo.update(id, nombre, desc)){
            retorno = "Error al intentar modificar";
        }
  
        return retorno;
    }
    
    @RequestMapping( value = "delete_modulo.do", method = RequestMethod.POST)
    @ResponseBody
    public String delete(@RequestParam() String id){
        // Agregar status
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        Modulo_model modulo = (Modulo_model) ctx.getBean("Modulo_model");
        String retorno = "OK";
        if(!modulo.delete(id)){
             retorno = "Error al intentar eliminar";
        }
        
        return retorno;
    }
}
