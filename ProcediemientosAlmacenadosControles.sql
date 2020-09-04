
-- Query para mostrar los datos de controlUno en la vista

SELECT c1.id_c, c1.id_tc, m.id_m,c1.id_f, ec1.id_e, ec1.id_co,
	   m.nombre as modulo, c1.tipo, c1.altura, c1.anchura, c1.color_1, c1.color_2, c1.titulo, c1.descripcion,
       p.posicionx, p.posiciony, f.nombre as formato, tc.type as tc, c.url,
       p.id_p
FROM modulo m, elemento_controlUno ec1, elemento e, control_uno c1, posicion p, formato f, type_card tc, 
    conexion c
WHERE ec1.id_c = c1.id_c and ec1.id_e = e.id_e and e.id_m = m.id_m and -- enlazo con el modulo
	  e.id_p = p.id_p and -- enlazo con las posicion
	  c1.id_f = f.id_f and -- enlazo con el formato
	  c1.id_tc = tc.id_tc and -- enlazo con type card
	  ec1.id_co = c.id_co and -- enlazo con conexion
	  c1.status = 1 -- que este activo

-- PROCEDIMIENTO ALMACENADO PARE INSERTAR ALTA CONTROL 1

DELIMITER $$
DROP PROCEDURE IF EXISTS insertControlUno $$
CREATE PROCEDURE insertControlUno(
	IN id_m int, IN id_tc int, IN id_co int, IN id_f int,
	IN pos_x text, IN pos_y text, IN altura int, IN anchura int, IN colorUno text,
	IN colorDos text, IN tipo text, IN titulo text, IN descr text
)

BEGIN
	INSERT INTO posicion (posicionx,posiciony) VALUES (pos_x,pos_y);
	INSERT INTO elemento (id_m, id_p) VALUES (id_m,LAST_INSERT_ID());

	select @idElemento := LAST_INSERT_ID();

	INSERT INTO control_uno (tipo,altura,anchura,color_1,color_2,titulo,descripcion,id_f,id_tc,status) 
	                 VALUES (tipo,altura,anchura,colorUno,colorDos,titulo,descr,id_f,id_tc,1);
	INSERT INTO elemento_controlUno (id_e,id_c,id_co) VALUES (@idElemento,LAST_INSERT_ID(),id_co);
END
$$


-- PROCEDIMIENTO ALMACENADO PARE EDITAR ALTA CONTROL 1

DELIMITER $$
DROP PROCEDURE IF EXISTS updateControlUno $$
CREATE PROCEDURE updateControlUno(
	IN id_m_ int, IN id_tc_ int, IN id_co_ int, IN id_f_ int,
	IN pos_x text, IN pos_y text, IN altura_ int, IN anchura_ int, IN colorUno text,
	IN colorDos text, IN tipo_ text, IN titulo_ text, IN descr text,
	IN id_c_ int, -- id conexion
	IN id_p_ int, -- id posicion
	IN id_e_ int -- id elemento
)

BEGIN
	UPDATE posicion set posicionx = pos_x, posiciony = pos_y WHERE id_p = id_p_;

	UPDATE elemento set id_m = id_m_ WHERE id_e = id_e_ ;

	UPDATE control_uno set tipo = tipo_ ,altura = altura_ ,anchura = anchura_,
	                      color_1 = colorUno,color_2 = colorDos,titulo=titulo_,
	                      descripcion = descr, id_f = id_f_ , id_tc = id_tc_ WHERE id_c = id_c_;

	UPDATE elemento_controlUno set id_co = id_co_  WHERE id_c = id_c_ and id_e = id_e_;
END
$$

CALL insertControlUno(1,1,8,1,1,'120','120',440,440,'123','123','tipo pl','pl titulo','descr pl',1,);

-------------------------------------- CONTROL 2 ---------------------------------------

CREATE TABLE control_dos(
	id_t int(11) NOT NULL AUTO_INCREMENT,
	tipo text COLLATE utf8mb4_spanish_ci NOT NULL,
	altura int(11) NOT NULL,
	anchura int(11) NOT NULL,
	color1 varchar(255) COLLATE utf8mb4_spanish_ci NOT NULL,
	color2 varchar(255) COLLATE utf8mb4_spanish_ci NOT NULL,
	titulo text COLLATE utf8mb4_spanish_ci NOT NULL,
	descripcion varchar(255) COLLATE utf8mb4_spanish_ci NOT NULL,
	encabezados varchar(255) COLLATE utf8mb4_spanish_ci NOT NULL,
	status int(11) NOT NULL,
	id_tt int (11) NOT NULL,
	FOREIGN KEY (id_tt) REFERENCES type_tabla(id_tt),
	PRIMARY KEY(id_t)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

CREATE TABLE elemento_controlDos(
	id_e int(11) NOT NULL ,
	FOREIGN KEY(id_e) REFERENCES elemento(id_e),
	id_t int(11) NOT NULL ,
	FOREIGN  KEY(id_t) REFERENCES control_dos(id_t),
	id_co int(11) NOT NULL,
	FOREIGN KEY(id_co) REFERENCES conexion(id_co),
	PRIMARY KEY (id_e, id_t, id_co)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- Query para mostrar los datos de controlDos en la vista

SELECT c2.id_t, c2.id_tt, m.id_m, ec2.id_e, ec2.id_co,
	   m.nombre as modulo, c2.tipo, c2.altura, c2.anchura, c2.color1, c2.color2, c2.titulo, c2.descripcion,
       p.posicionx, p.posiciony, tt.type, c.url, c2.encabezados,
       p.id_p
FROM modulo m, elemento_controlDos ec2, elemento e, control_dos c2, posicion p, type_tabla tt, 
    conexion c
WHERE ec2.id_t = c2.id_t and ec2.id_e = e.id_e and e.id_m = m.id_m and -- enlazo con el modulo
	  e.id_p = p.id_p and -- enlazo con las posicion
	  c2.id_tt = tt.id_tt and -- enlazo con type tabla
	  ec2.id_co = c.id_co and -- enlazo con conexion
	  c2.status = 1 -- que este activo


-- PROCEDIMIENTO ALMACENADO PARE INSERTAR ALTA CONTROL 2

DELIMITER $$
DROP PROCEDURE IF EXISTS insertControlDos $$
CREATE PROCEDURE insertControlDos(
	IN id_m int, IN id_tt int, IN id_co int, IN enca text,
	IN pos_x text, IN pos_y text, IN altura int, IN anchura int, IN colorUno text,
	IN colorDos text, IN tipo text, IN titulo text, IN descr text
)

BEGIN
	INSERT INTO posicion (posicionx,posiciony) VALUES (pos_x,pos_y);
	INSERT INTO elemento (id_m, id_p) VALUES (id_m,LAST_INSERT_ID());

	select @idElemento := LAST_INSERT_ID();

	INSERT INTO control_dos (tipo,altura,anchura,color1,color2,titulo,descripcion,encabezados,id_tt,status) 
	                 VALUES (tipo,altura,anchura,colorUno,colorDos,titulo,descr,enca,id_tt,1);
	INSERT INTO elemento_controlDos (id_e,id_t,id_co) VALUES (@idElemento,LAST_INSERT_ID(),id_co);
END
$$

CALL insertControlDos(1,8,1,'encabezados','pos_x','pos_y',12,12,'color1','color2','tipo','titulo','descripcion');

-- PROCEDIMIENTO ALMACENADO PARE EDITAR ALTA CONTROL 2

DELIMITER $$
DROP PROCEDURE IF EXISTS updateControlDos $$
CREATE PROCEDURE updateControlDos(
	IN id_m_ int, IN id_tt_ int, IN id_co_ int, IN enca text,
	IN pos_x text, IN pos_y text, IN altura_ int, IN anchura_ int, IN colorUno text,
	IN colorDos text, IN tipo_ text, IN titulo_ text, IN descr text,
	IN id_t_ int, -- id control
	IN id_p_ int, -- id posicion
	IN id_e_ int -- id elemento
)

BEGIN
	UPDATE posicion set posicionx = pos_x, posiciony = pos_y WHERE id_p = id_p_;

	UPDATE elemento set id_m = id_m_ WHERE id_e = id_e_ ;

	UPDATE control_dos set tipo = tipo_ ,altura = altura_ ,anchura = anchura_,
	                      color1 = colorUno,color2 = colorDos,titulo=titulo_,
	                      descripcion = descr, encabezados = enca,id_tt = id_tt_ WHERE id_t = id_t_;

	UPDATE elemento_controlDos set id_co = id_co_  WHERE id_t = id_t_ and id_e = id_e_;
END
$$



------------------------------------------- CONTROL 3 ---------------------------------------

CREATE TABLE control_tres(
	id_g int(11) NOT NULL AUTO_INCREMENT,
	tipo text COLLATE utf8mb4_spanish_ci NOT NULL,
	altura int(11) NOT NULL,
	anchura int(11) NOT NULL,
	color1 varchar(255) COLLATE utf8mb4_spanish_ci NOT NULL,
	color2 varchar(255) COLLATE utf8mb4_spanish_ci NOT NULL,
	titulo text COLLATE utf8mb4_spanish_ci NOT NULL,
	descripcion varchar(255) COLLATE utf8mb4_spanish_ci NOT NULL,
	seriex varchar(255) COLLATE utf8mb4_spanish_ci NOT NULL,
	seriey varchar(255) COLLATE utf8mb4_spanish_ci NOT NULL,
	status int(11) NOT NULL,
	id_tg int (11) NOT NULL,
	FOREIGN KEY (id_tg) REFERENCES type_grafica(id_tg),
	PRIMARY KEY(id_g)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

CREATE TABLE elemento_controlTres(
	id_e int(11) NOT NULL ,
	FOREIGN KEY(id_e) REFERENCES elemento(id_e),
	id_g int(11) NOT NULL ,
	FOREIGN  KEY(id_g) REFERENCES control_tres(id_g),
	id_co int(11) NOT NULL,
	FOREIGN KEY(id_co) REFERENCES conexion(id_co),
	PRIMARY KEY (id_e, id_g, id_co)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- Query para mostrar los datos de controlTres en la vista

SELECT c3.id_g, c3.id_tg, m.id_m, ec3.id_e, ec3.id_co,
	   m.nombre as modulo, c3.tipo, c3.altura, c3.anchura, c3.color1, c3.color2, c3.titulo, c3.descripcion,
       p.posicionx, p.posiciony, tg.type, c.url, c3.seriex, c3.seriey,
       p.id_p
FROM modulo m, elemento_controlTres ec3, elemento e, control_tres c3, posicion p, type_grafica tg, 
    conexion c
WHERE ec3.id_g = c3.id_g and ec3.id_e = e.id_e and e.id_m = m.id_m and -- enlazo con el modulo
	  e.id_p = p.id_p and -- enlazo con las posicion
	  c3.id_tg = tg.id_tg and -- enlazo con type grafica
	  ec3.id_co = c.id_co and -- enlazo con conexion
	  c3.status = 1 -- que este activo



-- PROCEDIMIENTO ALMACENADO PARE INSERTAR ALTA CONTROL 3


DELIMITER $$
DROP PROCEDURE IF EXISTS insertControlTres $$
CREATE PROCEDURE insertControlTres(
	IN id_m int, IN id_tg int, IN id_co int,
	IN pos_x text, IN pos_y text, IN altura int, IN anchura int, IN colorUno text,
	IN colorDos text, IN tipo text, IN titulo text, IN descr text, IN serie_x text,
	IN serie_y text
)

BEGIN
	INSERT INTO posicion (posicionx,posiciony) VALUES (pos_x,pos_y);
	INSERT INTO elemento (id_m, id_p) VALUES (id_m,LAST_INSERT_ID());

	select @idElemento := LAST_INSERT_ID();

	INSERT INTO control_tres (tipo,altura,anchura,color1,color2,titulo,descripcion,seriex,seriey,id_tg,status) 
	                 VALUES (tipo,altura,anchura,colorUno,colorDos,titulo,descr,serie_x,serie_y,id_tg,1);
	INSERT INTO elemento_controlTres (id_e,id_g,id_co) VALUES (@idElemento,LAST_INSERT_ID(),id_co);
END
$$


-- PROCEDIMIENTO ALMACENADO PARE EDITAR ALTA CONTROL 3


DELIMITER $$
DROP PROCEDURE IF EXISTS updateControlTres $$
CREATE PROCEDURE updateControlTres(
	IN id_m_ int, IN id_tg_ int, IN id_co_ int,
	IN pos_x text, IN pos_y text, IN altura_ int, IN anchura_ int, IN colorUno text,
	IN colorDos text, IN tipo_ text, IN titulo_ text, IN descr text, IN serie_x text,
	IN serie_y text,
	IN id_g_ int, -- id control
	IN id_p_ int, -- id posicion
	IN id_e_ int -- id elemento
)

BEGIN
	UPDATE posicion set posicionx = pos_x, posiciony = pos_y WHERE id_p = id_p_;

	UPDATE elemento set id_m = id_m_ WHERE id_e = id_e_ ;

	UPDATE control_tres set tipo = tipo_ ,altura = altura_ ,anchura = anchura_,
	                      color1 = colorUno, color2 = colorDos,titulo=titulo_,
	                      descripcion = descr, seriex = serie_x,seriey=serie_y,id_tg = id_tg_ 
	                      WHERE id_g = id_g_;

	UPDATE elemento_controlTres set id_co = id_co_  WHERE id_g = id_g_ and id_e = id_e_;
END
$$

---- SIGUIENTE CRUD -------------

CREATE TABLE tipo_campo(
	id_tca int(11) NOT NULL AUTO_INCREMENT,
	nombre text,
	PRIMARY KEY (id_tca)
);

CREATE TABLE mnemotecnico_generico(
	id_mge int(11) NOT NULL AUTO_INCREMENT,
	id_tca int(11) NOT NULL,
	FOREIGN KEY(id_tca) REFERENCES tipo_campo(id_tca),
	mnemotecnico text NOT NULL,
	label text NOT NULL,
	valor_default text NOT NULL,
	status INT NOT NULL DEFAULT 0,
	valor_query TEXT NOT NULL,
	PRIMARY KEY (id_mge)
);

CREATE TABLE elemento_mge(
	id_e int(11) NOT NULL,
	id_mge int(11) NOT NULL,
	id_co int(11) NOT NULL,
	FOREIGN KEY(id_e) REFERENCES elemento(id_e),
	FOREIGN KEY(id_mge) REFERENCES mnemotecnico_generico(id_mge),
	FOREIGN KEY(id_co) REFERENCES conexion(id_co),
	PRIMARY KEY(id_e,id_mge,id_co)
);

CREATE TABLE control1_mg(
	id_c int(11) NOT NULL,
	id_mge int(11) NOT NULL,
	FOREIGN KEY(id_c) REFERENCES control_uno(id_c),
	FOREIGN KEY(id_mge) REFERENCES mnemotecnico_generico(id_mge),
	PRIMARY KEY(id_c,id_mge)
);

CREATE TABLE control2_mg(
	id_t int(11) NOT NULL,
	id_mge int(11) NOT NULL,
	FOREIGN KEY(id_t) REFERENCES control_dos(id_t),
	FOREIGN KEY(id_mge) REFERENCES mnemotecnico_generico(id_mge),
	PRIMARY KEY(id_t,id_mge)
);

CREATE TABLE control3_mg(
	id_g int(11) NOT NULL,
	id_mge int(11) NOT NULL,
	FOREIGN KEY(id_g) REFERENCES control_tres(id_g),
	FOREIGN KEY(id_mge) REFERENCES mnemotecnico_generico(id_mge),
	PRIMARY KEY(id_g,id_mge)
);

-- Consulta que devuelve los controles 1 que pertences al modulo seleccionado
SELECT ec1.id_c,ec1.id_e, c1.titulo
FROM elemento e, elemento_controlUno ec1, control_uno c1
WHERE e.id_e = ec1.id_e and ec1.id_c = c1.id_c and c1.status = 1 and e.id_m = 1;

-- Consulta que devuelve los controles 2 que pertences al modulo seleccionado
SELECT ec2.id_t,ec2.id_e, c2.titulo
FROM elemento e, elemento_controlDos ec2, control_dos c2
WHERE e.id_e = ec2.id_e and ec2.id_t = c2.id_t and c2.status = 1 and e.id_m = 1;

-- Consulta que devuelve los controles 3 que pertences al modulo seleccionado
SELECT ec3.id_g,ec3.id_e, c3.titulo
FROM elemento e, elemento_controlTres ec3, control_tres c3
WHERE e.id_e = ec3.id_e and ec3.id_g = c3.id_g and c3.status = 1 and e.id_m = 1;

-- PROCEDIMIENTO ALMACENADO PARA ALTA MNEMOTECNICO

DELIMITER $$
DROP PROCEDURE IF EXISTS alta_mnemotecnico $$
CREATE PROCEDURE alta_mnemotecnico(
	IN id_tca int, IN mnemotecnico text, IN label text, IN valor_default text,
	IN pos_x int, IN pos_y int, IN id_m int, IN controles_1 text, IN controles_2 text,
	IN controles_3 text, IN id_co int, IN valor_query text
)
BEGIN

	DECLARE _next TEXT DEFAULT NULL;
	DECLARE _nextlen INT DEFAULT NULL;
	DECLARE _value TEXT DEFAULT NULL;

	DECLARE id_nemo int;
	DECLARE id_pos int;
	DECLARE id_elemento int;

	-- INSERTAMOS EN LA TABLA MNEMOTECNICO
	INSERT INTO mnemotecnico_generico (id_tca,mnemotecnico,label,valor_default,valor_query) 
	VALUES (id_tca,mnemotecnico,label,valor_default,valor_query);

	-- GUARDAMOS EL ID DE MNEMOTECNICO
	SET id_nemo := LAST_INSERT_ID();

	-- INSERTAMOS EN POSICION
	INSERT INTO posicion (posicionx,posiciony) VALUES (pos_x,pos_y);

	SET id_pos := LAST_INSERT_ID();

	-- INSERTAMOS EN LA TABLA ELEMENTO
	INSERT INTO elemento (id_p,id_m) VALUES (id_pos,id_m);

	-- GUARDAMOS EL ID DE ELEMENTO
	SET id_elemento := LAST_INSERT_ID();

	-- INSERTAMOS EN LA TABLA ELEMENTO_MGE
	INSERT INTO elemento_mge VALUES (id_elemento,id_nemo,id_co);

	-- INSERTAMOS TODOS LOS CONTROLES 1
	iterator:
	LOOP
	    
	     IF LENGTH(TRIM(controles_1)) = 0 OR controles_1 IS NULL THEN
	       LEAVE iterator;
	     END IF;

	    
	     SET _next = SUBSTRING_INDEX(controles_1,',',1);

	     SET _nextlen = LENGTH(_next);

	     -- trim the value of leading and trailing spaces, in case of sloppy CSV strings
	     SET _value = TRIM(_next);

	     -- insert the extracted value into the target table
	     INSERT INTO control1_mg (id_c,id_mge) VALUES (_next, id_nemo);

	     SET controles_1 = INSERT(controles_1,1,_nextlen + 1,'');
	END LOOP;

	-- INSERTAMOS TODOS LOS CONTROLES 2
	iterator:
	LOOP
	    
	     IF LENGTH(TRIM(controles_2)) = 0 OR controles_2 IS NULL THEN
	       LEAVE iterator;
	     END IF;

	    
	     SET _next = SUBSTRING_INDEX(controles_2,',',1);

	     SET _nextlen = LENGTH(_next);

	     -- trim the value of leading and trailing spaces, in case of sloppy CSV strings
	     SET _value = TRIM(_next);

	     -- insert the extracted value into the target table
	     INSERT INTO control2_mg (id_t,id_mge) VALUES (_next, id_nemo);

	     SET controles_2 = INSERT(controles_2,1,_nextlen + 1,'');
	END LOOP;

	-- INSERTAMOS TODOS LOS CONTROLES 3
	iterator:
	LOOP
	    
	     IF LENGTH(TRIM(controles_3)) = 0 OR controles_3 IS NULL THEN
	       LEAVE iterator;
	     END IF;

	    
	     SET _next = SUBSTRING_INDEX(controles_3,',',1);

	     SET _nextlen = LENGTH(_next);

	     -- trim the value of leading and trailing spaces, in case of sloppy CSV strings
	     SET _value = TRIM(_next);

	     -- insert the extracted value into the target table
	     INSERT INTO control3_mg (id_g,id_mge) VALUES (_next, id_nemo);

	     SET controles_3 = INSERT(controles_3,1,_nextlen + 1,'');
	END LOOP;
	
END $$

CALL alta_mnemotecnico(1,'Nemo', 'label', 'default', 190, 190,1,'14,15','13','1232');


-- CONSULTA PARA VISUALIZAR LOS DATOS

SELECT 
mg.id_mge,mg.id_tca,tc.nombre,mg.mnemotecnico,mg.label,mg.valor_default,e.id_m,e.id_p,p.posicionx,posiciony,
e.id_e,mg.valor_query,emge.id_co  
FROM 
mnemotecnico_generico mg, tipo_campo tc, elemento_mge emge, elemento e, posicion p
WHERE 
tc.id_tca = mg.id_tca and emge.id_mge = mg.id_mge and emge.id_e = e.id_e and
	  e.id_p = p.id_p and mg.status = 1


-- PROCEDIMIENTO PARA EDITAR MNEMOTECNICO
DELIMITER $$
DROP PROCEDURE IF EXISTS editar_mnemotecnico $$
CREATE PROCEDURE editar_mnemotecnico(
	IN _id_tca int, IN _mnemotecnico text, IN _label text, IN _valor_default text,
	IN pos_x int, IN pos_y int, IN _id_m int, IN controles_1 text, IN controles_2 text,
	IN controles_3 text,
	IN _id_e int, IN _id_p int, IN _id_mge int,
	IN _id_co int, IN _valor_query text
)
BEGIN

	DECLARE _next TEXT DEFAULT NULL;
	DECLARE _nextlen INT DEFAULT NULL;
	DECLARE _value TEXT DEFAULT NULL;

	DECLARE id_nemo int;
	DECLARE id_pos int;
	DECLARE id_elemento int;

	-- MODIFICAMOS LA TABLA POSICION
	UPDATE posicion set posicionx = pos_x, posiciony = pos_y WHERE id_p = _id_p;

	-- MODIFICAMOS LA TABLA ELEMENTO
	UPDATE elemento set id_m = _id_m WHERE id_e = _id_e;

	-- MODIFICAMOS LA TABLA ELEMENTO_MGE
	UPDATE elemento_mge set id_co = _id_co WHERE id_e = _id_e and id_mge = _id_mge;

	-- MODIFICAMOS LA TABLA MNEMOTECNICO
	UPDATE mnemotecnico_generico set id_tca = _id_tca, mnemotecnico = _mnemotecnico, 
	label = _label, valor_default = _valor_default, valor_query = _valor_query WHERE id_mge = _id_mge;

	-- ELIMINAMOS TODOS LOS CONTROLES DE LA TABLA controles_mg donde id_mge se igual al que editamos
	DELETE FROM control1_mg WHERE id_mge = _id_mge;
	DELETE FROM control2_mg WHERE id_mge = _id_mge;
	DELETE FROM control3_mg WHERE id_mge = _id_mge;

	SET id_nemo = _id_mge;

	-- INSERTAMOS TODOS LOS CONTROLES 1
	iterator:
	LOOP
	    
	     IF LENGTH(TRIM(controles_1)) = 0 OR controles_1 IS NULL THEN
	       LEAVE iterator;
	     END IF;

	    
	     SET _next = SUBSTRING_INDEX(controles_1,',',1);

	     SET _nextlen = LENGTH(_next);

	     -- trim the value of leading and trailing spaces, in case of sloppy CSV strings
	     SET _value = TRIM(_next);

	     -- insert the extracted value into the target table
	     INSERT INTO control1_mg (id_c,id_mge) VALUES (_next, id_nemo);

	     SET controles_1 = INSERT(controles_1,1,_nextlen + 1,'');
	END LOOP;

	-- INSERTAMOS TODOS LOS CONTROLES 2
	iterator:
	LOOP
	    
	     IF LENGTH(TRIM(controles_2)) = 0 OR controles_2 IS NULL THEN
	       LEAVE iterator;
	     END IF;

	    
	     SET _next = SUBSTRING_INDEX(controles_2,',',1);

	     SET _nextlen = LENGTH(_next);

	     -- trim the value of leading and trailing spaces, in case of sloppy CSV strings
	     SET _value = TRIM(_next);

	     -- insert the extracted value into the target table
	     INSERT INTO control2_mg (id_t,id_mge) VALUES (_next, id_nemo);

	     SET controles_2 = INSERT(controles_2,1,_nextlen + 1,'');
	END LOOP;

	-- INSERTAMOS TODOS LOS CONTROLES 3
	iterator:
	LOOP
	    
	     IF LENGTH(TRIM(controles_3)) = 0 OR controles_3 IS NULL THEN
	       LEAVE iterator;
	     END IF;

	    
	     SET _next = SUBSTRING_INDEX(controles_3,',',1);

	     SET _nextlen = LENGTH(_next);

	     -- trim the value of leading and trailing spaces, in case of sloppy CSV strings
	     SET _value = TRIM(_next);

	     -- insert the extracted value into the target table
	     INSERT INTO control3_mg (id_g,id_mge) VALUES (_next, id_nemo);

	     SET controles_3 = INSERT(controles_3,1,_nextlen + 1,'');
	END LOOP;
	
END $$
