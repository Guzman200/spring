package com.mx.qd.controller;

import com.mx.qd.model.TypeCard_model;
import com.mx.qd.model.TypeGrafica_model;
import org.json.JSONObject;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class TypeGrafica_controller {
    
    @RequestMapping( value = "type_grafica.do")
    public ModelAndView index(){
        
        ModelAndView mav = new ModelAndView();
        mav.setViewName("type_grafica");
        
        return mav;
    }
    
    @RequestMapping(value = "select_grafica.do", method = RequestMethod.GET)
    @ResponseBody
    public String select(){
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        TypeGrafica_model grafica = (TypeGrafica_model) ctx.getBean("TypeGrafica_model");
        
        JSONObject retorno = new JSONObject();
        retorno.put("data", grafica.select());
        
        return retorno.toString();
    }
    
    @RequestMapping(value = "edit_grafica.do", method = RequestMethod.POST)
    @ResponseBody
    public String editar(@RequestParam() String id, @RequestParam() String tipo, @RequestParam() String desc){
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        TypeGrafica_model grafica = (TypeGrafica_model) ctx.getBean("TypeGrafica_model");
        String retorno = "OK";
        if(!grafica.edit(id, tipo, desc)){
             retorno = "Error al intentar editar";
        }
        return retorno;
    }
    
    @RequestMapping(value = "delete_grafica.do", method = RequestMethod.POST)
    @ResponseBody
    public String delete(@RequestParam() String id){
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        TypeGrafica_model grafica = (TypeGrafica_model) ctx.getBean("TypeGrafica_model");
        String retorno = "OK";
        if(!grafica.delete(id)){
             retorno = "Error al intentar eliminar";
        }
        return retorno;
    }
    
    @RequestMapping(value = "add_grafica.do", method = RequestMethod.POST)
    @ResponseBody
    public String add(@RequestParam() String tipo, @RequestParam() String desc){
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        TypeGrafica_model grafica = (TypeGrafica_model) ctx.getBean("TypeGrafica_model");
        String retorno = "OK";
        if(!grafica.insert(tipo, desc)){
             retorno = "Error al intentar registrar";
        }
        return retorno;
    }
    
}
