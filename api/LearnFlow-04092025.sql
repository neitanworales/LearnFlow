-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 05-09-2025 a las 06:21:09
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `LearnFlow`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `agenda`
--

CREATE TABLE `agenda` (
  `id` int(11) NOT NULL,
  `persona_id` int(11) NOT NULL,
  `titulo` varchar(100) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `fecha` datetime DEFAULT NULL,
  `recordatorio` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `archivos`
--

CREATE TABLE `archivos` (
  `id` int(11) NOT NULL,
  `clase_id` int(11) NOT NULL,
  `titulo` varchar(100) DEFAULT NULL,
  `url_archivo` varchar(255) DEFAULT NULL,
  `fecha_subida` datetime DEFAULT current_timestamp(),
  `tipo` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `archivos`
--

INSERT INTO `archivos` (`id`, `clase_id`, `titulo`, `url_archivo`, `fecha_subida`, `tipo`) VALUES
(1, 2, '', 'https://www.youtube.com/embed/t9qXn0NrpZA?si=E0Qm7I0at1PJDb4c', '2025-06-20 14:14:49', 'video');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `certificados`
--

CREATE TABLE `certificados` (
  `id` int(11) NOT NULL,
  `persona_id` int(11) NOT NULL,
  `curso_id` int(11) NOT NULL,
  `fecha_emision` date DEFAULT NULL,
  `archivo_url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clase`
--

CREATE TABLE `clase` (
  `id` int(11) NOT NULL,
  `curso_id` int(11) NOT NULL,
  `titulo` varchar(30) NOT NULL,
  `descripcion` varchar(300) NOT NULL,
  `orden` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clase`
--

INSERT INTO `clase` (`id`, `curso_id`, `titulo`, `descripcion`, `orden`) VALUES
(2, 2, '10 de agosto 2025', 'Con Pastor Miguel Rivera', 1),
(3, 2, 'Quam deserunt eum.', 'Voluptate eveniet quia nisi.', 2),
(4, 2, 'Facere numquam voluptate ab re', 'Provident modi aliquid sequi ea dolores.', 3),
(5, 2, 'Repellat corrupti reprehenderi', 'Quibusdam modi repellendus. Dolore facilis possimus rerum sunt.', 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `costos_curso`
--

CREATE TABLE `costos_curso` (
  `id` int(11) NOT NULL,
  `curso_id` int(11) NOT NULL,
  `tipo_pago` enum('único','mensual','pago_por_modulo') DEFAULT 'único',
  `precio` decimal(10,2) DEFAULT NULL,
  `descripcion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cursos`
--

CREATE TABLE `cursos` (
  `id` int(11) NOT NULL,
  `organizacion_id` int(11) NOT NULL,
  `titulo` varchar(100) NOT NULL,
  `descripcion_corta` varchar(255) DEFAULT NULL,
  `tags` varchar(255) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  `instructor_id` int(11) DEFAULT NULL,
  `estado` tinyint(1) DEFAULT 1,
  `imagen_url` varchar(500) DEFAULT NULL,
  `duracion_horas` int(11) DEFAULT NULL,
  `requisitos` text DEFAULT NULL,
  `certificado_disponible` tinyint(1) DEFAULT 0,
  `precio` decimal(10,2) DEFAULT 0.00,
  `autor_id` int(11) DEFAULT NULL,
  `publico` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cursos`
--

INSERT INTO `cursos` (`id`, `organizacion_id`, `titulo`, `descripcion_corta`, `tags`, `descripcion`, `fecha_inicio`, `fecha_fin`, `instructor_id`, `estado`, `imagen_url`, `duracion_horas`, `requisitos`, `certificado_disponible`, `precio`, `autor_id`, `publico`) VALUES
(2, 1, 'Domingo en casa', 'Domingo en Casa es una colección de las predicaciones dominicales de la Iglesia Comunidad Faro Central, pensada para llevar la enseñanza bíblica a tu hogar', 'predicaciones, domingo, casa, central', '“Domingo en Casa” es una colección especial que nace del corazón de la Iglesia Comunidad Faro Central. Cada predicación compartida los domingos ahora podrá acompañarte también entre semana, en tu casa, en tu tiempo personal o junto a tu familia.\r\nLa intención es sencilla: que la Palabra de Dios no se quede solo en el lugar de reunión, sino que siga iluminando, animando y fortaleciendo tu vida allí donde estés. Queremos que cada mensaje sea un recordatorio de que somos una comunidad que camina unida, y que la fe se vive día a día, en lo cotidiano.\r\nCon “Domingo en Casa” abrimos una puerta para acercar la enseñanza bíblica de manera cercana y práctica, para que puedas volver a escuchar, reflexionar y compartir lo que Dios está hablando a tu corazón.', '2025-06-30', '2025-07-18', 0, 1, 'https://placekitten.com/790/749', 30, 'Sit natus laboriosam doloribus illo cupiditate dolore fugit nemo laboriosam.', 0, 0.00, 0, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `encuestas`
--

CREATE TABLE `encuestas` (
  `id` int(11) NOT NULL,
  `curso_id` int(11) NOT NULL,
  `pregunta` text DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evaluaciones`
--

CREATE TABLE `evaluaciones` (
  `id` int(11) NOT NULL,
  `curso_id` int(11) NOT NULL,
  `titulo` varchar(100) DEFAULT NULL,
  `fecha` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `eventos`
--

CREATE TABLE `eventos` (
  `id` int(11) NOT NULL,
  `organizacion_id` int(11) NOT NULL,
  `titulo` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `fecha_inicio` datetime DEFAULT NULL,
  `fecha_fin` datetime DEFAULT NULL,
  `ubicacion` varchar(255) DEFAULT NULL,
  `tipo` enum('presencial','virtual') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `foros`
--

CREATE TABLE `foros` (
  `id` int(11) NOT NULL,
  `curso_id` int(11) NOT NULL,
  `titulo` varchar(100) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inscripciones_curso`
--

CREATE TABLE `inscripciones_curso` (
  `id` int(11) NOT NULL,
  `persona_id` int(11) NOT NULL,
  `curso_id` int(11) NOT NULL,
  `costo_id` int(11) NOT NULL,
  `fecha_inscripcion` datetime DEFAULT current_timestamp(),
  `estado` enum('inscrito','aprobado','rechazado') DEFAULT 'inscrito'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `inscripciones_curso`
--

INSERT INTO `inscripciones_curso` (`id`, `persona_id`, `curso_id`, `costo_id`, `fecha_inscripcion`, `estado`) VALUES
(2, 13, 2, 0, '2025-07-23 13:03:02', 'inscrito');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inscripciones_evento`
--

CREATE TABLE `inscripciones_evento` (
  `id` int(11) NOT NULL,
  `persona_id` int(11) NOT NULL,
  `evento_id` int(11) NOT NULL,
  `paquete_id` int(11) NOT NULL,
  `fecha_inscripcion` datetime DEFAULT current_timestamp(),
  `estado` enum('inscrito','confirmado','cancelado') DEFAULT 'inscrito'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mensajes_foro`
--

CREATE TABLE `mensajes_foro` (
  `id` int(11) NOT NULL,
  `foro_id` int(11) NOT NULL,
  `persona_id` int(11) NOT NULL,
  `mensaje` text DEFAULT NULL,
  `fecha_publicacion` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notificaciones`
--

CREATE TABLE `notificaciones` (
  `id` int(11) NOT NULL,
  `persona_id` int(11) NOT NULL,
  `mensaje` text DEFAULT NULL,
  `leido` tinyint(1) DEFAULT 0,
  `fecha_creacion` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `organizaciones`
--

CREATE TABLE `organizaciones` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `tipo` varchar(50) DEFAULT NULL,
  `direccion` text DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `sitio_web` varchar(255) DEFAULT NULL,
  `fecha_registro` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `organizaciones`
--

INSERT INTO `organizaciones` (`id`, `nombre`, `descripcion`, `tipo`, `direccion`, `telefono`, `email`, `sitio_web`, `fecha_registro`) VALUES
(1, 'FARO Central', NULL, NULL, NULL, NULL, NULL, NULL, '2025-06-19 00:02:23');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pagos`
--

CREATE TABLE `pagos` (
  `id` int(11) NOT NULL,
  `persona_id` int(11) NOT NULL,
  `curso_id` int(11) DEFAULT NULL,
  `monto` decimal(10,2) DEFAULT NULL,
  `fecha_pago` datetime DEFAULT current_timestamp(),
  `estado` enum('pendiente','pagado','cancelado') DEFAULT 'pendiente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `paquetes_evento`
--

CREATE TABLE `paquetes_evento` (
  `id` int(11) NOT NULL,
  `evento_id` int(11) NOT NULL,
  `nombre_paquete` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  `incluye` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personas`
--

CREATE TABLE `personas` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `documento_identidad` varchar(50) DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `genero` varchar(20) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `foto_url` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `personas`
--

INSERT INTO `personas` (`id`, `nombre`, `apellido`, `telefono`, `documento_identidad`, `fecha_nacimiento`, `genero`, `descripcion`, `foto_url`) VALUES
(0, 'FARO', 'Central', NULL, NULL, NULL, NULL, 'https://drive.google.com/file/d/1fsWvsXyRP9Z4SrUsWOb9V5jyNdqZG3Qt/view?usp=share_link\r\n\r\nhttps://drive.google.com/uc?export=view&id=1fsWvsXyRP9Z4SrUsWOb9V5jyNdqZG3Qt&export=view&authuser=0\r\n\r\nhttps://drive.google.com/file/d/1fsWvsXyRP9Z4SrUsWOb9V5jyNdqZG3Qt/view?usp=share_link', 'https://drive.google.com/thumbnail?id=id=1fsWvsXyRP9Z4SrUsWOb9V5jyNdqZG3Qt'),
(1, 'Miguel', 'Rivera', NULL, NULL, NULL, 'M', 'Pastor de Comunidad FARO', NULL),
(2, 'Fernanda', 'Bajata', NULL, NULL, NULL, 'F', NULL, NULL),
(3, 'Aidé ', 'Gonzales', NULL, NULL, NULL, 'F', NULL, NULL),
(4, 'Antonio', 'Garcia', NULL, NULL, NULL, 'M', NULL, NULL),
(5, 'Abraham', 'Mendoza', NULL, NULL, NULL, 'M', NULL, NULL),
(13, 'Natan', 'Morales', NULL, NULL, NULL, 'M', NULL, NULL),
(14, 'Admin', 'Testing', NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `progreso`
--

CREATE TABLE `progreso` (
  `id` int(11) NOT NULL,
  `persona_id` int(11) NOT NULL,
  `curso_id` int(11) NOT NULL,
  `porcentaje` decimal(5,2) DEFAULT NULL,
  `ultima_actualizacion` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `respuestas_encuesta`
--

CREATE TABLE `respuestas_encuesta` (
  `id` int(11) NOT NULL,
  `encuesta_id` int(11) NOT NULL,
  `persona_id` int(11) NOT NULL,
  `respuesta` text DEFAULT NULL,
  `fecha_respuesta` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `respuestas_evaluacion`
--

CREATE TABLE `respuestas_evaluacion` (
  `id` int(11) NOT NULL,
  `evaluacion_id` int(11) NOT NULL,
  `persona_id` int(11) NOT NULL,
  `calificacion` decimal(5,2) DEFAULT NULL,
  `comentarios` text DEFAULT NULL,
  `fecha_envio` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id`, `nombre`) VALUES
(1, 'usuario'),
(2, 'maestro'),
(3, 'alumno'),
(4, 'libre'),
(111, 'super'),
(777, 'admin');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_archivo`
--

CREATE TABLE `tipo_archivo` (
  `tipo` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipo_archivo`
--

INSERT INTO `tipo_archivo` (`tipo`) VALUES
('audio'),
('pdf'),
('video');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user_role`
--

CREATE TABLE `user_role` (
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `user_role`
--

INSERT INTO `user_role` (`user_id`, `role_id`) VALUES
(1, 2),
(11, 111),
(12, 777);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user_token`
--

CREATE TABLE `user_token` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `expires_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `user_token`
--

INSERT INTO `user_token` (`id`, `user_id`, `token`, `created_at`, `expires_at`, `is_active`) VALUES
(8, 11, '4cf78b9335d9be872ef9725caa9b3e94fa442271dd4e128869cd1325c1c06a89', '2025-06-20 19:11:05', '2025-06-22 03:11:05', 1),
(9, 11, '45cab6040797503e8378bf09d3f9b4ec7ff7b5d2602c4ed8232842317ff66233', '2025-06-26 00:47:47', '2025-06-27 08:47:47', 1),
(10, 11, 'f846266ca8e6359933efda08fcdc5c4b4699c939edb77334d2003d269114d3cd', '2025-06-26 00:49:34', '2025-06-27 08:49:34', 1),
(11, 11, '392f873f6d0ba266274715b76657737b364aa4e37c3124ba1c34e173d8b6ad06', '2025-06-26 01:00:49', '2025-06-27 09:00:49', 1),
(12, 11, 'cebacdc52b933dfa64e1d50fece68c816a619ba36a2b3b9c2d126e9adb23702c', '2025-06-26 01:14:25', '2025-06-27 09:14:25', 1),
(13, 11, 'ef04fca461f23b518392675b58f9c6805d468b275b45fdefced772e08c03dd95', '2025-07-23 15:01:15', '2025-07-24 23:01:15', 1),
(14, 11, 'afcefaf4a83c1900d5c2f3f59b4589afdc88fdb41e7d931176b841e03371a5c3', '2025-07-23 15:40:20', '2025-07-24 23:40:20', 1),
(15, 11, '8c41e4fb73d6dcb9d83f3a7f30b43842857f36d586b67f070b064330dd26f618', '2025-07-23 18:54:47', '2025-07-25 02:54:47', 1),
(16, 11, '53d9296daa6f0dd97e3a11040fde250b483dee4fed1c7d3ac3ad36c313571ef6', '2025-07-23 19:00:30', '2025-07-25 03:00:30', 1),
(17, 11, 'f1b7db423023e10558ee7effe23bc55e877d1a508eb9e612f36fa6db34f36216', '2025-07-23 19:02:43', '2025-07-25 03:02:43', 1),
(18, 11, 'cbddc6ee8c03b3784201e3a49c2a20fdb0e7bb97be6a12ac35e10286877c94d7', '2025-07-23 19:06:30', '2025-07-25 03:06:30', 1),
(19, 11, '8eb5c2f559d52267927e6dd56ccb9cf6fd3b6c5292ada94a3a6ecb8f8416a770', '2025-07-23 19:11:47', '2025-07-25 03:11:47', 1),
(20, 11, '054b5ad63ffa12e64d7448301eeaefcc177140cb18897e32d82c42baf162679f', '2025-07-23 19:13:14', '2025-07-25 03:13:14', 1),
(21, 11, 'ff675e2cbd7b0d09a3da6ed7a8dfc1c6303664eb1803265c7478802c60a8ba15', '2025-07-23 19:14:46', '2025-07-25 03:14:46', 1),
(22, 11, '52fdc587a1b64157b8a5c63b7ba93f6ef91dfc259b4d18c96ae25b216c3cb1a3', '2025-07-23 19:21:05', '2025-07-25 03:21:05', 1),
(23, 11, 'a9feecb1c688cc0dffece421188c8758c9f9c2681479dea13221e34f2d75c298', '2025-07-23 19:26:37', '2025-07-25 03:26:37', 1),
(24, 11, 'e415713af6163ebc126c457260c015c2a3666a3eeb86cb671f5dc5a4553c1e34', '2025-07-24 00:15:46', '2025-07-25 08:15:46', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `persona_id` int(11) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `fecha_registro` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `persona_id`, `email`, `contrasena`, `fecha_registro`) VALUES
(0, 0, 'creativos.comunidadfaro@gmail.com', 'creativos1324$', '2025-08-27 10:21:23'),
(1, 1, 'miguel.rivera@learnflow.com', 'Pastor1324$', '2025-06-19 00:03:31'),
(2, 2, 'fernanda.bajata@learnflow.com', 'Fernanda1324$', '2025-08-27 10:18:27'),
(3, 3, 'aide@learnflow.com', 'aide1324$', '2025-08-27 10:19:00'),
(4, 4, 'antonio.rockstar@learnflow.com', 'rockstar1324$', '2025-08-27 10:19:39'),
(5, 5, 'abraham@learnflow.com', 'abraham1324$', '2025-08-27 10:20:07'),
(11, 13, 'neitan.morales@gmail.com', 'NoMeCompares1324$', '2025-05-28 23:42:38'),
(12, 14, 'admintesting@neitan.com', 'Solovino1324$', '2025-05-28 23:47:40');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `agenda`
--
ALTER TABLE `agenda`
  ADD PRIMARY KEY (`id`),
  ADD KEY `persona_id` (`persona_id`);

--
-- Indices de la tabla `archivos`
--
ALTER TABLE `archivos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `clase_id` (`clase_id`) USING BTREE,
  ADD KEY `tipo_archivo` (`tipo`);

--
-- Indices de la tabla `certificados`
--
ALTER TABLE `certificados`
  ADD PRIMARY KEY (`id`),
  ADD KEY `persona_id` (`persona_id`),
  ADD KEY `curso_id` (`curso_id`);

--
-- Indices de la tabla `clase`
--
ALTER TABLE `clase`
  ADD PRIMARY KEY (`id`),
  ADD KEY `curso_clase` (`curso_id`);

--
-- Indices de la tabla `costos_curso`
--
ALTER TABLE `costos_curso`
  ADD PRIMARY KEY (`id`),
  ADD KEY `curso_id` (`curso_id`);

--
-- Indices de la tabla `cursos`
--
ALTER TABLE `cursos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `organizacion_id` (`organizacion_id`),
  ADD KEY `instructor_id` (`instructor_id`),
  ADD KEY `autor_id` (`autor_id`);

--
-- Indices de la tabla `encuestas`
--
ALTER TABLE `encuestas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `curso_id` (`curso_id`);

--
-- Indices de la tabla `evaluaciones`
--
ALTER TABLE `evaluaciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `curso_id` (`curso_id`);

--
-- Indices de la tabla `eventos`
--
ALTER TABLE `eventos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `organizacion_id` (`organizacion_id`);

--
-- Indices de la tabla `foros`
--
ALTER TABLE `foros`
  ADD PRIMARY KEY (`id`),
  ADD KEY `curso_id` (`curso_id`);

--
-- Indices de la tabla `inscripciones_curso`
--
ALTER TABLE `inscripciones_curso`
  ADD PRIMARY KEY (`id`),
  ADD KEY `persona_id` (`persona_id`),
  ADD KEY `curso_id` (`curso_id`),
  ADD KEY `costo_id` (`costo_id`);

--
-- Indices de la tabla `inscripciones_evento`
--
ALTER TABLE `inscripciones_evento`
  ADD PRIMARY KEY (`id`),
  ADD KEY `persona_id` (`persona_id`),
  ADD KEY `evento_id` (`evento_id`),
  ADD KEY `paquete_id` (`paquete_id`);

--
-- Indices de la tabla `mensajes_foro`
--
ALTER TABLE `mensajes_foro`
  ADD PRIMARY KEY (`id`),
  ADD KEY `foro_id` (`foro_id`),
  ADD KEY `persona_id` (`persona_id`);

--
-- Indices de la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `persona_id` (`persona_id`);

--
-- Indices de la tabla `organizaciones`
--
ALTER TABLE `organizaciones`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `pagos`
--
ALTER TABLE `pagos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `persona_id` (`persona_id`),
  ADD KEY `curso_id` (`curso_id`);

--
-- Indices de la tabla `paquetes_evento`
--
ALTER TABLE `paquetes_evento`
  ADD PRIMARY KEY (`id`),
  ADD KEY `evento_id` (`evento_id`);

--
-- Indices de la tabla `personas`
--
ALTER TABLE `personas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `progreso`
--
ALTER TABLE `progreso`
  ADD PRIMARY KEY (`id`),
  ADD KEY `persona_id` (`persona_id`),
  ADD KEY `curso_id` (`curso_id`);

--
-- Indices de la tabla `respuestas_encuesta`
--
ALTER TABLE `respuestas_encuesta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `encuesta_id` (`encuesta_id`),
  ADD KEY `persona_id` (`persona_id`);

--
-- Indices de la tabla `respuestas_evaluacion`
--
ALTER TABLE `respuestas_evaluacion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `evaluacion_id` (`evaluacion_id`),
  ADD KEY `persona_id` (`persona_id`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tipo_archivo`
--
ALTER TABLE `tipo_archivo`
  ADD PRIMARY KEY (`tipo`);

--
-- Indices de la tabla `user_role`
--
ALTER TABLE `user_role`
  ADD PRIMARY KEY (`user_id`,`role_id`),
  ADD KEY `role_id` (`role_id`);

--
-- Indices de la tabla `user_token`
--
ALTER TABLE `user_token`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `token` (`token`),
  ADD KEY `user_id` (`user_id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `persona_id` (`persona_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `agenda`
--
ALTER TABLE `agenda`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `archivos`
--
ALTER TABLE `archivos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `certificados`
--
ALTER TABLE `certificados`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `clase`
--
ALTER TABLE `clase`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `costos_curso`
--
ALTER TABLE `costos_curso`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cursos`
--
ALTER TABLE `cursos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `encuestas`
--
ALTER TABLE `encuestas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `evaluaciones`
--
ALTER TABLE `evaluaciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `eventos`
--
ALTER TABLE `eventos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `foros`
--
ALTER TABLE `foros`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `inscripciones_curso`
--
ALTER TABLE `inscripciones_curso`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `inscripciones_evento`
--
ALTER TABLE `inscripciones_evento`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `mensajes_foro`
--
ALTER TABLE `mensajes_foro`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `organizaciones`
--
ALTER TABLE `organizaciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `pagos`
--
ALTER TABLE `pagos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `paquetes_evento`
--
ALTER TABLE `paquetes_evento`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `personas`
--
ALTER TABLE `personas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `progreso`
--
ALTER TABLE `progreso`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `respuestas_encuesta`
--
ALTER TABLE `respuestas_encuesta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `respuestas_evaluacion`
--
ALTER TABLE `respuestas_evaluacion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=778;

--
-- AUTO_INCREMENT de la tabla `user_token`
--
ALTER TABLE `user_token`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `agenda`
--
ALTER TABLE `agenda`
  ADD CONSTRAINT `agenda_ibfk_1` FOREIGN KEY (`persona_id`) REFERENCES `personas` (`id`);

--
-- Filtros para la tabla `archivos`
--
ALTER TABLE `archivos`
  ADD CONSTRAINT `archivos_ibfk_1` FOREIGN KEY (`clase_id`) REFERENCES `clase` (`id`),
  ADD CONSTRAINT `tipo_archivo` FOREIGN KEY (`tipo`) REFERENCES `tipo_archivo` (`tipo`);

--
-- Filtros para la tabla `certificados`
--
ALTER TABLE `certificados`
  ADD CONSTRAINT `certificados_ibfk_1` FOREIGN KEY (`persona_id`) REFERENCES `personas` (`id`),
  ADD CONSTRAINT `certificados_ibfk_2` FOREIGN KEY (`curso_id`) REFERENCES `cursos` (`id`);

--
-- Filtros para la tabla `clase`
--
ALTER TABLE `clase`
  ADD CONSTRAINT `curso_clase` FOREIGN KEY (`curso_id`) REFERENCES `cursos` (`id`);

--
-- Filtros para la tabla `costos_curso`
--
ALTER TABLE `costos_curso`
  ADD CONSTRAINT `costos_curso_ibfk_1` FOREIGN KEY (`curso_id`) REFERENCES `cursos` (`id`);

--
-- Filtros para la tabla `cursos`
--
ALTER TABLE `cursos`
  ADD CONSTRAINT `cursos_ibfk_1` FOREIGN KEY (`organizacion_id`) REFERENCES `organizaciones` (`id`),
  ADD CONSTRAINT `cursos_ibfk_2` FOREIGN KEY (`instructor_id`) REFERENCES `usuarios` (`id`),
  ADD CONSTRAINT `cursos_ibfk_3` FOREIGN KEY (`autor_id`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `encuestas`
--
ALTER TABLE `encuestas`
  ADD CONSTRAINT `encuestas_ibfk_1` FOREIGN KEY (`curso_id`) REFERENCES `cursos` (`id`);

--
-- Filtros para la tabla `evaluaciones`
--
ALTER TABLE `evaluaciones`
  ADD CONSTRAINT `evaluaciones_ibfk_1` FOREIGN KEY (`curso_id`) REFERENCES `cursos` (`id`);

--
-- Filtros para la tabla `eventos`
--
ALTER TABLE `eventos`
  ADD CONSTRAINT `eventos_ibfk_1` FOREIGN KEY (`organizacion_id`) REFERENCES `organizaciones` (`id`);

--
-- Filtros para la tabla `foros`
--
ALTER TABLE `foros`
  ADD CONSTRAINT `foros_ibfk_1` FOREIGN KEY (`curso_id`) REFERENCES `cursos` (`id`);

--
-- Filtros para la tabla `inscripciones_curso`
--
ALTER TABLE `inscripciones_curso`
  ADD CONSTRAINT `inscripciones_curso_ibfk_1` FOREIGN KEY (`persona_id`) REFERENCES `personas` (`id`),
  ADD CONSTRAINT `inscripciones_curso_ibfk_2` FOREIGN KEY (`curso_id`) REFERENCES `cursos` (`id`);

--
-- Filtros para la tabla `inscripciones_evento`
--
ALTER TABLE `inscripciones_evento`
  ADD CONSTRAINT `inscripciones_evento_ibfk_1` FOREIGN KEY (`persona_id`) REFERENCES `personas` (`id`),
  ADD CONSTRAINT `inscripciones_evento_ibfk_2` FOREIGN KEY (`evento_id`) REFERENCES `eventos` (`id`),
  ADD CONSTRAINT `inscripciones_evento_ibfk_3` FOREIGN KEY (`paquete_id`) REFERENCES `paquetes_evento` (`id`);

--
-- Filtros para la tabla `mensajes_foro`
--
ALTER TABLE `mensajes_foro`
  ADD CONSTRAINT `mensajes_foro_ibfk_1` FOREIGN KEY (`foro_id`) REFERENCES `foros` (`id`),
  ADD CONSTRAINT `mensajes_foro_ibfk_2` FOREIGN KEY (`persona_id`) REFERENCES `personas` (`id`);

--
-- Filtros para la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  ADD CONSTRAINT `notificaciones_ibfk_1` FOREIGN KEY (`persona_id`) REFERENCES `personas` (`id`);

--
-- Filtros para la tabla `pagos`
--
ALTER TABLE `pagos`
  ADD CONSTRAINT `pagos_ibfk_1` FOREIGN KEY (`persona_id`) REFERENCES `personas` (`id`),
  ADD CONSTRAINT `pagos_ibfk_2` FOREIGN KEY (`curso_id`) REFERENCES `cursos` (`id`);

--
-- Filtros para la tabla `paquetes_evento`
--
ALTER TABLE `paquetes_evento`
  ADD CONSTRAINT `paquetes_evento_ibfk_1` FOREIGN KEY (`evento_id`) REFERENCES `eventos` (`id`);

--
-- Filtros para la tabla `progreso`
--
ALTER TABLE `progreso`
  ADD CONSTRAINT `progreso_ibfk_1` FOREIGN KEY (`persona_id`) REFERENCES `personas` (`id`),
  ADD CONSTRAINT `progreso_ibfk_2` FOREIGN KEY (`curso_id`) REFERENCES `cursos` (`id`);

--
-- Filtros para la tabla `respuestas_encuesta`
--
ALTER TABLE `respuestas_encuesta`
  ADD CONSTRAINT `respuestas_encuesta_ibfk_1` FOREIGN KEY (`encuesta_id`) REFERENCES `encuestas` (`id`),
  ADD CONSTRAINT `respuestas_encuesta_ibfk_2` FOREIGN KEY (`persona_id`) REFERENCES `personas` (`id`);

--
-- Filtros para la tabla `respuestas_evaluacion`
--
ALTER TABLE `respuestas_evaluacion`
  ADD CONSTRAINT `respuestas_evaluacion_ibfk_1` FOREIGN KEY (`evaluacion_id`) REFERENCES `evaluaciones` (`id`),
  ADD CONSTRAINT `respuestas_evaluacion_ibfk_2` FOREIGN KEY (`persona_id`) REFERENCES `personas` (`id`);

--
-- Filtros para la tabla `user_role`
--
ALTER TABLE `user_role`
  ADD CONSTRAINT `user_role_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_role_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `user_token`
--
ALTER TABLE `user_token`
  ADD CONSTRAINT `user_token_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`persona_id`) REFERENCES `personas` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
