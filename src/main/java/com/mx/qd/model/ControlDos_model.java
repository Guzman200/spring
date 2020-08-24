package com.mx.qd.model;

import java.util.List;
import java.util.Map;
import javax.sql.DataSource;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;


public class ControlDos_model {
    
    private DataSource dataSource;
    
    public List<Map<String,Object>> select() {
        
        String query = "SELECT c2.id_t, c2.id_tt, m.id_m, ec2.id_e, ec2.id_co,\n" +
                        "	   m.nombre as modulo, c2.tipo, c2.altura, c2.anchura, c2.color_1, c2.color_2, c2.titulo, c2.descripcion,\n" +
                        "       p.posicion_x, p.posicion_y, tt.type, c.url, c2.encabezados,\n" +
                        "       p.id_p\n" +
                        "FROM modulo m, elemento_controlDos ec2, elemento e, control_dos c2, posicion p, type_tabla tt, \n" +
                        "    conexion c\n" +
                        "WHERE ec2.id_t = c2.id_t and ec2.id_e = e.id_e and e.id_m = m.id_m and -- enlazo con el modulo\n" +
                        "	  e.id_p = p.id_p and -- enlazo con las posicion\n" +
                        "	  c2.id_tt = tt.id_tt and -- enlazo con type tabla\n" +
                        "	  ec2.id_co = c.id_co and -- enlazo con conexion\n" +
                        "	  c2.status = 1 -- que este activo";
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        List<Map<String,Object>> empRows = jdbcTemplate.queryForList(query);
      
        return empRows;
    }
     
    public boolean insert(String id_t,String modulo, String tabla, String conexion, String formato, String pos_x, String pos_y,
            String altura, String anchura, String colorUno, String colorDos, String tipo, String titulo, String descripcion,
            String encabezado
    ){
     
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        boolean flag = true;
        int num_afectados=0;
        try
        {
            num_afectados=jdbcTemplate.update(
                        "CALL insertControlDos(?,?,?,?,?,?,?,?,?,?,?,?,?)",
                        modulo,tabla,conexion,encabezado,pos_x,pos_y,altura,anchura,colorUno,colorDos,tipo,titulo,descripcion
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
    
    public boolean update(String id_t,String modulo, String tabla, String conexion, String formato, String pos_x, String pos_y,
            String altura, String anchura, String colorUno, String colorDos, String tipo, String titulo, String descripcion,
            String encabezado, String id_p, String id_e
    ){
     
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        boolean flag = true;
        int num_afectados=0;
        try
        {
            num_afectados=jdbcTemplate.update(
                        "CALL updateControlDos(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
                        modulo,tabla,conexion,encabezado,pos_x,pos_y,altura,anchura,colorUno,colorDos,tipo,titulo,descripcion,
                        id_t,id_p,id_e
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
    
     public boolean delete(String id_t){
     
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        boolean flag = true;
        int num_afectados=0;
        try
        {
            num_afectados=jdbcTemplate.update(
                        "UPDATE control_dos set status = 0 WHERE id_t = ?", id_t
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
        
        String query = "SELECT ec2.id_t,ec2.id_e, c2.titulo\n" +
                        "FROM elemento e, elemento_controlDos ec2, control_dos c2\n" +
                        "WHERE e.id_e = ec2.id_e and ec2.id_t = c2.id_t and c2.status = 1 and e.id_m = ?;";
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
