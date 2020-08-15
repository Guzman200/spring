package com.mx.qd.controller;

import com.mx.qd.model.ControlDos_model;
import com.mx.qd.model.ControlUno_model;
import org.json.JSONObject;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ControlDos_controller {
    
    @RequestMapping( value =  "altaControlDos.do")
    public ModelAndView index(){
        ModelAndView mv = new ModelAndView();
        mv.setViewName("altaControlDos");
        
        return mv;
    }
    
    @RequestMapping( value = "select_controlDos.do", method = RequestMethod.GET)
    @ResponseBody
    public String select(){
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        ControlDos_model control = (ControlDos_model) ctx.getBean("ControlDos_model");
        
        JSONObject retorno = new JSONObject();
        retorno.put("data", control.select());
        
        return retorno.toString();
    }
 
    @RequestMapping(value = "insert_controlDos.do")
    @ResponseBody
    public String insert(
            @RequestParam(required = false) String id_t,
            @RequestParam(required = false) String modulo,
            @RequestParam(required = false) String tabla,
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
            @RequestParam(required = false) String encabezado,
            @RequestParam(required = false) String id_p,
            @RequestParam(required = false) String id_e
    ){
         
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        ControlDos_model control = (ControlDos_model) ctx.getBean("ControlDos_model");
        String retorno = "OK";
        
            if(!control.insert(id_t, modulo, tabla, conexion, modulo, pos_x, pos_y, altura, anchura, colorUno, colorDos, tipo, titulo, descripcion, encabezado)){
                retorno = "Error al insertar registro";
            }
        
        return retorno;
    }
    
    @RequestMapping(value = "update_controlDos.do")
    @ResponseBody
    public String update(
            @RequestParam(required = false) String id_t,
            @RequestParam(required = false) String modulo,
            @RequestParam(required = false) String tabla,
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
            @RequestParam(required = false) String encabezado,
            @RequestParam(required = false) String id_p,
            @RequestParam(required = false) String id_e
    ){
         
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        ControlDos_model control = (ControlDos_model) ctx.getBean("ControlDos_model");
        String retorno = "OK";
        
            if(!control.update(id_t, modulo, tabla, conexion, modulo, pos_x, pos_y, altura, anchura, colorUno, colorDos, tipo, titulo, descripcion, encabezado, id_p, id_e)){
                retorno = "Error al insertar registro";
            }
        
        return retorno;
    }
    
    @RequestMapping(value = "delete_controlDos.do")
    @ResponseBody
    public String delete(@RequestParam(required = false) String id_t){
         
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        ControlDos_model control = (ControlDos_model) ctx.getBean("ControlDos_model");
        String retorno = "OK";
        if(!control.delete(id_t)){
            retorno = "Error al eliminar";
        }
                
        return retorno;
    }
    
}
