-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 04-09-2020 a las 22:12:04
-- Versión del servidor: 10.4.11-MariaDB
-- Versión de PHP: 7.4.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `test`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `alta_mnemotecnico` (IN `id_tca` INT, IN `mnemotecnico` TEXT, IN `label` TEXT, IN `valor_default` TEXT, IN `pos_x` INT, IN `pos_y` INT, IN `id_m` INT, IN `controles_1` TEXT, IN `controles_2` TEXT, IN `controles_3` TEXT, IN `id_co` INT, IN `valor_query` TEXT)  BEGIN

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
	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `editar_mnemotecnico` (IN `_id_tca` INT, IN `_mnemotecnico` TEXT, IN `_label` TEXT, IN `_valor_default` TEXT, IN `pos_x` INT, IN `pos_y` INT, IN `_id_m` INT, IN `controles_1` TEXT, IN `controles_2` TEXT, IN `controles_3` TEXT, IN `_id_e` INT, IN `_id_p` INT, IN `_id_mge` INT, IN `_id_co` INT, IN `_valor_query` TEXT)  BEGIN

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
	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertControlDos` (IN `id_m` INT, IN `id_tt` INT, IN `id_co` INT, IN `enca` TEXT, IN `pos_x` TEXT, IN `pos_y` TEXT, IN `altura` INT, IN `anchura` INT, IN `colorUno` TEXT, IN `colorDos` TEXT, IN `tipo` TEXT, IN `titulo` TEXT, IN `descr` TEXT)  BEGIN
	INSERT INTO posicion (posicionx,posiciony) VALUES (pos_x,pos_y);
	INSERT INTO elemento (id_m, id_p) VALUES (id_m,LAST_INSERT_ID());

	select @idElemento := LAST_INSERT_ID();

	INSERT INTO control_dos (tipo,altura,anchura,color1,color2,titulo,descripcion,encabezados,id_tt,status) 
	                 VALUES (tipo,altura,anchura,colorUno,colorDos,titulo,descr,enca,id_tt,1);
	INSERT INTO elemento_controlDos (id_e,id_t,id_co) VALUES (@idElemento,LAST_INSERT_ID(),id_co);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertControlTres` (IN `id_m` INT, IN `id_tg` INT, IN `id_co` INT, IN `pos_x` TEXT, IN `pos_y` TEXT, IN `altura` INT, IN `anchura` INT, IN `colorUno` TEXT, IN `colorDos` TEXT, IN `tipo` TEXT, IN `titulo` TEXT, IN `descr` TEXT, IN `serie_x` TEXT, IN `serie_y` TEXT)  BEGIN
	INSERT INTO posicion (posicionx,posiciony) VALUES (pos_x,pos_y);
	INSERT INTO elemento (id_m, id_p) VALUES (id_m,LAST_INSERT_ID());

	select @idElemento := LAST_INSERT_ID();

	INSERT INTO control_tres (tipo,altura,anchura,color1,color2,titulo,descripcion,seriex,seriey,id_tg,status) 
	                 VALUES (tipo,altura,anchura,colorUno,colorDos,titulo,descr,serie_x,serie_y,id_tg,1);
	INSERT INTO elemento_controlTres (id_e,id_g,id_co) VALUES (@idElemento,LAST_INSERT_ID(),id_co);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertControlUno` (IN `id_m` INT, IN `id_tc` INT, IN `id_co` INT, IN `id_f` INT, IN `pos_x` TEXT, IN `pos_y` TEXT, IN `altura` INT, IN `anchura` INT, IN `colorUno` TEXT, IN `colorDos` TEXT, IN `tipo` TEXT, IN `titulo` TEXT, IN `descr` TEXT)  BEGIN
	INSERT INTO posicion (posicionx,posiciony) VALUES (pos_x,pos_y);
	INSERT INTO elemento (id_m, id_p) VALUES (id_m,LAST_INSERT_ID());

	select @idElemento := LAST_INSERT_ID();

	INSERT INTO control_uno (tipo,altura,anchura,color_1,color_2,titulo,descripcion,id_f,id_tc,status) 
	                 VALUES (tipo,altura,anchura,colorUno,colorDos,titulo,descr,id_f,id_tc,1);
	INSERT INTO elemento_controlUno (id_e,id_c,id_co) VALUES (@idElemento,LAST_INSERT_ID(),id_co);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_csv` (`_list` MEDIUMTEXT)  BEGIN

DECLARE _next TEXT DEFAULT NULL;
DECLARE _nextlen INT DEFAULT NULL;
DECLARE _value TEXT DEFAULT NULL;

iterator:
LOOP
     -- exit the loop if the list seems empty or was null;
     -- this extra caution is necessary to avoid an endless loop in the proc.
     IF LENGTH(TRIM(_list)) = 0 OR _list IS NULL THEN
       LEAVE iterator;
     END IF;

     -- capture the next value from the list
     SET _next = SUBSTRING_INDEX(_list,',',1);

     -- save the length of the captured value; we will need to remove this
     -- many characters + 1 from the beginning of the string 
     -- before the next iteration
     SET _nextlen = LENGTH(_next);

     -- trim the value of leading and trailing spaces, in case of sloppy CSV strings
     SET _value = TRIM(_next);

     -- insert the extracted value into the target table
     INSERT INTO t1 (c1) VALUES (_next);

     -- rewrite the original string using the `INSERT()` string function,
     -- args are original string, start position, how many characters to remove, 
     -- and what to "insert" in their place (in this case, we "insert"
     -- an empty string, which removes _nextlen + 1 characters)
     SET _list = INSERT(_list,1,_nextlen + 1,'');
END LOOP;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateControlDos` (IN `id_m_` INT, IN `id_tt_` INT, IN `id_co_` INT, IN `enca` TEXT, IN `pos_x` TEXT, IN `pos_y` TEXT, IN `altura_` INT, IN `anchura_` INT, IN `colorUno` TEXT, IN `colorDos` TEXT, IN `tipo_` TEXT, IN `titulo_` TEXT, IN `descr` TEXT, IN `id_t_` INT, IN `id_p_` INT, IN `id_e_` INT)  BEGIN
	UPDATE posicion set posicionx = pos_x, posiciony = pos_y WHERE id_p = id_p_;

	UPDATE elemento set id_m = id_m_ WHERE id_e = id_e_ ;

	UPDATE control_dos set tipo = tipo_ ,altura = altura_ ,anchura = anchura_,
	                      color1 = colorUno,color2 = colorDos,titulo=titulo_,
	                      descripcion = descr, encabezados = enca,id_tt = id_tt_ WHERE id_t = id_t_;

	UPDATE elemento_controlDos set id_co = id_co_  WHERE id_t = id_t_ and id_e = id_e_;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateControlTres` (IN `id_m_` INT, IN `id_tg_` INT, IN `id_co_` INT, IN `pos_x` TEXT, IN `pos_y` TEXT, IN `altura_` INT, IN `anchura_` INT, IN `colorUno` TEXT, IN `colorDos` TEXT, IN `tipo_` TEXT, IN `titulo_` TEXT, IN `descr` TEXT, IN `serie_x` TEXT, IN `serie_y` TEXT, IN `id_g_` INT, IN `id_p_` INT, IN `id_e_` INT)  BEGIN
	UPDATE posicion set posicionx = pos_x, posiciony = pos_y WHERE id_p = id_p_;

	UPDATE elemento set id_m = id_m_ WHERE id_e = id_e_ ;

	UPDATE control_tres set tipo = tipo_ ,altura = altura_ ,anchura = anchura_,
	                      color1 = colorUno, color2 = colorDos,titulo=titulo_,
	                      descripcion = descr, seriex = serie_x,seriey=serie_y,id_tg = id_tg_ 
	                      WHERE id_g = id_g_;

	UPDATE elemento_controlTres set id_co = id_co_  WHERE id_g = id_g_ and id_e = id_e_;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateControlUno` (IN `id_m_` INT, IN `id_tc_` INT, IN `id_co_` INT, IN `id_f_` INT, IN `pos_x` TEXT, IN `pos_y` TEXT, IN `altura_` INT, IN `anchura_` INT, IN `colorUno` TEXT, IN `colorDos` TEXT, IN `tipo_` TEXT, IN `titulo_` TEXT, IN `descr` TEXT, IN `id_c_` INT, IN `id_p_` INT, IN `id_e_` INT)  BEGIN
	UPDATE posicion set posicionx = pos_x, posiciony = pos_y WHERE id_p = id_p_;

	UPDATE elemento set id_m = id_m_ WHERE id_e = id_e_ ;

	UPDATE control_uno set tipo = tipo_ ,altura = altura_ ,anchura = anchura_,
	                      color_1 = colorUno,color_2 = colorDos,titulo=titulo_,
	                      descripcion = descr, id_f = id_f_ , id_tc = id_tc_ WHERE id_c = id_c_;

	UPDATE elemento_controlUno set id_co = id_co_  WHERE id_c = id_c_ and id_e = id_e_;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `conexion`
--

CREATE TABLE `conexion` (
  `id_co` int(11) NOT NULL,
  `url` text COLLATE utf8mb4_spanish_ci NOT NULL,
  `login` text COLLATE utf8mb4_spanish_ci NOT NULL,
  `password` text COLLATE utf8mb4_spanish_ci NOT NULL,
  `bd` text COLLATE utf8mb4_spanish_ci NOT NULL,
  `id_tbd` int(11) NOT NULL,
  `puerto` text COLLATE utf8mb4_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `conexion`
--

INSERT INTO `conexion` (`id_co`, `url`, `login`, `password`, `bd`, `id_tbd`, `puerto`) VALUES
(1, 'localhost', 'root', '12345', 'testing', 16, '5000'),
(3, '129.12.12.121', 'guzman', '12345', 'test', 1, '78'),
(4, 'https://yadi.sk/d/sg66GIekXt7rvQ', 'guzman', '12345', 'test', 1, '23123');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `control1_mg`
--

CREATE TABLE `control1_mg` (
  `id_c` int(11) NOT NULL,
  `id_mge` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `control1_mg`
--

INSERT INTO `control1_mg` (`id_c`, `id_mge`) VALUES
(14, 58),
(14, 59),
(15, 58);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `control2_mg`
--

CREATE TABLE `control2_mg` (
  `id_t` int(11) NOT NULL,
  `id_mge` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `control2_mg`
--

INSERT INTO `control2_mg` (`id_t`, `id_mge`) VALUES
(3, 59);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `control3_mg`
--

CREATE TABLE `control3_mg` (
  `id_g` int(11) NOT NULL,
  `id_mge` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `control3_mg`
--

INSERT INTO `control3_mg` (`id_g`, `id_mge`) VALUES
(5, 59);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `control_dos`
--

CREATE TABLE `control_dos` (
  `id_t` int(11) NOT NULL,
  `tipo` text COLLATE utf8mb4_spanish_ci NOT NULL,
  `altura` int(11) NOT NULL,
  `anchura` int(11) NOT NULL,
  `color1` varchar(255) COLLATE utf8mb4_spanish_ci NOT NULL,
  `color2` varchar(255) COLLATE utf8mb4_spanish_ci NOT NULL,
  `titulo` text COLLATE utf8mb4_spanish_ci NOT NULL,
  `descripcion` varchar(255) COLLATE utf8mb4_spanish_ci NOT NULL,
  `encabezados` varchar(255) COLLATE utf8mb4_spanish_ci NOT NULL,
  `status` int(11) NOT NULL,
  `id_tt` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `control_dos`
--

INSERT INTO `control_dos` (`id_t`, `tipo`, `altura`, `anchura`, `color1`, `color2`, `titulo`, `descripcion`, `encabezados`, `status`, `id_tt`) VALUES
(1, 'Testing', 12, 12, '#121', '#1212', 'titulo', '1323232', 'encabezados', 0, 9),
(2, 'tipo', 12, 12, '#00ff6e', '#ff0000', 'Control 2 titlo 2', 'descripcion', 'encabezados', 1, 8),
(3, '1', 1, 1, '#000000', '#000000', 'Control 2 titulo 3', '1111des', '1111', 1, 8),
(4, 'Tipo modificado', 1500, 1500, '#222222', '#11111', 'titulo modificado', 'Este es un testing', 'Encabezado testing', 0, 8),
(5, '12323', 23123, 23123, '#000000', '#000000', '21323', '21312', '23123', 1, 8);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `control_tres`
--

CREATE TABLE `control_tres` (
  `id_g` int(11) NOT NULL,
  `tipo` text COLLATE utf8mb4_spanish_ci NOT NULL,
  `altura` int(11) NOT NULL,
  `anchura` int(11) NOT NULL,
  `color1` varchar(255) COLLATE utf8mb4_spanish_ci NOT NULL,
  `color2` varchar(255) COLLATE utf8mb4_spanish_ci NOT NULL,
  `titulo` text COLLATE utf8mb4_spanish_ci NOT NULL,
  `descripcion` varchar(255) COLLATE utf8mb4_spanish_ci NOT NULL,
  `seriex` varchar(255) COLLATE utf8mb4_spanish_ci NOT NULL,
  `seriey` varchar(255) COLLATE utf8mb4_spanish_ci NOT NULL,
  `status` int(11) NOT NULL,
  `id_tg` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `control_tres`
--

INSERT INTO `control_tres` (`id_g`, `tipo`, `altura`, `anchura`, `color1`, `color2`, `titulo`, `descripcion`, `seriex`, `seriey`, `status`, `id_tg`) VALUES
(5, 'Tipo 4', 122, 122, '#fa00c4', '#0072d6', 'Title', 'Este es un testing', 'serie x edit', 'serie y edit', 1, 5),
(6, '121', 1212, 1212, '#000000', '#000000', '121', '2121', '1212', '1212', 1, 5),
(7, '1212', 12112, 1212, '#000000', '#000000', '12', '1212', '121', '121', 1, 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `control_uno`
--

CREATE TABLE `control_uno` (
  `id_c` int(11) NOT NULL,
  `tipo` text COLLATE utf8mb4_spanish_ci NOT NULL,
  `altura` int(11) NOT NULL,
  `anchura` int(11) NOT NULL,
  `color_1` varchar(255) COLLATE utf8mb4_spanish_ci NOT NULL,
  `color_2` varchar(255) COLLATE utf8mb4_spanish_ci NOT NULL,
  `titulo` text COLLATE utf8mb4_spanish_ci NOT NULL,
  `descripcion` varchar(255) COLLATE utf8mb4_spanish_ci NOT NULL,
  `id_f` int(11) NOT NULL,
  `id_tc` int(11) NOT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `control_uno`
--

INSERT INTO `control_uno` (`id_c`, `tipo`, `altura`, `anchura`, `color_1`, `color_2`, `titulo`, `descripcion`, `id_f`, `id_tc`, `status`) VALUES
(5, 'Tipo 4', 50, 50, '#13234', '#3123', 'Title', 'Testeo', 1, 8, 0),
(6, 'Plsql', 500, 450, 'ColorUno', 'Color2', 'Sin titulo', 'Este es un testing', 3, 8, 0),
(7, '2312', 3123, 2312, '2312', '31233', '2132', '213232312', 2, 8, 0),
(8, '121', 12, 121, '121', '121', '121', '121', 4, 9, 0),
(9, '23', 2312, 2312, '23', '1232', '2132', '23123', 1, 8, 0),
(10, '123', 2132, 232, '213', '2312', '2312', '2132', 2, 9, 0),
(11, '121', 121, 121, '122', '121', '21', '1212', 1, 8, 0),
(12, '12', 121, 121, '121', '121', '12', '121', 1, 8, 0),
(13, 'testing', 2, 2, '#848ec2', '#1d2d90', 'testing titulo', '....', 2, 8, 0),
(14, '12', 12, 12, '#7d6868', '#a40e0e', 'Control1 Titulo 14', '121', 1, 8, 1),
(15, '12121', 12, 12, '#000000', '#000000', 'Control1 Titulo 15', '12', 1, 8, 1),
(16, '312324', 1212, 212, '#000000', '#000000', 'Title', 'Este es un testing', 1, 8, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `elemento`
--

CREATE TABLE `elemento` (
  `id_e` int(11) NOT NULL,
  `id_m` int(11) NOT NULL,
  `id_p` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `elemento`
--

INSERT INTO `elemento` (`id_e`, `id_m`, `id_p`) VALUES
(6, 1, 6),
(7, 2, 7),
(8, 3, 8),
(9, 3, 9),
(10, 1, 10),
(11, 1, 11),
(12, 1, 12),
(13, 1, 13),
(14, 1, 14),
(15, 1, 15),
(16, 2, 16),
(17, 3, 17),
(18, 1, 18),
(19, 1, 19),
(20, 1, 20),
(21, 1, 21),
(22, 1, 22),
(23, 1, 23),
(26, 1, 25),
(27, 1, 26),
(28, 1, 27),
(29, 1, 28),
(30, 1, 29),
(31, 1, 30),
(32, 1, 31),
(33, 1, 32),
(34, 1, 33),
(35, 1, 34),
(36, 1, 35),
(37, 1, 36),
(38, 1, 37),
(39, 1, 38),
(40, 1, 39),
(41, 1, 40),
(42, 1, 41),
(43, 1, 42),
(44, 1, 43),
(45, 1, 44),
(46, 1, 45),
(47, 1, 46),
(48, 1, 47),
(49, 1, 48),
(50, 1, 49),
(51, 1, 50),
(52, 1, 51),
(53, 1, 52),
(54, 1, 53),
(55, 1, 54),
(56, 1, 55),
(57, 1, 56),
(58, 1, 57),
(59, 1, 58),
(60, 1, 59),
(61, 1, 60),
(62, 1, 61),
(63, 1, 62),
(64, 1, 63),
(65, 1, 64),
(66, 1, 65),
(67, 1, 66),
(68, 1, 67),
(69, 1, 68),
(70, 1, 69),
(71, 1, 70),
(72, 1, 71),
(73, 1, 72),
(74, 1, 73),
(75, 3, 74),
(78, 1, 77),
(79, 1, 78),
(80, 1, 79),
(81, 1, 80),
(82, 1, 81),
(83, 1, 82),
(84, 1, 83),
(85, 1, 84),
(86, 2, 85),
(87, 3, 86);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `elemento_controldos`
--

CREATE TABLE `elemento_controldos` (
  `id_e` int(11) NOT NULL,
  `id_t` int(11) NOT NULL,
  `id_co` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `elemento_controldos`
--

INSERT INTO `elemento_controldos` (`id_e`, `id_t`, `id_co`) VALUES
(6, 1, 3),
(14, 2, 1),
(15, 3, 1),
(16, 4, 1),
(85, 5, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `elemento_controltres`
--

CREATE TABLE `elemento_controltres` (
  `id_e` int(11) NOT NULL,
  `id_g` int(11) NOT NULL,
  `id_co` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `elemento_controltres`
--

INSERT INTO `elemento_controltres` (`id_e`, `id_g`, `id_co`) VALUES
(20, 5, 1),
(86, 6, 3),
(87, 7, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `elemento_controluno`
--

CREATE TABLE `elemento_controluno` (
  `id_e` int(11) NOT NULL,
  `id_c` int(11) NOT NULL,
  `id_co` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `elemento_controluno`
--

INSERT INTO `elemento_controluno` (`id_e`, `id_c`, `id_co`) VALUES
(6, 5, 1),
(7, 6, 1),
(8, 7, 1),
(9, 8, 3),
(10, 9, 1),
(11, 10, 1),
(12, 11, 1),
(13, 12, 1),
(21, 13, 1),
(22, 14, 1),
(23, 15, 3),
(84, 16, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `elemento_mge`
--

CREATE TABLE `elemento_mge` (
  `id_e` int(11) NOT NULL,
  `id_mge` int(11) NOT NULL,
  `id_co` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `elemento_mge`
--

INSERT INTO `elemento_mge` (`id_e`, `id_mge`, `id_co`) VALUES
(82, 58, 1),
(83, 59, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `formato`
--

CREATE TABLE `formato` (
  `id_f` int(11) NOT NULL,
  `nombre` text COLLATE utf8mb4_spanish_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `formato`
--

INSERT INTO `formato` (`id_f`, `nombre`, `descripcion`) VALUES
(1, 'Moneda', 'Formato expresado en pesos'),
(2, 'Número', 'Formato de número con dos digitos'),
(3, 'Porcentaje', 'Formato de porcentaje'),
(4, 'Cadena', 'Sin formato definido');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mnemotecnico_generico`
--

CREATE TABLE `mnemotecnico_generico` (
  `id_mge` int(11) NOT NULL,
  `id_tca` int(11) NOT NULL,
  `mnemotecnico` text NOT NULL,
  `label` text NOT NULL,
  `valor_default` text NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `valor_query` text NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `mnemotecnico_generico`
--

INSERT INTO `mnemotecnico_generico` (`id_mge`, `id_tca`, `mnemotecnico`, `label`, `valor_default`, `status`, `valor_query`) VALUES
(58, 1, 'Mnemotecnico mod', 'Label moc', 'Valor default', 1, 'Valor del query'),
(59, 1, '6521', '12312', '12123', 1, '68451320');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modulo`
--

CREATE TABLE `modulo` (
  `id_m` int(11) NOT NULL,
  `nombre` text COLLATE utf8mb4_spanish_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `modulo`
--

INSERT INTO `modulo` (`id_m`, `nombre`, `descripcion`) VALUES
(1, 'Modulo 1', 'Modulo de prueba'),
(2, 'Modulo 2', 'Este es el segundo modulo'),
(3, 'Modulo 3', 'Este es el modulo 3');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `posicion`
--

CREATE TABLE `posicion` (
  `id_p` int(11) NOT NULL,
  `posicionx` int(11) NOT NULL,
  `posiciony` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `posicion`
--

INSERT INTO `posicion` (`id_p`, `posicionx`, `posiciony`) VALUES
(6, 45, 45),
(7, 789, 789),
(8, 3123, 3123),
(9, 121, 121),
(10, 1323, 3123),
(11, 223, 223),
(12, 12, 12),
(13, 121, 121),
(14, 500, 500),
(15, 1, 1),
(16, 2000, 2000),
(17, 12, 12),
(18, 12, 12),
(19, 344, 344),
(20, 500, 600),
(21, 1, 1),
(22, 12, 12),
(23, 12, 12),
(24, 150, 150),
(25, 160, 160),
(26, 170, 170),
(27, 180, 180),
(28, 190, 190),
(29, 190, 190),
(30, 190, 190),
(31, 190, 190),
(32, 190, 190),
(33, 190, 190),
(34, 190, 190),
(35, 190, 190),
(36, 190, 190),
(37, 190, 190),
(38, 190, 190),
(39, 190, 190),
(40, 190, 190),
(41, 190, 190),
(42, 190, 190),
(43, 190, 190),
(44, 190, 190),
(45, 190, 190),
(46, 190, 190),
(47, 190, 190),
(48, 190, 190),
(49, 190, 190),
(50, 190, 190),
(51, 190, 190),
(52, 190, 190),
(53, 190, 190),
(54, 190, 190),
(55, 280, 280),
(56, 21212, 121),
(57, 190, 190),
(58, 21212, 121),
(59, 12, 12),
(60, 1212, 12),
(61, 12, 12),
(62, 112, 212),
(63, 12, 12),
(64, 190, 190),
(65, 190, 190),
(66, 800, 800),
(67, 1212, 1212),
(68, 1212, 1212),
(69, 121, 1212),
(70, 12121, 121),
(71, 212, 121),
(72, 850, 850),
(73, 900, 650),
(74, 3030, 3030),
(77, 787, 787),
(78, 2020, 2020),
(79, 1212, 1212),
(80, 5050, 5050),
(81, 500, 500),
(82, 500, 5000),
(83, 12, 12),
(84, 21, 213),
(85, 12, 13),
(86, 212, 200);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t1`
--

CREATE TABLE `t1` (
  `id` int(11) NOT NULL,
  `c1` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `t1`
--

INSERT INTO `t1` (`id`, `c1`) VALUES
(1, 'foo'),
(2, 'bar'),
(3, 'buzz'),
(4, 'fizz');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_campo`
--

CREATE TABLE `tipo_campo` (
  `id_tca` int(11) NOT NULL,
  `nombre` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tipo_campo`
--

INSERT INTO `tipo_campo` (`id_tca`, `nombre`) VALUES
(1, 'Normal'),
(2, 'Normal 2');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `type_bd`
--

CREATE TABLE `type_bd` (
  `id_tbd` int(11) NOT NULL,
  `nombre` text COLLATE utf8mb4_spanish_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_spanish_ci NOT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `type_bd`
--

INSERT INTO `type_bd` (`id_tbd`, `nombre`, `descripcion`, `status`) VALUES
(1, 'Postgresql', 'Una base de datos muy rapida', 1),
(15, 'Oracle', 'Es una base de datos de paga', 1),
(16, 'MySQL', '...', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `type_card`
--

CREATE TABLE `type_card` (
  `id_tc` int(11) NOT NULL,
  `type` text COLLATE utf8mb4_spanish_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_spanish_ci NOT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `type_card`
--

INSERT INTO `type_card` (`id_tc`, `type`, `descripcion`, `status`) VALUES
(8, 'Condicionada', '...', 1),
(9, 'Normal', '...', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `type_grafica`
--

CREATE TABLE `type_grafica` (
  `id_tg` int(11) NOT NULL,
  `type` text COLLATE utf8mb4_spanish_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_spanish_ci NOT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `type_grafica`
--

INSERT INTO `type_grafica` (`id_tg`, `type`, `descripcion`, `status`) VALUES
(5, 'grafica 500', 'grafica 1', 1),
(7, 'grafica 2500', 'grafica 2500', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `type_tabla`
--

CREATE TABLE `type_tabla` (
  `id_tt` int(11) NOT NULL,
  `type` text COLLATE utf8mb4_spanish_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_spanish_ci NOT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `type_tabla`
--

INSERT INTO `type_tabla` (`id_tt`, `type`, `descripcion`, `status`) VALUES
(8, 'Libre', '123', 1),
(9, '123', '1232', 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `conexion`
--
ALTER TABLE `conexion`
  ADD PRIMARY KEY (`id_co`);

--
-- Indices de la tabla `control1_mg`
--
ALTER TABLE `control1_mg`
  ADD PRIMARY KEY (`id_c`,`id_mge`),
  ADD KEY `id_mge` (`id_mge`);

--
-- Indices de la tabla `control2_mg`
--
ALTER TABLE `control2_mg`
  ADD PRIMARY KEY (`id_t`,`id_mge`),
  ADD KEY `id_mge` (`id_mge`);

--
-- Indices de la tabla `control3_mg`
--
ALTER TABLE `control3_mg`
  ADD PRIMARY KEY (`id_g`,`id_mge`),
  ADD KEY `id_mge` (`id_mge`);

--
-- Indices de la tabla `control_dos`
--
ALTER TABLE `control_dos`
  ADD PRIMARY KEY (`id_t`),
  ADD KEY `id_tt` (`id_tt`);

--
-- Indices de la tabla `control_tres`
--
ALTER TABLE `control_tres`
  ADD PRIMARY KEY (`id_g`),
  ADD KEY `id_tg` (`id_tg`);

--
-- Indices de la tabla `control_uno`
--
ALTER TABLE `control_uno`
  ADD PRIMARY KEY (`id_c`),
  ADD KEY `id_f` (`id_f`),
  ADD KEY `id_tc` (`id_tc`);

--
-- Indices de la tabla `elemento`
--
ALTER TABLE `elemento`
  ADD PRIMARY KEY (`id_e`),
  ADD KEY `id_m` (`id_m`),
  ADD KEY `id_p` (`id_p`);

--
-- Indices de la tabla `elemento_controldos`
--
ALTER TABLE `elemento_controldos`
  ADD PRIMARY KEY (`id_e`,`id_t`,`id_co`),
  ADD KEY `id_t` (`id_t`),
  ADD KEY `id_co` (`id_co`);

--
-- Indices de la tabla `elemento_controltres`
--
ALTER TABLE `elemento_controltres`
  ADD PRIMARY KEY (`id_e`,`id_g`,`id_co`),
  ADD KEY `id_g` (`id_g`),
  ADD KEY `id_co` (`id_co`);

--
-- Indices de la tabla `elemento_controluno`
--
ALTER TABLE `elemento_controluno`
  ADD PRIMARY KEY (`id_e`,`id_c`,`id_co`),
  ADD KEY `id_c` (`id_c`),
  ADD KEY `id_co` (`id_co`);

--
-- Indices de la tabla `elemento_mge`
--
ALTER TABLE `elemento_mge`
  ADD PRIMARY KEY (`id_e`,`id_mge`,`id_co`),
  ADD KEY `id_mge` (`id_mge`),
  ADD KEY `id_co` (`id_co`);

--
-- Indices de la tabla `formato`
--
ALTER TABLE `formato`
  ADD PRIMARY KEY (`id_f`);

--
-- Indices de la tabla `mnemotecnico_generico`
--
ALTER TABLE `mnemotecnico_generico`
  ADD PRIMARY KEY (`id_mge`),
  ADD KEY `id_tca` (`id_tca`);

--
-- Indices de la tabla `modulo`
--
ALTER TABLE `modulo`
  ADD PRIMARY KEY (`id_m`);

--
-- Indices de la tabla `posicion`
--
ALTER TABLE `posicion`
  ADD PRIMARY KEY (`id_p`);

--
-- Indices de la tabla `t1`
--
ALTER TABLE `t1`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tipo_campo`
--
ALTER TABLE `tipo_campo`
  ADD PRIMARY KEY (`id_tca`);

--
-- Indices de la tabla `type_bd`
--
ALTER TABLE `type_bd`
  ADD PRIMARY KEY (`id_tbd`);

--
-- Indices de la tabla `type_card`
--
ALTER TABLE `type_card`
  ADD PRIMARY KEY (`id_tc`);

--
-- Indices de la tabla `type_grafica`
--
ALTER TABLE `type_grafica`
  ADD PRIMARY KEY (`id_tg`);

--
-- Indices de la tabla `type_tabla`
--
ALTER TABLE `type_tabla`
  ADD PRIMARY KEY (`id_tt`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `conexion`
--
ALTER TABLE `conexion`
  MODIFY `id_co` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `control_dos`
--
ALTER TABLE `control_dos`
  MODIFY `id_t` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `control_tres`
--
ALTER TABLE `control_tres`
  MODIFY `id_g` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `control_uno`
--
ALTER TABLE `control_uno`
  MODIFY `id_c` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `elemento`
--
ALTER TABLE `elemento`
  MODIFY `id_e` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=88;

--
-- AUTO_INCREMENT de la tabla `formato`
--
ALTER TABLE `formato`
  MODIFY `id_f` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `mnemotecnico_generico`
--
ALTER TABLE `mnemotecnico_generico`
  MODIFY `id_mge` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT de la tabla `modulo`
--
ALTER TABLE `modulo`
  MODIFY `id_m` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `posicion`
--
ALTER TABLE `posicion`
  MODIFY `id_p` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=87;

--
-- AUTO_INCREMENT de la tabla `t1`
--
ALTER TABLE `t1`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `tipo_campo`
--
ALTER TABLE `tipo_campo`
  MODIFY `id_tca` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `type_bd`
--
ALTER TABLE `type_bd`
  MODIFY `id_tbd` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `type_card`
--
ALTER TABLE `type_card`
  MODIFY `id_tc` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `type_grafica`
--
ALTER TABLE `type_grafica`
  MODIFY `id_tg` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `type_tabla`
--
ALTER TABLE `type_tabla`
  MODIFY `id_tt` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `control1_mg`
--
ALTER TABLE `control1_mg`
  ADD CONSTRAINT `control1_mg_ibfk_1` FOREIGN KEY (`id_c`) REFERENCES `control_uno` (`id_c`),
  ADD CONSTRAINT `control1_mg_ibfk_2` FOREIGN KEY (`id_mge`) REFERENCES `mnemotecnico_generico` (`id_mge`);

--
-- Filtros para la tabla `control2_mg`
--
ALTER TABLE `control2_mg`
  ADD CONSTRAINT `control2_mg_ibfk_1` FOREIGN KEY (`id_t`) REFERENCES `control_dos` (`id_t`),
  ADD CONSTRAINT `control2_mg_ibfk_2` FOREIGN KEY (`id_mge`) REFERENCES `mnemotecnico_generico` (`id_mge`);

--
-- Filtros para la tabla `control3_mg`
--
ALTER TABLE `control3_mg`
  ADD CONSTRAINT `control3_mg_ibfk_1` FOREIGN KEY (`id_g`) REFERENCES `control_tres` (`id_g`),
  ADD CONSTRAINT `control3_mg_ibfk_2` FOREIGN KEY (`id_mge`) REFERENCES `mnemotecnico_generico` (`id_mge`);

--
-- Filtros para la tabla `control_dos`
--
ALTER TABLE `control_dos`
  ADD CONSTRAINT `control_dos_ibfk_1` FOREIGN KEY (`id_tt`) REFERENCES `type_tabla` (`id_tt`);

--
-- Filtros para la tabla `control_tres`
--
ALTER TABLE `control_tres`
  ADD CONSTRAINT `control_tres_ibfk_1` FOREIGN KEY (`id_tg`) REFERENCES `type_grafica` (`id_tg`);

--
-- Filtros para la tabla `control_uno`
--
ALTER TABLE `control_uno`
  ADD CONSTRAINT `control_uno_ibfk_1` FOREIGN KEY (`id_f`) REFERENCES `formato` (`id_f`),
  ADD CONSTRAINT `control_uno_ibfk_2` FOREIGN KEY (`id_tc`) REFERENCES `type_card` (`id_tc`);

--
-- Filtros para la tabla `elemento`
--
ALTER TABLE `elemento`
  ADD CONSTRAINT `elemento_ibfk_1` FOREIGN KEY (`id_m`) REFERENCES `modulo` (`id_m`),
  ADD CONSTRAINT `elemento_ibfk_2` FOREIGN KEY (`id_p`) REFERENCES `posicion` (`id_p`);

--
-- Filtros para la tabla `elemento_controldos`
--
ALTER TABLE `elemento_controldos`
  ADD CONSTRAINT `elemento_controldos_ibfk_1` FOREIGN KEY (`id_e`) REFERENCES `elemento` (`id_e`),
  ADD CONSTRAINT `elemento_controldos_ibfk_2` FOREIGN KEY (`id_t`) REFERENCES `control_dos` (`id_t`),
  ADD CONSTRAINT `elemento_controldos_ibfk_3` FOREIGN KEY (`id_co`) REFERENCES `conexion` (`id_co`);

--
-- Filtros para la tabla `elemento_controltres`
--
ALTER TABLE `elemento_controltres`
  ADD CONSTRAINT `elemento_controltres_ibfk_1` FOREIGN KEY (`id_e`) REFERENCES `elemento` (`id_e`),
  ADD CONSTRAINT `elemento_controltres_ibfk_2` FOREIGN KEY (`id_g`) REFERENCES `control_tres` (`id_g`),
  ADD CONSTRAINT `elemento_controltres_ibfk_3` FOREIGN KEY (`id_co`) REFERENCES `conexion` (`id_co`);

--
-- Filtros para la tabla `elemento_controluno`
--
ALTER TABLE `elemento_controluno`
  ADD CONSTRAINT `elemento_controluno_ibfk_1` FOREIGN KEY (`id_e`) REFERENCES `elemento` (`id_e`),
  ADD CONSTRAINT `elemento_controluno_ibfk_2` FOREIGN KEY (`id_c`) REFERENCES `control_uno` (`id_c`),
  ADD CONSTRAINT `elemento_controluno_ibfk_3` FOREIGN KEY (`id_co`) REFERENCES `conexion` (`id_co`);

--
-- Filtros para la tabla `elemento_mge`
--
ALTER TABLE `elemento_mge`
  ADD CONSTRAINT `elemento_mge_ibfk_1` FOREIGN KEY (`id_e`) REFERENCES `elemento` (`id_e`),
  ADD CONSTRAINT `elemento_mge_ibfk_2` FOREIGN KEY (`id_mge`) REFERENCES `mnemotecnico_generico` (`id_mge`),
  ADD CONSTRAINT `elemento_mge_ibfk_3` FOREIGN KEY (`id_co`) REFERENCES `conexion` (`id_co`);

--
-- Filtros para la tabla `mnemotecnico_generico`
--
ALTER TABLE `mnemotecnico_generico`
  ADD CONSTRAINT `mnemotecnico_generico_ibfk_1` FOREIGN KEY (`id_tca`) REFERENCES `tipo_campo` (`id_tca`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
