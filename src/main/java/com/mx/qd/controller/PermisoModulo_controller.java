package com.mx.qd.controller;

import com.mx.qd.model.PermisoModulo_model;
import com.mx.qd.model.Usuario_model;
import org.json.JSONObject;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class PermisoModulo_controller {
    
    @RequestMapping(value = "select_permiso_modulo.do", method = RequestMethod.GET)
    @ResponseBody
    public String select(){
        
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        PermisoModulo_model pm = (PermisoModulo_model) ctx.getBean("PermisoModulo_model");
        
        JSONObject retorno = new JSONObject();
        retorno.put("data", pm.select());
        
        return retorno.toString();
        
    }
    
    @RequestMapping(value = "add_permiso_modulo.do", method = RequestMethod.POST)
    @ResponseBody
    public String insert(@RequestParam () String id_mo, @RequestParam () String id_p){
        
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        PermisoModulo_model pm = (PermisoModulo_model) ctx.getBean("PermisoModulo_model");
        String retorno = "OK";
        
        if(!pm.insert(id_mo, id_p)){
            retorno = "Error al registrar";
        }

        return retorno;
        
    }
    
    @RequestMapping(value = "update_permiso_modulo.do", method = RequestMethod.POST)
    @ResponseBody
    public String update(@RequestParam String id_pm,@RequestParam () String id_mo, @RequestParam () String id_p){
        
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        PermisoModulo_model pm = (PermisoModulo_model) ctx.getBean("PermisoModulo_model");
        String retorno = "OK";
        
        if(!pm.update(id_pm, id_mo, id_p)){
            retorno = "Error al modificar";
        }

        return retorno;
        
    }
    
    @RequestMapping(value = "delete_permiso_modulo.do", method = RequestMethod.POST)
    @ResponseBody
    public String delete(@RequestParam String id_pm,@RequestParam () String id_mo){
        
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        PermisoModulo_model pm = (PermisoModulo_model) ctx.getBean("PermisoModulo_model");
        String retorno = "OK";
        
        if(!pm.delete(id_pm, id_mo)){
            retorno = "Error al eliminar";
        }

        return retorno;
        
    }
    
    @RequestMapping(value = "select_permisos_modulo.do", method = RequestMethod.GET)
    @ResponseBody
    public String select_permisos_modulo(@RequestParam(required = true) String id_mo){
        
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        PermisoModulo_model pm = (PermisoModulo_model) ctx.getBean("PermisoModulo_model");
        
        JSONObject retorno = new JSONObject();
        retorno.put("data", pm.select_permisos_modulo(id_mo));
        
        return retorno.toString();
        
    }
    
    
}
