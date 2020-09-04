package com.mx.qd.model;

import java.util.List;
import java.util.Map;
import javax.sql.DataSource;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;

public class Mnemotecnico_model {

    private DataSource dataSource;

    public List<Map<String, Object>> select() {

        String query = "SELECT \n"
                + "mg.id_mge,mg.id_tca,tc.nombre,mg.mnemotecnico,mg.label,mg.valor_default,e.id_m,e.id_p,p.posicionx,posiciony,\n"
                + "e.id_e, mg.valor_query, emge.id_co  \n"
                + "FROM \n"
                + "mnemotecnico_generico mg, tipo_campo tc, elemento_mge emge, elemento e, posicion p\n"
                + "WHERE \n"
                + "tc.id_tca = mg.id_tca and emge.id_mge = mg.id_mge and emge.id_e = e.id_e and\n"
                + "	  e.id_p = p.id_p and mg.status = 1";
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        List<Map<String, Object>> empRows = jdbcTemplate.queryForList(query);

        return empRows;
    }

    public boolean insert(String id_tca, String mnemotecnico, String label, String valor_default, String posx, String posy,
            String id_m, String controles_1, String controles_2, String controles_3,String id_co, String valor_query) {
        boolean flag = true;
        int num_afectados;
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        try {
            num_afectados = jdbcTemplate.update(
                    "CALL alta_mnemotecnico(?,?,?,?,?,?,?,?,?,?,?,?)",
                    id_tca, mnemotecnico, label, valor_default, posx, posy, id_m, controles_1, controles_2, controles_3,id_co,
                    valor_query
            );
            System.out.println("Numero de filas afectadas = " + num_afectados);
        } catch (DataAccessException e) {
            System.out.println(" ----- Se genero un error -------");
            System.out.println(e.getMessage());
            flag = false;
        }

        return flag;
    }
    
    public boolean update(String id_tca, String mnemotecnico, String label, String valor_default, String posx, String posy,
            String id_m, String controles_1, String controles_2, String controles_3,
            String id_e, String id_p, String id_mge,String id_co, String valor_query) {
        boolean flag = true;
        int num_afectados;
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        try {
            num_afectados = jdbcTemplate.update(
                    "CALL editar_mnemotecnico(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
                    id_tca, mnemotecnico, label, valor_default, posx, posy, id_m, controles_1, controles_2, controles_3,
                    id_e,id_p,id_mge,id_co,valor_query
            );
            System.out.println("Numero de filas afectadas = " + num_afectados);
        } catch (DataAccessException e) {
            System.out.println(" ----- Se genero un error -------");
            System.out.println(e.getMessage());
            flag = false;
        }

        return flag;
    }
    
    public boolean delete(String id_mge) {
        boolean flag = true;
        int num_afectados;
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        try {
            num_afectados = jdbcTemplate.update(
                    "UPDATE mnemotecnico_generico set status = 0 WHERE id_mge = ?",
                    id_mge
            );
            System.out.println("Numero de filas afectadas = " + num_afectados);
        } catch (DataAccessException e) {
            System.out.println(" ----- Se genero un error -------");
            System.out.println(e.getMessage());
            flag = false;
        }

        return flag;
    }
    
    public List<Map<String, Object>> select_controles1(String id_mge) {

        String query = "SELECT cmg.id_c, cmg.id_mge, c1.titulo FROM control1_mg cmg, control_uno c1 WHERE c1.id_c = cmg.id_c and cmg.id_mge = ?";
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        List<Map<String, Object>> empRows = jdbcTemplate.queryForList(query,id_mge);

        return empRows;
    }
    
    public List<Map<String, Object>> select_controles2(String id_mge) {

        String query = "SELECT cmg.id_t, cmg.id_mge, c2.titulo FROM control2_mg cmg, control_dos c2 WHERE c2.id_t = cmg.id_t and cmg.id_mge = ?";
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        List<Map<String, Object>> empRows = jdbcTemplate.queryForList(query,id_mge);

        return empRows;
    }
    
    public List<Map<String, Object>> select_controles3(String id_mge) {

        String query = "SELECT cmg.id_g, cmg.id_mge, c3.titulo FROM control3_mg cmg, control_tres c3 WHERE c3.id_g = cmg.id_g and cmg.id_mge = ?";
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        List<Map<String, Object>> empRows = jdbcTemplate.queryForList(query,id_mge);

        return empRows;
    }

    public DataSource getDataSource() {
        return dataSource;
    }

    public void setDataSource(DataSource dataSource) {
        this.dataSource = dataSource;
    }
}
