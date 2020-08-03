package com.mx.qd.controller;

import com.mx.qd.model.TypeGrafica_model;
import com.mx.qd.model.TypeTabla_model;
import org.json.JSONObject;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class TypeTabla_controller {
    
    @RequestMapping( value = "type_tabla.do")
    public ModelAndView index(){
        
        ModelAndView mav = new ModelAndView();
        mav.setViewName("type_tabla");
        
        return  mav;
    }
    
    @RequestMapping(value = "select_tabla.do", method = RequestMethod.GET)
    @ResponseBody
    public String select(){
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        TypeTabla_model tabla = (TypeTabla_model) ctx.getBean("TypeTabla_model");
        
        JSONObject retorno = new JSONObject();
        retorno.put("data", tabla.select());
        
        return retorno.toString();
    }
    
    @RequestMapping(value = "edit_tabla.do", method = RequestMethod.POST)
    @ResponseBody
    public String editar(@RequestParam() String id, @RequestParam() String tipo, @RequestParam() String desc){
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        TypeTabla_model tabla = (TypeTabla_model) ctx.getBean("TypeTabla_model");
        String retorno = "OK";
        if(!tabla.edit(id, tipo, desc)){
             retorno = "Error al intentar editar";
        }
        return retorno;
    }
    
    @RequestMapping(value = "delete_tabla.do", method = RequestMethod.POST)
    @ResponseBody
    public String delete(@RequestParam() String id){
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        TypeTabla_model tabla = (TypeTabla_model) ctx.getBean("TypeTabla_model");
        String retorno = "OK";
        if(!tabla.delete(id)){
             retorno = "Error al intentar eliminar";
        }
        return retorno;
    }
    
    @RequestMapping(value = "add_tabla.do", method = RequestMethod.POST)
    @ResponseBody
    public String add(@RequestParam() String tipo, @RequestParam() String desc){
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        TypeTabla_model tabla = (TypeTabla_model) ctx.getBean("TypeTabla_model");
        String retorno = "OK";
        if(!tabla.insert(tipo, desc)){
             retorno = "Error al intentar registrar";
        }
        return retorno;
    }
    
}
