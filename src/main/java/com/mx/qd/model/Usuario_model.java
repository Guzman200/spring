package com.mx.qd.model;

import java.util.List;
import java.util.Map;
import javax.sql.DataSource;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;

public class Usuario_model {

    private DataSource dataSource;

    public List<Map<String, Object>> select() {

        String query = "SELECT id_u, login, '*******' as password, u.id_pe, p.nombre, u.status FROM usuario u, perfil p WHERE u.status = 1 and p.status = 1 and p.id_pe = u.id_pe ";
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        List<Map<String, Object>> empRows = jdbcTemplate.queryForList(query);

        return empRows;
    }

    public boolean insert(String login, String password, String id_pefil) {
        boolean flag = true;
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);

        try {
            jdbcTemplate.update("INSERT INTO usuario (login,password,id_pe,status) VALUES (?, MD5(?), ?, 1)",
                    login, password, id_pefil);
        } catch (DataAccessException e) {
            System.out.println(e.getMessage());
            flag = false;
        }

        return flag;
    }

    public boolean update(String login, String password, String id_pefil, String id_u) {
        boolean flag = true;
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);

        try {
            jdbcTemplate.update("UPDATE  usuario SET login = ?, password = MD5(?), id_pe = ? WHERE id_u = ?",
                    login, password, id_pefil, id_u);
        } catch (DataAccessException e) {
            System.out.println(e.getMessage());
            flag = false;
        }

        return flag;
    }

    public boolean delete(String id_u) {
        boolean flag = true;
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);

        try {
            jdbcTemplate.update("UPDATE  usuario SET status = 0 WHERE id_u = ?",
                    id_u);
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
