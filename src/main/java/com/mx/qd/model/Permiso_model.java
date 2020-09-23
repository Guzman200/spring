package com.mx.qd.model;

import java.util.List;
import java.util.Map;
import javax.sql.DataSource;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;

public class Permiso_model {
    
     private DataSource dataSource;

    public List<Map<String, Object>> select() {

        String query = "SELECT * FROM permiso WHERE status = 1";
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        List<Map<String, Object>> empRows = jdbcTemplate.queryForList(query);

        return empRows;
    }
    
    public boolean insert(String nombre,String descripcion){
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        boolean flag=true;
        int num_afectados=0;
        try
        {
            num_afectados=jdbcTemplate.update(
                        "INSERT INTO permiso ( nombre,status,descripcion ) VALUES (?,1,?)", 
                        nombre, descripcion
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
    
    public boolean update(String id, String nombre, String descripcion){
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        boolean flag = true;
         try
        {
           jdbcTemplate.update("UPDATE permiso SET nombre = ?, descripcion = ? WHERE id_p = ?", nombre, descripcion,id);
        }catch (DataAccessException e)
        {
            flag=false;
        }
        
        return flag;
    }
    
    public boolean delete(String id){
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        boolean flag = true;
        try {
            jdbcTemplate.update("UPDATE permiso set status = 0 WHERE id_p = ?", id);
        } catch (DataAccessException e) {
            flag = false;
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
