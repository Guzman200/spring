package com.mx.qd.controller;

import com.mx.qd.model.ControlDos_model;
import com.mx.qd.model.ControlTres_model;
import org.json.JSONObject;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ControlTres_controller {
    
    @RequestMapping(value = "altaControlTres.do")
    public ModelAndView index(){
        ModelAndView mv = new ModelAndView();
        
       mv.setViewName("altaControlTres");
       return mv;
    }
    
    @RequestMapping( value = "select_controlTres.do", method = RequestMethod.GET)
    @ResponseBody
    public String select(){
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        ControlTres_model control = (ControlTres_model) ctx.getBean("ControlTres_model");
        
        JSONObject retorno = new JSONObject();
        retorno.put("data", control.select());
        
        return retorno.toString();
    }
    
    @RequestMapping(value = "insert_controlTres.do")
    @ResponseBody
    public String insert(
            @RequestParam(required = false) String id_g,
            @RequestParam(required = false) String modulo,
            @RequestParam(required = false) String grafica,
            @RequestParam(required = false) String conexion,
            @RequestParam(required = false) String pos_x,
            @RequestParam(required = false) String pos_y,
            @RequestParam(required = false) String altura,
            @RequestParam(required = false) String anchura,
            @RequestParam(required = false) String colorUno,
            @RequestParam(required = false) String colorDos,
            @RequestParam(required = false) String tipo,
            @RequestParam(required = false) String titulo,
            @RequestParam(required = false) String descripcion,
            @RequestParam(required = false) String seriex,
            @RequestParam(required = false) String seriey,
            @RequestParam(required = false) String id_p,
            @RequestParam(required = false) String id_e
    ){
         
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        ControlTres_model control = (ControlTres_model) ctx.getBean("ControlTres_model");
        String retorno = "OK";
        
            if(!control.insert(modulo, grafica, conexion, modulo, pos_x, pos_y, altura, anchura, colorUno, colorDos, tipo, titulo, descripcion, seriex, seriey)){
                retorno = "Error al insertar registro";
            }
        
        return retorno;
    }
    
    
    @RequestMapping(value = "update_controlTres.do")
    @ResponseBody
    public String update(
            @RequestParam(required = false) String id_g,
            @RequestParam(required = false) String modulo,
            @RequestParam(required = false) String grafica,
            @RequestParam(required = false) String conexion,
            @RequestParam(required = false) String pos_x,
            @RequestParam(required = false) String pos_y,
            @RequestParam(required = false) String altura,
            @RequestParam(required = false) String anchura,
            @RequestParam(required = false) String colorUno,
            @RequestParam(required = false) String colorDos,
            @RequestParam(required = false) String tipo,
            @RequestParam(required = false) String titulo,
            @RequestParam(required = false) String descripcion,
            @RequestParam(required = false) String seriex,
            @RequestParam(required = false) String seriey,
            @RequestParam(required = false) String id_p,
            @RequestParam(required = false) String id_e
    ){
         
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        ControlTres_model control = (ControlTres_model) ctx.getBean("ControlTres_model");
        String retorno = "OK";
        
            if(!control.update(modulo, grafica, conexion, modulo, pos_x, pos_y, altura, anchura, colorUno, colorDos, tipo, titulo, descripcion, seriex, seriey, id_g, id_p, id_e)){
                retorno = "Error al insertar registro";
            }
        
        return retorno;
    }
    
    @RequestMapping(value = "delete_controlTres.do")
    @ResponseBody
    public String delete(@RequestParam(required = false) String id_g){
         
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        ControlTres_model control = (ControlTres_model) ctx.getBean("ControlTres_model");
        String retorno = "OK";
        if(!control.delete(id_g)){
            retorno = "Error al eliminar";
        }
                
        return retorno;
    }
    
}
