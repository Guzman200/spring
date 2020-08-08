package com.mx.qd.model;

import java.util.List;
import java.util.Map;
import javax.sql.DataSource;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;

public class TypeBd_model {
    
    private DataSource dataSource;
    
    public List<Map<String,Object>> select() {
        
        String query = "SELECT id_tbd, nombre, descripcion FROM type_bd WHERE status = 1";
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        List<Map<String,Object>> empRows = jdbcTemplate.queryForList(query);
        
        return empRows;
    }
    
    public boolean insert(String nombre, String desc){
        System.out.println("Lllego al metodo insert");
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        boolean flag=true;
        int num_afectados=0;
        try
        {
            num_afectados=jdbcTemplate.update(
                        "INSERT INTO type_bd( nombre, descripcion,status ) VALUES (?, ?, 1)", // colocar todo asi 
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
                    "UPDATE type_bd set nombre = ?, descripcion = ? WHERE id_tbd = ?",
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
                    "UPDATE type_bd set status = 0 WHERE id_tbd = ?", id
            );
        } catch (DataAccessException e) {
            System.out.println("Se genero un error");
            System.out.println(e.getMessage());
            flag=false;
        }
        
        return flag;
    }
    
    
    /**
     * @return the dataSource
     */
    public DataSource getDataSource() {
        return dataSource;
    }

    /**
     * @param dataSource the dataSource to set
     */
    public void setDataSource(DataSource dataSource) {
        this.dataSource = dataSource;
    }
}
