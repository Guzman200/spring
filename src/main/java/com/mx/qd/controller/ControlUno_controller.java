package com.mx.qd.controller;

import com.mx.qd.model.ControlUno_model;
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
public class ControlUno_controller {
    
    @RequestMapping( value = "altaControlUno.do")
    public ModelAndView index(){
        
        ModelAndView mv = new ModelAndView();
        mv.setViewName("altaControlUno");
        
        return mv;
    }
    
    @RequestMapping( value = "select_controlUno.do", method = RequestMethod.GET)
    @ResponseBody
    public String select(){
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        ControlUno_model control = (ControlUno_model) ctx.getBean("ControlUno_model");
        
        JSONObject retorno = new JSONObject();
        retorno.put("data", control.select());
        
        return retorno.toString();
    }
    
    @RequestMapping(value = "insert_controlUno.do")
    @ResponseBody
    public String insert(
            @RequestParam(required = false) String id_c,
            @RequestParam(required = false) String modulo,
            @RequestParam(required = false) String tarjeta,
            @RequestParam(required = false) String conexion,
            @RequestParam(required = false) String formato,
            @RequestParam(required = false) String pos_x,
            @RequestParam(required = false) String pos_y,
            @RequestParam(required = false) String altura,
            @RequestParam(required = false) String anchura,
            @RequestParam(required = false) String colorUno,
            @RequestParam(required = false) String colorDos,
            @RequestParam(required = false) String tipo,
            @RequestParam(required = false) String titulo,
            @RequestParam(required = false) String descripcion,
            @RequestParam(required = false) String id_p,
            @RequestParam(required = false) String id_e,
            @RequestParam(required = false) String icono
    ){
         
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        ControlUno_model control = (ControlUno_model) ctx.getBean("ControlUno_model");
        String retorno = "OK";
        
            if(!control.insert(modulo, tarjeta, conexion, formato, pos_x, pos_y, altura, anchura, colorUno, colorDos, tipo, titulo, descripcion,icono)){
                retorno = "Error al insertar registro";
            }
        
        return retorno;
    }
    
    @RequestMapping(value = "update_controlUno.do")
    @ResponseBody
    public String update(
            @RequestParam(required = false) String id_c,
            @RequestParam(required = false) String modulo,// id_m
            @RequestParam(required = false) String tarjeta, // id_tc
            @RequestParam(required = false) String conexion, // id_co
            @RequestParam(required = false) String formato, // id_f
            @RequestParam(required = false) String pos_x,
            @RequestParam(required = false) String pos_y,
            @RequestParam(required = false) String altura,
            @RequestParam(required = false) String anchura,
            @RequestParam(required = false) String colorUno,
            @RequestParam(required = false) String colorDos,
            @RequestParam(required = false) String tipo,
            @RequestParam(required = false) String titulo,
            @RequestParam(required = false) String descripcion,
            @RequestParam(required = false) String id_p,
            @RequestParam(required = false) String id_e,
            @RequestParam(required = false) String icono
    ){
         
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        ControlUno_model control = (ControlUno_model) ctx.getBean("ControlUno_model");
        String retorno = "OK";
        if(!control.update(modulo, tarjeta, conexion, formato, pos_x, pos_y, altura, anchura, colorUno, colorDos, tipo, titulo, descripcion, id_c, id_p, id_e,icono)){
            retorno = "Error al modificar";
        }
                
        return retorno;
    }
    
    @RequestMapping(value = "delete_controlUno.do")
    @ResponseBody
    public String delete(@RequestParam(required = false) String id_c){
         
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        ControlUno_model control = (ControlUno_model) ctx.getBean("ControlUno_model");
        String retorno = "OK";
        if(!control.delete(id_c)){
            retorno = "Error al eliminar";
        }
                
        return retorno;
    }
    
    @RequestMapping( value = "selectControlesUno_modulo.do", method = RequestMethod.GET)
    @ResponseBody
    public String selectControlesUno_modulo(@RequestParam(required = true) String id_modulo){
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        ControlUno_model control = (ControlUno_model) ctx.getBean("ControlUno_model");
        
        JSONObject retorno = new JSONObject();
        retorno.put("data", control.select_controles(id_modulo));
        
        return retorno.toString();
    }
}
