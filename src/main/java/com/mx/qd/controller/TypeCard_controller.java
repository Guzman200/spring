package com.mx.qd.controller;

import com.mx.qd.model.TypeCard_model;
import org.json.JSONObject;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class TypeCard_controller {
        
    @RequestMapping(value = "type_card.do")
    public ModelAndView TypeCard_controller(){ 
        
        ModelAndView mav = new ModelAndView();
        mav.setViewName("type_card");
        
        return mav;
    }
    
    @RequestMapping(value = "select_card.do", method = RequestMethod.GET)
    @ResponseBody
    public String select(){
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        TypeCard_model card = (TypeCard_model) ctx.getBean("TypeCard_model");
        
        JSONObject retorno = new JSONObject();
        retorno.put("data", card.select());
        
        return retorno.toString();
    }
    
    @RequestMapping(value = "edit_card.do", method = RequestMethod.POST)
    @ResponseBody
    public String editar(@RequestParam() String id, @RequestParam() String tipo, @RequestParam() String desc){
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        TypeCard_model card = (TypeCard_model) ctx.getBean("TypeCard_model");
        String retorno = "OK";
        if(!card.edit(id, tipo, desc)){
             retorno = "Error al intentar editar";
        }
        return retorno;
    }
    
    @RequestMapping(value = "delete_card.do", method = RequestMethod.POST)
    @ResponseBody
    public String delete(@RequestParam() String id){
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        TypeCard_model card = (TypeCard_model) ctx.getBean("TypeCard_model");
        String retorno = "OK";
        if(!card.delete(id)){
             retorno = "Error al intentar eliminar";
        }
        return retorno;
    }
    
    @RequestMapping(value = "add_card.do", method = RequestMethod.POST)
    @ResponseBody
    public String add(@RequestParam() String tipo, @RequestParam() String desc){
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        TypeCard_model card = (TypeCard_model) ctx.getBean("TypeCard_model");
        String retorno = "OK";
        if(!card.insert(tipo, desc)){
             retorno = "Error al intentar registrar";
        }
        return retorno;
    }
    
}
