package com.mx.qd.model;

import java.util.List;
import java.util.Map;
import javax.sql.DataSource;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;


public class ControlTres_model {
    
    private DataSource dataSource;
    
    public List<Map<String,Object>> select() {
        
        String query = "SELECT c3.id_g, c3.id_tg, m.id_m, ec3.id_e, ec3.id_co,\n" +
                        "	   m.nombre as modulo, c3.tipo, c3.altura, c3.anchura, c3.color_1, c3.color_2, c3.titulo, c3.descripcion,\n" +
                        "       p.posicion_x, p.posicion_y, tg.type, c.url, c3.seriex, c3.seriey,\n" +
                        "       p.id_p\n" +
                        "FROM modulo m, elemento_controlTres ec3, elemento e, control_tres c3, posicion p, type_grafica tg, \n" +
                        "    conexion c\n" +
                        "WHERE ec3.id_g = c3.id_g and ec3.id_e = e.id_e and e.id_m = m.id_m and -- enlazo con el modulo\n" +
                        "	  e.id_p = p.id_p and -- enlazo con las posicion\n" +
                        "	  c3.id_tg = tg.id_tg and -- enlazo con type grafica\n" +
                        "	  ec3.id_co = c.id_co and -- enlazo con conexion\n" +
                        "	  c3.status = 1 -- que este activo";
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        List<Map<String,Object>> empRows = jdbcTemplate.queryForList(query);
      
        return empRows;
    }
     
    public boolean insert(String modulo, String grafica, String conexion, String formato, String pos_x, String pos_y,
            String altura, String anchura, String colorUno, String colorDos, String tipo, String titulo, String descripcion,
            String seriex, String seriey
    ){
     
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        boolean flag = true;
        int num_afectados=0;
        try
        {
            num_afectados=jdbcTemplate.update(
                        "CALL insertControlTres(?,?,?,?,?,?,?,?,?,?,?,?,?,?)", modulo,grafica,conexion,pos_x,pos_y,altura,anchura,colorUno,colorDos,
                        tipo,titulo,descripcion,seriex,seriey
            );
            System.out.println("Numero de filas afectadas = " +num_afectados);
        }catch (DataAccessException e)
        {
            System.out.println("Se genero un error");
            System.out.println(e.getMessage());
            flag=false;
        }
        
        
        return flag;
    }
    
     public boolean update(String modulo, String grafica, String conexion, String formato, String pos_x, String pos_y,
            String altura, String anchura, String colorUno, String colorDos, String tipo, String titulo, String descripcion,
            String seriex, String seriey, String id_g, String id_p, String id_e
    ){
     
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        boolean flag = true;
        int num_afectados=0;
        try
        {
            num_afectados=jdbcTemplate.update(
                        "CALL updateControlTres(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", modulo,grafica,conexion,pos_x,pos_y,altura,anchura,colorUno,colorDos,
                        tipo,titulo,descripcion,seriex,seriey,id_g,id_p,id_e
            );
            System.out.println("Numero de filas afectadas = " +num_afectados);
        }catch (DataAccessException e)
        {
            System.out.println("Se genero un error");
            System.out.println(e.getMessage());
            flag=false;
        }
        
        
        return flag;
    }
    
   
    
     public boolean delete(String id_g){
     
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        boolean flag = true;
        int num_afectados=0;
        try
        {
            num_afectados=jdbcTemplate.update(
                        "UPDATE control_tres set status = 0 WHERE id_g = ?", id_g
            );
            System.out.println("Numero de filas afectadas = " +num_afectados);
        }catch (DataAccessException e)
        {
            System.out.println("Se genero un error");
            System.out.println(e.getMessage());
            flag=false;
        }
        
        
        return flag;
    }
     
     
    public DataSource getDataSource() {
        return dataSource;
    }

    public void setDataSource(DataSource dataSource) {
        this.dataSource = dataSource;
    }
}
