package com.mx.qd.model;

import java.util.List;
import java.util.Map;
import javax.sql.DataSource;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;


public class Modulo_model {
    private DataSource dataSource;
    
     public List<Map<String,Object>> select() {
        
        String query = "SELECT *  FROM modulo";
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        List<Map<String,Object>> empRows = jdbcTemplate.queryForList(query);
      
        return empRows;
    }
    
    public boolean insert(String nombre, String desc){
        
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        boolean flag=true;
        int num_afectados=0;
        try
        {
            num_afectados=jdbcTemplate.update(
                        "INSERT INTO modulo ( nombre, descripcion ) VALUES (?, ?)", 
                        nombre, desc
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
    
    public boolean update(String id, String nombre, String desc){
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        boolean flag = true;
        try{
            int num_afectados = jdbcTemplate.update(
                    "UPDATE modulo set nombre = ?, descripcion = ? WHERE id_m = ?",
                    nombre, desc, id
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
                    "DELETE FROM modulo WHERE id_m = ?", id
            );
        } catch (DataAccessException e) {
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
