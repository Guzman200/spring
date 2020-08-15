--
-- Estructura de tabla para la tabla `type_bd`
--

CREATE TABLE `type_bd` (
  `id_tbd` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` text COLLATE utf8mb4_spanish_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_spanish_ci NOT NULL,
  PRIMARY KEY (`id_tbd`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `type_bd`
--

-- --------------------------------------------------------

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `type_card`
--

CREATE TABLE `type_card` (
  `id_tc` int(11) NOT NULL AUTO_INCREMENT,
  `type` text COLLATE utf8mb4_spanish_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_spanish_ci NOT NULL,
  PRIMARY KEY (`id_tc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `type_card`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `type_grafica`
--

CREATE TABLE `type_grafica` (
  `id_tg` int(11) NOT NULL AUTO_INCREMENT,
  `type` text COLLATE utf8mb4_spanish_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_spanish_ci NOT NULL,
  PRIMARY KEY (`id_tg`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `type_tabla`
--

CREATE TABLE `type_tabla` (
  `id_tt` int(11) NOT NULL AUTO_INCREMENT,
  `type` text COLLATE utf8mb4_spanish_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_spanish_ci NOT NULL,
  PRIMARY KEY (`id_tt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;


-- Empieza la creacion de las tablas para los controles

CREATE TABLE posicion(
	id_p int(11) NOT NULL AUTO_INCREMENT,
	posicion_x int (11) NOT NULL,
	posicion_y int (11) NOT NULL,
	PRIMARY KEY(id_p)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

CREATE TABLE elemento(
	id_e int(11) NOT NULL AUTO_INCREMENT,
	id_m int (11) NOT NULL,
	id_p int (11) NOT NULL, 
	FOREIGN KEY (id_m) REFERENCES modulo(id_m),
	FOREIGN KEY (id_p) REFERENCES posicion(id_p),
	PRIMARY KEY(id_e)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

CREATE TABLE control_uno(
	id_c int(11) NOT NULL AUTO_INCREMENT,
	tipo text COLLATE utf8mb4_spanish_ci NOT NULL,
	altura int(11) NOT NULL,
	anchura int(11) NOT NULL,
	color_1 varchar(255) COLLATE utf8mb4_spanish_ci NOT NULL,
	color_2 varchar(255) COLLATE utf8mb4_spanish_ci NOT NULL,
	titulo text COLLATE utf8mb4_spanish_ci NOT NULL,
	descripcion varchar(255) COLLATE utf8mb4_spanish_ci NOT NULL,
	id_f int(11) NOT NULL,
	FOREIGN KEY (id_f) REFERENCES formato(id_f),
	id_tc int(11) NOT NULL,
	FOREIGN KEY (id_tc) REFERENCES type_card(id_tc),
	status int(11) NOT NULL,
	PRIMARY KEY(id_c)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

CREATE TABLE elemento_controlUno(
	id_e int(11) NOT NULL ,
	FOREIGN KEY(id_e) REFERENCES elemento(id_e),
	id_c int(11) NOT NULL ,
	FOREIGN  KEY(id_c) REFERENCES control_uno(id_c),
	id_co int(11) NOT NULL,
	FOREIGN KEY(id_co) REFERENCES conexion(id_co),
	PRIMARY KEY (id_e, id_c, id_co)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- Query para mostrar los datos de controlUno en la vista

SELECT c1.id_c, c1.id_tc, m.id_m,c1.id_f, ec1.id_e, ec1.id_co,
	   m.nombre as modulo, c1.tipo, c1.altura, c1.anchura, c1.color_1, c1.color_2, c1.titulo, c1.descripcion,
       p.posicion_x, p.posicion_y, f.nombre as formato, tc.type as tc, c.url,
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

DROP PROCEDURE IF EXISTS insertControlUno

DELIMITER $$
CREATE PROCEDURE insertControlUno(
	IN id_m int, IN id_tc int, IN id_co int, IN id_f int,
	IN pos_x text, IN pos_y text, IN altura int, IN anchura int, IN colorUno text,
	IN colorDos text, IN tipo text, IN titulo text, IN descr text
)

BEGIN
	INSERT INTO posicion (posicion_x,posicion_y) VALUES (pos_x,pos_y);
	INSERT INTO elemento (id_m, id_p) VALUES (id_m,LAST_INSERT_ID());

	select @idElemento := LAST_INSERT_ID();

	INSERT INTO control_uno (tipo,altura,anchura,color_1,color_2,titulo,descripcion,id_f,id_tc,status) 
	                 VALUES (tipo,altura,anchura,colorUno,colorDos,titulo,descr,id_f,id_tc,1);
	INSERT INTO elemento_controlUno (id_e,id_c,id_co) VALUES (@idElemento,LAST_INSERT_ID(),id_co);
END
$$

CALL insertControlUno(1,1,8,1,1,'120','120',440,440,'123','123','tipo pl','pl titulo','descr pl');

-- PROCEDIMIENTO ALMACENADO PARE EDITAR ALTA CONTROL 1

DROP PROCEDURE IF EXISTS updateControlUno

DELIMITER $$
CREATE PROCEDURE updateControlUno(
	IN id_m_ int, IN id_tc_ int, IN id_co_ int, IN id_f_ int,
	IN pos_x text, IN pos_y text, IN altura_ int, IN anchura_ int, IN colorUno text,
	IN colorDos text, IN tipo_ text, IN titulo_ text, IN descr text,
	IN id_c_ int, -- id conexion
	IN id_p_ int, -- id posicion
	IN id_e_ int -- id elemento
)

BEGIN
	UPDATE posicion set posicion_x = pos_x, posicion_y = pos_y WHERE id_p = id_p_;

	UPDATE elemento set id_m = id_m_ WHERE id_e = id_e_ ;

	UPDATE control_uno set tipo = tipo_ ,altura = altura_ ,anchura = anchura_,
	                      color_1 = colorUno,color_2 = colorDos,titulo=titulo_,
	                      descripcion = descr, id_f = id_f_ , id_tc = id_tc_ WHERE id_c = id_c_;

	UPDATE elemento_controlUno set id_co = id_co_  WHERE id_c = id_c_ and id_e = id_e_;
END
$$

CALL insertControlUno(1,1,8,1,1,'120','120',440,440,'123','123','tipo pl','pl titulo','descr pl',1,);

-- CONTROL 2 ---------------------------------------

CREATE TABLE control_dos(
	id_t int(11) NOT NULL AUTO_INCREMENT,
	tipo text COLLATE utf8mb4_spanish_ci NOT NULL,
	altura int(11) NOT NULL,
	anchura int(11) NOT NULL,
	color_1 varchar(255) COLLATE utf8mb4_spanish_ci NOT NULL,
	color_2 varchar(255) COLLATE utf8mb4_spanish_ci NOT NULL,
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
	   m.nombre as modulo, c2.tipo, c2.altura, c2.anchura, c2.color_1, c2.color_2, c2.titulo, c2.descripcion,
       p.posicion_x, p.posicion_y, tt.type, c.url, c2.encabezados,
       p.id_p
FROM modulo m, elemento_controlDos ec2, elemento e, control_dos c2, posicion p, type_tabla tt, 
    conexion c
WHERE ec2.id_t = c2.id_t and ec2.id_e = e.id_e and e.id_m = m.id_m and -- enlazo con el modulo
	  e.id_p = p.id_p and -- enlazo con las posicion
	  c2.id_tt = tt.id_tt and -- enlazo con type tabla
	  ec2.id_co = c.id_co and -- enlazo con conexion
	  c2.status = 1 -- que este activo


-- PROCEDIMIENTO ALMACENADO PARE INSERTAR ALTA CONTROL 2

DROP PROCEDURE IF EXISTS insertControlUno

DELIMITER $$
CREATE PROCEDURE insertControlDos(
	IN id_m int, IN id_tt int, IN id_co int, IN enca text,
	IN pos_x text, IN pos_y text, IN altura int, IN anchura int, IN colorUno text,
	IN colorDos text, IN tipo text, IN titulo text, IN descr text
)

BEGIN
	INSERT INTO posicion (posicion_x,posicion_y) VALUES (pos_x,pos_y);
	INSERT INTO elemento (id_m, id_p) VALUES (id_m,LAST_INSERT_ID());

	select @idElemento := LAST_INSERT_ID();

	INSERT INTO control_dos (tipo,altura,anchura,color_1,color_2,titulo,descripcion,encabezados,id_tt,status) 
	                 VALUES (tipo,altura,anchura,colorUno,colorDos,titulo,descr,enca,id_tt,1);
	INSERT INTO elemento_controlDos (id_e,id_t,id_co) VALUES (@idElemento,LAST_INSERT_ID(),id_co);
END
$$

CALL insertControlDos(1,8,1,'encabezados','pos_x','pos_y',12,12,'color1','color2','tipo','titulo','descripcion');

-- PROCEDIMIENTO ALMACENADO PARE EDITAR ALTA CONTROL 2

DROP PROCEDURE IF EXISTS updateControlDos

DELIMITER $$
CREATE PROCEDURE updateControlDos(
	IN id_m_ int, IN id_tt_ int, IN id_co_ int, IN enca text,
	IN pos_x text, IN pos_y text, IN altura_ int, IN anchura_ int, IN colorUno text,
	IN colorDos text, IN tipo_ text, IN titulo_ text, IN descr text,
	IN id_t_ int, -- id control
	IN id_p_ int, -- id posicion
	IN id_e_ int -- id elemento
)

BEGIN
	UPDATE posicion set posicion_x = pos_x, posicion_y = pos_y WHERE id_p = id_p_;

	UPDATE elemento set id_m = id_m_ WHERE id_e = id_e_ ;

	UPDATE control_dos set tipo = tipo_ ,altura = altura_ ,anchura = anchura_,
	                      color_1 = colorUno,color_2 = colorDos,titulo=titulo_,
	                      descripcion = descr, encabezados = enca,id_tt = id_tt_ WHERE id_t = id_t_;

	UPDATE elemento_controlDos set id_co = id_co_  WHERE id_t = id_t_ and id_e = id_e_;
END
$$



--------------------------- CONTROL 3 ---------------------------------------

CREATE TABLE control_tres(
	id_g int(11) NOT NULL AUTO_INCREMENT,
	tipo text COLLATE utf8mb4_spanish_ci NOT NULL,
	altura int(11) NOT NULL,
	anchura int(11) NOT NULL,
	color_1 varchar(255) COLLATE utf8mb4_spanish_ci NOT NULL,
	color_2 varchar(255) COLLATE utf8mb4_spanish_ci NOT NULL,
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
	   m.nombre as modulo, c3.tipo, c3.altura, c3.anchura, c3.color_1, c3.color_2, c3.titulo, c3.descripcion,
       p.posicion_x, p.posicion_y, tg.type, c.url, c3.seriex, c3.seriey,
       p.id_p
FROM modulo m, elemento_controlTres ec3, elemento e, control_tres c3, posicion p, type_grafica tg, 
    conexion c
WHERE ec3.id_g = c3.id_g and ec3.id_e = e.id_e and e.id_m = m.id_m and -- enlazo con el modulo
	  e.id_p = p.id_p and -- enlazo con las posicion
	  c3.id_tg = tg.id_tg and -- enlazo con type grafica
	  ec3.id_co = c.id_co and -- enlazo con conexion
	  c3.status = 1 -- que este activo



-- PROCEDIMIENTO ALMACENADO PARE INSERTAR ALTA CONTROL 3

DROP PROCEDURE IF EXISTS insertControlTres

DELIMITER $$
CREATE PROCEDURE insertControlTres(
	IN id_m int, IN id_tg int, IN id_co int,
	IN pos_x text, IN pos_y text, IN altura int, IN anchura int, IN colorUno text,
	IN colorDos text, IN tipo text, IN titulo text, IN descr text, IN serie_x text,
	IN serie_y text
)

BEGIN
	INSERT INTO posicion (posicion_x,posicion_y) VALUES (pos_x,pos_y);
	INSERT INTO elemento (id_m, id_p) VALUES (id_m,LAST_INSERT_ID());

	select @idElemento := LAST_INSERT_ID();

	INSERT INTO control_tres (tipo,altura,anchura,color_1,color_2,titulo,descripcion,seriex,seriey,id_tg,status) 
	                 VALUES (tipo,altura,anchura,colorUno,colorDos,titulo,descr,serie_x,serie_y,id_tg,1);
	INSERT INTO elemento_controlTres (id_e,id_g,id_co) VALUES (@idElemento,LAST_INSERT_ID(),id_co);
END
$$


-- PROCEDIMIENTO ALMACENADO PARE EDITAR ALTA CONTROL 3

DROP PROCEDURE IF EXISTS updateControlTres

DELIMITER $$
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
	UPDATE posicion set posicion_x = pos_x, posicion_y = pos_y WHERE id_p = id_p_;

	UPDATE elemento set id_m = id_m_ WHERE id_e = id_e_ ;

	UPDATE control_tres set tipo = tipo_ ,altura = altura_ ,anchura = anchura_,
	                      color_1 = colorUno,color_2 = colorDos,titulo=titulo_,
	                      descripcion = descr, seriex = serie_x,seriey=serie_y,id_tg = id_tg_ 
	                      WHERE id_g = id_g_;

	UPDATE elemento_controlTres set id_co = id_co_  WHERE id_g = id_g_ and id_e = id_e_;
END
$$

