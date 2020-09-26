package com.mx.qd.model;

import java.util.List;
import java.util.Map;
import javax.sql.DataSource;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;

public class Perfil_model {

    private DataSource dataSource;

    public List<Map<String, Object>> select() {

        String query = "SELECT * FROM perfil WHERE status = 1";
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        List<Map<String, Object>> empRows = jdbcTemplate.queryForList(query);

        return empRows;
    }

    public boolean insert(String nombre) {
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        boolean flag = true;
        int num_afectados = 0;
        try {
            num_afectados = jdbcTemplate.update(
                    "INSERT INTO perfil ( nombre,status ) VALUES (?,1)",
                    nombre
            );
            System.out.println("Numero de filas afectadas = " + num_afectados);
        } catch (DataAccessException e) {
            System.out.println("Se genero un error");
            System.out.println(e.getMessage());
            flag = false;
        }
        return flag;
    }

    public boolean update(String id, String nombre) {
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        boolean flag = true;
        try {
            jdbcTemplate.update("UPDATE perfil SET nombre = ? WHERE id_pe = ?", nombre, id);
        } catch (DataAccessException e) {
            flag = false;
        }

        return flag;
    }

    public boolean delete(String id) {
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        boolean flag = true;
        try {
            jdbcTemplate.update("UPDATE perfil set status = 0 WHERE id_pe = ?", id);
        } catch (DataAccessException e) {
            flag = false;
        }
        return flag;
    }

    /* Devuelve todos los permisos a los que tiene acceso un perfil */
    public List<Map<String, Object>> select_permisos_perfil(String id_pe) {

        String query = "SELECT dp.id_pm, dp.id_pe, p.nombre as nombrePerfil, \n"
                + "	   dp.id_mo, ms.nombre as nombreModulo,\n"
                + "	   pm.id_p, permiso.nombre as nombrePermiso\n"
                + "FROM detalle_perfil dp, permiso_modulo pm, perfil p, modulo_sistema ms, permiso\n"
                + "WHERE dp.id_pm = pm.id_pm and dp.id_mo = pm.id_mo -- enlazamos con la tabla permiso_modulo\n"
                + "	  and dp.id_pe = p.id_pe -- enlazamos con la tabla perfil\n"
                + "	  and dp.id_mo = ms.id_mo -- enlazamos con la tabla modulo\n"
                + "	  and permiso.id_p = pm.id_p -- enlazamos con la tabla permiso\n"
                + "	  and pm.status = 1 --\n"
                + "	  and dp.id_pe = ?";
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        List<Map<String, Object>> empRows = jdbcTemplate.queryForList(query, id_pe);

        return empRows;
    }
    
    public boolean modificar_permisos_perfil(String id_pe, String cadena_permisos){
        boolean flag = true;
        
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        
        try {
            jdbcTemplate.update("CALL config_perfil(?,?)", id_pe,cadena_permisos);
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
