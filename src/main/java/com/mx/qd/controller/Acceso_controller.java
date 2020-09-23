package com.mx.qd.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class Acceso_controller {
    
    @RequestMapping(value = "acceso.do")
    public ModelAndView index(){
        ModelAndView mv = new ModelAndView();
        mv.setViewName("acceso");
        return  mv;
    }
   
}
