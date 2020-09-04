package com.mx.qd.model;

import java.util.List;
import java.util.Map;
import javax.sql.DataSource;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;


public class ControlUno_model {
    
    private DataSource dataSource;
    
    public List<Map<String,Object>> select() {
        
        String query = "SELECT c1.id_c, c1.id_tc, m.id_m,c1.id_f, ec1.id_e, ec1.id_co,\n" +
                            "	   m.nombre as modulo, c1.tipo, c1.altura, c1.anchura, c1.color_1, c1.color_2, c1.titulo, c1.descripcion,\n" +
                            "       p.posicionx, p.posiciony, f.nombre as formato, tc.type as tc, c.url,\n" +
                            "       p.id_p\n" +
                            "FROM modulo m, elemento_controlUno ec1, elemento e, control_uno c1, posicion p, formato f, type_card tc, \n" +
                            "    conexion c\n" +
                            "WHERE ec1.id_c = c1.id_c and ec1.id_e = e.id_e and e.id_m = m.id_m and -- enlazo con el modulo\n" +
                            "	  e.id_p = p.id_p and -- enlazo con las posicion\n" +
                            "	  c1.id_f = f.id_f and -- enlazo con el formato\n" +
                            "	  c1.id_tc = tc.id_tc and -- enlazo con type card\n" +
                            "	  ec1.id_co = c.id_co and -- enlazo con conexion\n" +
                            "	  c1.status = 1 -- que este activo";
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        List<Map<String,Object>> empRows = jdbcTemplate.queryForList(query);
      
        return empRows;
    }
     
    public boolean insert(String modulo, String tarjeta, String conexion, String formato, String pos_x, String pos_y,
            String altura, String anchura, String colorUno, String colorDos, String tipo, String titulo, String descripcion
    ){
     
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        boolean flag = true;
        int num_afectados=0;
        try
        {
            num_afectados=jdbcTemplate.update(
                        "CALL insertControlUno(?,?,?,?,?,?,?,?,?,?,?,?,?)",
                        modulo,tarjeta,conexion,formato,pos_x,pos_y,altura,anchura,colorUno,colorDos,tipo,titulo,descripcion
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
    
    public boolean update(String modulo, String tarjeta, String conexion, String formato, String pos_x, String pos_y,
            String altura, String anchura, String colorUno, String colorDos, String tipo, String titulo, String descripcion,
            String id_c, String id_p, String id_e
    ){
     
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        boolean flag = true;
        int num_afectados=0;
        try
        {
            num_afectados=jdbcTemplate.update(
                        "CALL updateControlUno(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
                        modulo,tarjeta,conexion,formato,pos_x,pos_y,altura,anchura,colorUno,colorDos,tipo,titulo,descripcion,
                        id_c,id_p,id_e
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
    
     public boolean delete(String id_c){
     
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        boolean flag = true;
        int num_afectados=0;
        try
        {
            num_afectados=jdbcTemplate.update(
                        "UPDATE control_uno set status = 0 WHERE id_c = ?", id_c
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
     
   public List<Map<String,Object>> select_controles(String id_modulo) {
        
        String query = "SELECT ec1.id_c,ec1.id_e, c1.titulo\n" +
                        "FROM elemento e, elemento_controlUno ec1, control_uno c1\n" +
                        "WHERE e.id_e = ec1.id_e and ec1.id_c = c1.id_c and c1.status = 1 and e.id_m = ?;";
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        List<Map<String,Object>> empRows = jdbcTemplate.queryForList(query,id_modulo);
      
        return empRows;
    }
     
     
    public DataSource getDataSource() {
        return dataSource;
    }

    public void setDataSource(DataSource dataSource) {
        this.dataSource = dataSource;
    }
    
}
