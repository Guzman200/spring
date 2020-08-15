package com.mx.qd.model;

import java.util.List;
import java.util.Map;
import javax.sql.DataSource;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;

public class Conexion_model {
    
    private DataSource dataSource;
    
     public List<Map<String,Object>> select() {
        
        String query = "SELECT c.id_co, c.url, c.login, c.password, c.bd, tbd.nombre, c.id_tbd  FROM conexion c, type_bd tbd WHERE c.id_tbd = tbd.id_tbd";
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        List<Map<String,Object>> empRows = jdbcTemplate.queryForList(query);
      
        return empRows;
    }
    
    public boolean insert(String url, String login, String pass, String bd, String id_tbd){
        
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        boolean flag=true;
        int num_afectados=0;
        try
        {
            num_afectados=jdbcTemplate.update(
                        "INSERT INTO conexion ( url,login, password, bd, id_tbd ) VALUES (?,?,?,?,?)", 
                        url,login, pass,bd,id_tbd
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
    
    public boolean update(String url, String login, String pass, String bd, String id_tbd, String id_co){
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        boolean flag = true;
        try{
            int num_afectados = jdbcTemplate.update(
                    "UPDATE conexion set url = ?, login = ?, password = ?, bd = ?, id_tbd = ? WHERE id_co = ?",
                    url, login, pass, bd, id_tbd, id_co
            );
        }catch(DataAccessException e){
            System.out.println("Se genero un error");
            System.out.println(e.getMessage());
            flag=false;
        }
        return flag;
    }
    
    public boolean delete(String id){
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        boolean flag = true;
        
        try {
            int num_afectados = jdbcTemplate.update(
                    "DELETE FROM conexion WHERE id_co = ?", id
            );
        } catch (DataAccessException e) {
            System.out.println("Se genero un error");
            System.out.println(e.getMessage());
            flag=false;
        }
        
        return flag;
    }

    public List<Map<String,Object>> select_typBD(String id) {
        
        String query = "SELECT id_tbd FROM conexion WHERE id_co = " + id;
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        List<Map<String,Object>> empRows = jdbcTemplate.queryForList(query);
      
        return empRows;
    }
    
    public DataSource getDataSource() {
        return dataSource;
    }

    public void setDataSource(DataSource dataSource) {
        this.dataSource = dataSource;
    }
}
