-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 20-06-2025 a las 21:11:33
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
  `descripcion` text DEFAULT NULL,
  `url_archivo` varchar(255) DEFAULT NULL,
  `fecha_subida` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
(2, 2, 'Impedit repudiandae facilis to', 'Fugit aliquam laborum at ab.', 1),
(3, 2, 'Quam deserunt eum.', 'Voluptate eveniet quia nisi.', 2),
(4, 2, 'Facere numquam voluptate ab re', 'Provident modi aliquid sequi ea dolores.', 3),
(5, 2, 'Repellat corrupti reprehenderi', 'Quibusdam modi repellendus. Dolore facilis possimus rerum sunt.', 4),
(6, 3, 'Libero totam impedit.', 'Exercitationem natus facilis dolores dignissimos vel. Nisi repellat magnam ut sunt eius tempora.', 1),
(7, 3, 'Occaecati quam.', 'Explicabo necessitatibus id tempore ullam. Magni aliquam eaque dolorum adipisci.', 2),
(8, 3, 'Non reiciendis.', 'Odit provident fugiat suscipit totam sit. Accusantium recusandae magni aperiam deserunt.', 3),
(9, 3, 'Hic commodi perspiciatis hic.', 'Pariatur distinctio aliquam libero illum nam nihil. Consequatur alias tenetur sint at ex numquam.', 4),
(10, 3, 'Dolor animi quas.', 'Fuga similique architecto sit suscipit.', 5),
(11, 3, 'Repudiandae asperiores recusan', 'Blanditiis beatae incidunt eaque sed repellendus quisquam. Quo mollitia quod soluta ipsa consequatur incidunt.', 6),
(12, 4, 'Debitis ad.', 'Blanditiis eligendi corporis laudantium porro ipsam pariatur officia. Adipisci maxime aperiam dolore quae voluptatum.', 1),
(13, 4, 'Debitis nobis itaque laboriosa', 'Dignissimos et unde illum itaque. Illum ex dolore.', 2),
(14, 4, 'Explicabo dolorum iusto eius q', 'Doloribus sapiente voluptas odio culpa.', 3),
(15, 5, 'Officia fugit est necessitatib', 'Suscipit maxime culpa quasi dolore.', 1),
(16, 5, 'Quia delectus enim officia.', 'Hic omnis eligendi in error tenetur.', 2),
(17, 5, 'Hic rerum libero.', 'Libero sit deserunt numquam voluptas accusantium voluptatum.', 3),
(18, 5, 'Aspernatur ducimus ea perferen', 'Aliquid hic similique consectetur.', 4),
(19, 5, 'Qui voluptas omnis nobis moles', 'Quisquam qui temporibus cumque aut libero.', 5),
(20, 6, 'Blanditiis cum voluptatem dign', 'Voluptatum accusantium tempora laboriosam aperiam mollitia saepe. Sequi atque temporibus.', 1),
(21, 6, 'Placeat perferendis.', 'Odio consequuntur quia similique eos voluptatem eum. Consequatur rem quam possimus dolorem.', 2),
(22, 6, 'Doloribus libero impedit ducim', 'Blanditiis officia laboriosam tempora dolorem distinctio.', 3);

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
  `autor_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cursos`
--

INSERT INTO `cursos` (`id`, `organizacion_id`, `titulo`, `descripcion_corta`, `tags`, `descripcion`, `fecha_inicio`, `fecha_fin`, `instructor_id`, `estado`, `imagen_url`, `duracion_horas`, `requisitos`, `certificado_disponible`, `precio`, `autor_id`) VALUES
(2, 1, 'Portal Neutral Perseverante', 'Consequatur quas ullam modi ullam distinctio sint repudiandae corporis ipsum esse.', 'recusandae, qui, sit, ratione', 'Fuga autem blanditiis beatae recusandae sint reprehenderit. Animi excepturi rerum voluptatibus amet accusamus a quidem. Reprehenderit eos inventore libero veniam.', '2025-06-30', '2025-07-18', 1, 1, 'https://placekitten.com/790/749', 30, 'Sit natus laboriosam doloribus illo cupiditate dolore fugit nemo laboriosam.', 1, 209.59, 1),
(3, 1, 'Base del Conocimiento 24/7 Avanzado', 'Qui non laboriosam rerum odio nam et quidem porro asperiores veniam.', 'repudiandae, amet, non, beatae', 'Quod dicta magni quas in. Corporis asperiores facere cumque fuga aspernatur quaerat. Nulla natus voluptatum quam error ducimus.', '2025-06-25', '2025-07-16', 1, 0, 'https://dummyimage.com/503x973', 50, 'Iure atque nostrum ratione facere doloremque fugit incidunt facilis accusantium earum sequi harum sequi.', 1, 1202.86, 1),
(4, 1, 'Base de datos basado en contenido implementado', 'Libero sunt molestias porro quisquam labore molestiae porro.', 'necessitatibus, deleniti, veritatis, accusamus', 'Molestiae ducimus dolorum voluptates corporis quia dignissimos. Ullam natus impedit ex nihil exercitationem ab fugit. Illum quam dolores magni similique.', '2025-06-21', '2025-08-07', 1, 0, 'https://placeimg.com/924/677/any', 20, 'Eligendi accusantium accusantium consectetur nihil a fuga fuga eum praesentium doloremque reprehenderit quisquam nostrum ab tempore.', 0, 994.59, 1),
(5, 1, 'Actitud Radical Descentralizado', 'Minus a voluptatibus id quia laboriosam harum voluptas.', 'earum, doloribus, incidunt, quos', 'Exercitationem ipsam similique. Eligendi eum quae laboriosam qui.', '2025-06-07', '2025-06-24', 1, 0, 'https://www.lorempixel.com/880/309', 30, 'Aperiam quo blanditiis asperiores est aspernatur harum veritatis.', 0, 289.48, 1),
(6, 1, 'Interfaz Amplio Abanico Inverso', 'Vero ab repellat reprehenderit minima blanditiis.', 'hic, delectus, voluptatem, ea', 'Soluta deleniti tempora corrupti nobis delectus. Nulla voluptatem repellat molestias. Optio fugit consequatur earum error voluptatem. Mollitia vero eius deleniti necessitatibus officiis harum.', '2025-06-16', '2025-07-04', 1, 1, 'https://placekitten.com/957/164', 20, 'Cumque iusto deserunt quibusdam dignissimos possimus enim quae vitae atque et molestiae.', 1, 311.37, 1);

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
(1, 'Maestro', 'Yoda', NULL, NULL, NULL, NULL, 'Profesor con sólida experiencia en la enseñanza y acompañamiento académico de estudiantes en distintos niveles educativos. Especializado en facilitar procesos de aprendizaje significativos, combina conocimientos teóricos con aplicaciones prácticas para mantener la atención y motivación del grupo. Se caracteriza por su empatía, habilidades de comunicación y compromiso con la formación integral del alumno. Ha participado en el diseño de programas educativos, talleres y actividades complementarias que fortalecen el desarrollo académico y personal de sus estudiantes.', NULL),
(13, 'Natan', 'Morales', NULL, NULL, NULL, NULL, NULL, NULL),
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
(8, 11, '4cf78b9335d9be872ef9725caa9b3e94fa442271dd4e128869cd1325c1c06a89', '2025-06-20 19:11:05', '2025-06-22 03:11:05', 1);

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
(1, 1, 'maestro.yoda@neitanworales.com', 'Solovino1324$', '2025-06-19 00:03:31'),
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
  ADD KEY `clase_id` (`clase_id`) USING BTREE;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

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
  ADD CONSTRAINT `archivos_ibfk_1` FOREIGN KEY (`clase_id`) REFERENCES `clase` (`id`);

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
  ADD CONSTRAINT `inscripciones_curso_ibfk_2` FOREIGN KEY (`curso_id`) REFERENCES `cursos` (`id`),
  ADD CONSTRAINT `inscripciones_curso_ibfk_3` FOREIGN KEY (`costo_id`) REFERENCES `costos_curso` (`id`);

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
