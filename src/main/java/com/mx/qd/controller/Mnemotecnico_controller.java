package com.mx.qd.controller;

import com.mx.qd.model.Mnemotecnico_model;
import org.json.JSONObject;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class Mnemotecnico_controller {

    @RequestMapping(value = "mnemotecnico.do")
    public ModelAndView index() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("mnemotecnico");
        return mv;
    }

    @RequestMapping(value = "insert_mnemotecnico.do")
    @ResponseBody
    public String insert(
            @RequestParam(required = false) String id_tca,
            @RequestParam(required = false) String mnemotecnico,
            @RequestParam(required = false) String label,
            @RequestParam(required = false) String valor_default,
            @RequestParam(required = false) String posx,
            @RequestParam(required = false) String posy,
            @RequestParam(required = false) String id_m, 
            @RequestParam(required = false) String controles_1, 
            @RequestParam(required = false) String controles_2, 
            @RequestParam(required = false) String controles_3,
            @RequestParam(required = false) String id_co,
            @RequestParam(required = false) String valor_query
            ) {
        
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        Mnemotecnico_model nemo = (Mnemotecnico_model) ctx.getBean("Mnemotecnico_model");
        String retorno = "OK";
        
        if(!nemo.insert(id_tca, mnemotecnico, label, valor_default, posx, posy, id_m, controles_1, controles_2, controles_3,id_co,valor_query)){
            retorno = "Ha ocurrido un error al ingresar el registro";
        }
        System.out.println("El valor de retorno es " + retorno);
        return retorno;
    }
    
    @RequestMapping(value = "update_mnemotecnico.do")
    @ResponseBody
    public String update(
            @RequestParam(required = false) String id_tca,
            @RequestParam(required = false) String mnemotecnico,
            @RequestParam(required = false) String label,
            @RequestParam(required = false) String valor_default,
            @RequestParam(required = false) String posx,
            @RequestParam(required = false) String posy,
            @RequestParam(required = false) String id_m, 
            @RequestParam(required = false) String controles_1, 
            @RequestParam(required = false) String controles_2, 
            @RequestParam(required = false) String controles_3,
            @RequestParam(required = false) String id_e,
            @RequestParam(required = false) String id_p,
            @RequestParam(required = false) String id_mge,
            @RequestParam(required = false) String id_co,
            @RequestParam(required = false) String valor_query
            ) {
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        Mnemotecnico_model nemo = (Mnemotecnico_model) ctx.getBean("Mnemotecnico_model");
        String retorno = "OK";
        
        if(!nemo.update(id_tca, mnemotecnico, label, valor_default, posx, posy, id_m, controles_1, controles_2, controles_3, id_e, id_p, id_mge,id_co,valor_query)){
            retorno = "Ha ocurrido un error al modificar el registro";
        }
       
        return retorno;
    }
    
    @RequestMapping(value = "select_mnemotecnico.do")
    @ResponseBody
    public String select(){
         ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        Mnemotecnico_model nemo = (Mnemotecnico_model) ctx.getBean("Mnemotecnico_model");

        JSONObject retorno = new JSONObject();
        retorno.put("data", nemo.select());

        return retorno.toString();
    }
    
    @RequestMapping(value = "delete_mnemotecnico.do")
    @ResponseBody
    public String delete(@RequestParam(required = true) String id_mge){
       ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
       Mnemotecnico_model nemo = (Mnemotecnico_model) ctx.getBean("Mnemotecnico_model");
        String retorno = "OK";
        
        if(!nemo.delete(id_mge)){
            retorno = "Ha ocurrido un error al eliminar el registro";
        }
       
        return retorno;
    }
    
    @RequestMapping(value = "select_controles1.do")
    @ResponseBody
    public String select_controles1(@RequestParam(required = true) String id_mge){
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        Mnemotecnico_model nemo = (Mnemotecnico_model) ctx.getBean("Mnemotecnico_model");

        JSONObject retorno = new JSONObject();
        retorno.put("data", nemo.select_controles1(id_mge));

        return retorno.toString();
    }
    
    @RequestMapping(value = "select_controles2.do")
    @ResponseBody
    public String select_controles2(@RequestParam(required = true) String id_mge){
         ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        Mnemotecnico_model nemo = (Mnemotecnico_model) ctx.getBean("Mnemotecnico_model");

        JSONObject retorno = new JSONObject();
        retorno.put("data", nemo.select_controles2(id_mge));

        return retorno.toString();
    }
    
    @RequestMapping(value = "select_controles3.do")
    @ResponseBody
    public String select_controles3(@RequestParam(required = true) String id_mge){
         ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        Mnemotecnico_model nemo = (Mnemotecnico_model) ctx.getBean("Mnemotecnico_model");

        JSONObject retorno = new JSONObject();
        retorno.put("data", nemo.select_controles3(id_mge));

        return retorno.toString();
    }
}
