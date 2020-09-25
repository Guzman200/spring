package com.mx.qd.model;

import java.util.List;
import java.util.Map;
import javax.sql.DataSource;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;

public class PermisoModulo_model {

    private DataSource dataSource;

    public List<Map<String, Object>> select() {

        String query = "SELECT pm.id_pm, ms.nombre as  nombre_m ,pm.id_mo, p.nombre as nombre_p ,pm.id_p FROM permiso_modulo pm, modulo_sistema ms, permiso p WHERE pm.id_mo = ms.id_mo and pm.id_p = p.id_p and pm.status = 1  ";
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        List<Map<String, Object>> empRows = jdbcTemplate.queryForList(query);

        return empRows;
    }

    public boolean insert(String id_mo, String id_p) {
        boolean flag = true;
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);

        try {

            jdbcTemplate.update("CALL insertPermisoModulo (?,?)",
                    id_mo, id_p);
        } catch (DataAccessException e) {
            System.out.println(e.getMessage());
            flag = false;
        }

        return flag;
    }

    public boolean update(String id_pm, String id_mo, String id_p) {
        boolean flag = true;
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);

        
        try {
            jdbcTemplate.update("UPDATE  permiso_modulo SET id_p = ? WHERE id_pm = ? and id_mo = ?",id_p,id_pm,id_mo);
        } catch (DataAccessException e) {
            System.out.println(e.getMessage());
            flag = false;
        }

        return flag;
    }

    public boolean delete(String id_pm,String id_mo) {
        boolean flag = true;
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);

        try {
            jdbcTemplate.update("UPDATE  permiso_modulo SET status = 0 WHERE id_pm = ? and id_mo = ?",
                    id_pm,id_mo);
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
