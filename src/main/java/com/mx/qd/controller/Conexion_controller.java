package com.mx.qd.controller;

import com.mx.qd.model.Conexion_model;
import com.mx.qd.model.Modulo_model;
import org.json.JSONObject;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class Conexion_controller {
    
    @RequestMapping(value = "conexion.do")
    public ModelAndView typebd() {
        
        ModelAndView mv = new ModelAndView();
        mv.setViewName("conexion");

        return mv;
    }

    @RequestMapping(value = "select_conexion.do", method = RequestMethod.GET)
    @ResponseBody
    public String select() {
        
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        Conexion_model conexion = (Conexion_model) ctx.getBean("Conexion_model");
        
        JSONObject retorno = new JSONObject();
        retorno.put("data", conexion.select());
        
        return retorno.toString();
    }
    
    @RequestMapping(value = "add_conexion.do", method = RequestMethod.POST)
    @ResponseBody
    public String add(
            @RequestParam(required = false) String url, 
            @RequestParam(required = false) String login, 
            @RequestParam(required = false) String pass, 
            @RequestParam(required = false) String bd,
            @RequestParam(required = false) String id_tbd
    ){
        
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        Conexion_model con = (Conexion_model) ctx.getBean("Conexion_model");
        String retorno = "OK";
        
        if(!con.insert(url, login, pass, bd, id_tbd))
        {
            retorno = "Error al ingresar registro";
        }
        
        return retorno;   
    }
    
    @RequestMapping ( value = "edit_conexion.do", method = RequestMethod.POST)
    @ResponseBody
    public String edit(
            @RequestParam(required = false) String url, 
            @RequestParam(required = false) String login, 
            @RequestParam(required = false) String pass, 
            @RequestParam(required = false) String bd,
            @RequestParam(required = false) String id_tbd,
            @RequestParam(required = false) String id_co
    ){
        
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        Conexion_model modulo = (Conexion_model) ctx.getBean("Conexion_model");
        String retorno = "OK";
        
        if(!modulo.update(url, login, pass, bd, id_tbd, id_co)){
            retorno = "Error al intentar modificar";
        }
  
        return retorno;
    }
    
    @RequestMapping( value = "delete_conexion.do", method = RequestMethod.POST)
    @ResponseBody
    public String delete(@RequestParam() String id){
        
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        Conexion_model modulo = (Conexion_model) ctx.getBean("Conexion_model");
        String retorno = "OK";
        if(!modulo.delete(id)){
             retorno = "Error al intentar eliminar";
        }
        
        return retorno;
    }
    
    @RequestMapping(value = "selectTypeBD_conexion.do", method = RequestMethod.POST)
    @ResponseBody
    public String select_typeBD(@RequestParam(required = true) String id) {
        
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        Conexion_model conexion = (Conexion_model) ctx.getBean("Conexion_model");
        
        JSONObject retorno = new JSONObject();
        retorno.put("data", conexion.select_typBD(id));
        
        return retorno.toString();
    }
    
}
