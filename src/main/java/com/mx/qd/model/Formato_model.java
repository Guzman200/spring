package com.mx.qd.model;

import java.util.List;
import java.util.Map;
import javax.sql.DataSource;
import org.springframework.jdbc.core.JdbcTemplate;

public class Formato_model {
    private DataSource dataSource;
    
     public List<Map<String,Object>> select() {
        
        String query = "SELECT *  FROM formato";
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
