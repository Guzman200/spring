package com.mx.qd.model;

import java.util.List;
import java.util.Map;
import javax.sql.DataSource;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;

/**
 *
 * @author GUZMAN
 */
public class TypeCard_model {
        
    private DataSource dataSource;
    
    public List<Map<String,Object>> select() {
        
        String query = "SELECT * FROM type_card WHERE status = 1";
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        List<Map<String,Object>> empRows = jdbcTemplate.queryForList(query);
        
        return empRows;
    }
    
    public boolean edit(String id, String tipo, String desc, String icono){
        
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        boolean flag = true;
        
        try{
            jdbcTemplate.update(
                    "UPDATE type_card set type=?, descripcion=?, icono = ? WHERE id_tc = ? ",
                    tipo, desc, icono ,id
            );
        }catch(DataAccessException e){
            flag = false;
            System.out.println(e.getMessage());
        }
        
        return flag;
    }

    public boolean insert(String tipo, String desc, String icono){
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        boolean flag = true;
        
        try {
            
            jdbcTemplate.update(
                    "INSERT INTO type_card (type, descripcion, status, icono) values (?, ?, 1, ?)",
                    tipo, desc, icono
            );
            
        } catch (DataAccessException e) {
            flag = false;
            System.out.println(e.getMessage());
        }
        
        return flag;
    }
    
    public boolean delete(String id){
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        boolean flag = true;
        
        try {
            jdbcTemplate.update(
                    "UPDATE type_card set status = 0 WHERE id_tc = ?",
                    id
            );
        } catch (DataAccessException e) {
            System.out.println(e.getMessage());
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
