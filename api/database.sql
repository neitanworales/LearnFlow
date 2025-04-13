-- Tabla de roles
CREATE TABLE roles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

-- Tabla de personas
CREATE TABLE personas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    telefono VARCHAR(20),
    documento_identidad VARCHAR(50),
    email VARCHAR(100),
    fecha_nacimiento DATE
);

-- Tabla de usuarios
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    persona_id INT NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    contrasena VARCHAR(255) NOT NULL,
    rol_id INT NOT NULL,
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (persona_id) REFERENCES personas(id),
    FOREIGN KEY (rol_id) REFERENCES roles(id)
);

-- Tabla de organizaciones
CREATE TABLE organizaciones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    tipo VARCHAR(50),
    direccion TEXT,
    telefono VARCHAR(20),
    email VARCHAR(100),
    sitio_web VARCHAR(255),
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de cursos
CREATE TABLE cursos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    organizacion_id INT NOT NULL,
    titulo VARCHAR(100) NOT NULL,
    descripcion TEXT,
    fecha_inicio DATE,
    fecha_fin DATE,
    instructor_id INT,
    FOREIGN KEY (organizacion_id) REFERENCES organizaciones(id),
    FOREIGN KEY (instructor_id) REFERENCES usuarios(id)
);

-- Tabla de costos de curso
CREATE TABLE costos_curso (
    id INT AUTO_INCREMENT PRIMARY KEY,
    curso_id INT NOT NULL,
    tipo_pago ENUM('único', 'mensual', 'pago_por_modulo') DEFAULT 'único',
    precio DECIMAL(10,2),
    descripcion TEXT,
    FOREIGN KEY (curso_id) REFERENCES cursos(id)
);

-- Tabla de inscripciones a cursos
CREATE TABLE inscripciones_curso (
    id INT AUTO_INCREMENT PRIMARY KEY,
    persona_id INT NOT NULL,
    curso_id INT NOT NULL,
    costo_id INT NOT NULL,
    fecha_inscripcion DATETIME DEFAULT CURRENT_TIMESTAMP,
    estado ENUM('inscrito', 'aprobado', 'rechazado') DEFAULT 'inscrito',
    FOREIGN KEY (persona_id) REFERENCES personas(id),
    FOREIGN KEY (curso_id) REFERENCES cursos(id),
    FOREIGN KEY (costo_id) REFERENCES costos_curso(id)
);

-- Tabla de eventos
CREATE TABLE eventos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    organizacion_id INT NOT NULL,
    titulo VARCHAR(100) NOT NULL,
    descripcion TEXT,
    fecha_inicio DATETIME,
    fecha_fin DATETIME,
    ubicacion VARCHAR(255),
    tipo ENUM('presencial', 'virtual'),
    FOREIGN KEY (organizacion_id) REFERENCES organizaciones(id)
);

-- Tabla de paquetes de evento
CREATE TABLE paquetes_evento (
    id INT AUTO_INCREMENT PRIMARY KEY,
    evento_id INT NOT NULL,
    nombre_paquete VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10,2),
    incluye TEXT,
    FOREIGN KEY (evento_id) REFERENCES eventos(id)
);

-- Tabla de inscripciones a eventos
CREATE TABLE inscripciones_evento (
    id INT AUTO_INCREMENT PRIMARY KEY,
    persona_id INT NOT NULL,
    evento_id INT NOT NULL,
    paquete_id INT NOT NULL,
    fecha_inscripcion DATETIME DEFAULT CURRENT_TIMESTAMP,
    estado ENUM('inscrito', 'confirmado', 'cancelado') DEFAULT 'inscrito',
    FOREIGN KEY (persona_id) REFERENCES personas(id),
    FOREIGN KEY (evento_id) REFERENCES eventos(id),
    FOREIGN KEY (paquete_id) REFERENCES paquetes_evento(id)
);

-- Tabla de evaluaciones
CREATE TABLE evaluaciones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    curso_id INT NOT NULL,
    titulo VARCHAR(100),
    fecha DATE,
    FOREIGN KEY (curso_id) REFERENCES cursos(id)
);

-- Tabla de respuestas de evaluación
CREATE TABLE respuestas_evaluacion (
    id INT AUTO_INCREMENT PRIMARY KEY,
    evaluacion_id INT NOT NULL,
    persona_id INT NOT NULL,
    calificacion DECIMAL(5,2),
    comentarios TEXT,
    fecha_envio DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (evaluacion_id) REFERENCES evaluaciones(id),
    FOREIGN KEY (persona_id) REFERENCES personas(id)
);

-- Tabla de certificados
CREATE TABLE certificados (
    id INT AUTO_INCREMENT PRIMARY KEY,
    persona_id INT NOT NULL,
    curso_id INT NOT NULL,
    fecha_emision DATE,
    archivo_url VARCHAR(255),
    FOREIGN KEY (persona_id) REFERENCES personas(id),
    FOREIGN KEY (curso_id) REFERENCES cursos(id)
);

-- Tabla de archivos de curso
CREATE TABLE archivos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    curso_id INT NOT NULL,
    titulo VARCHAR(100),
    descripcion TEXT,
    url_archivo VARCHAR(255),
    fecha_subida DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (curso_id) REFERENCES cursos(id)
);

-- Tabla de foros
CREATE TABLE foros (
    id INT AUTO_INCREMENT PRIMARY KEY,
    curso_id INT NOT NULL,
    titulo VARCHAR(100),
    descripcion TEXT,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (curso_id) REFERENCES cursos(id)
);

-- Tabla de mensajes del foro
CREATE TABLE mensajes_foro (
    id INT AUTO_INCREMENT PRIMARY KEY,
    foro_id INT NOT NULL,
    persona_id INT NOT NULL,
    mensaje TEXT,
    fecha_publicacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (foro_id) REFERENCES foros(id),
    FOREIGN KEY (persona_id) REFERENCES personas(id)
);

-- Tabla de agenda personal
CREATE TABLE agenda (
    id INT AUTO_INCREMENT PRIMARY KEY,
    persona_id INT NOT NULL,
    titulo VARCHAR(100),
    descripcion TEXT,
    fecha DATETIME,
    recordatorio BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (persona_id) REFERENCES personas(id)
);

-- Tabla de pagos
CREATE TABLE pagos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    persona_id INT NOT NULL,
    curso_id INT,
    monto DECIMAL(10,2),
    fecha_pago DATETIME DEFAULT CURRENT_TIMESTAMP,
    estado ENUM('pendiente', 'pagado', 'cancelado') DEFAULT 'pendiente',
    FOREIGN KEY (persona_id) REFERENCES personas(id),
    FOREIGN KEY (curso_id) REFERENCES cursos(id)
);

-- Tabla de notificaciones
CREATE TABLE notificaciones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    persona_id INT NOT NULL,
    mensaje TEXT,
    leido BOOLEAN DEFAULT FALSE,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (persona_id) REFERENCES personas(id)
);

-- Tabla de encuestas
CREATE TABLE encuestas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    curso_id INT NOT NULL,
    pregunta TEXT,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (curso_id) REFERENCES cursos(id)
);

-- Tabla de respuestas de encuestas
CREATE TABLE respuestas_encuesta (
    id INT AUTO_INCREMENT PRIMARY KEY,
    encuesta_id INT NOT NULL,
    persona_id INT NOT NULL,
    respuesta TEXT,
    fecha_respuesta DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (encuesta_id) REFERENCES encuestas(id),
    FOREIGN KEY (persona_id) REFERENCES personas(id)
);

-- Tabla de progreso de curso
CREATE TABLE progreso (
    id INT AUTO_INCREMENT PRIMARY KEY,
    persona_id INT NOT NULL,
    curso_id INT NOT NULL,
    porcentaje DECIMAL(5,2),
    ultima_actualizacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (persona_id) REFERENCES personas(id),
    FOREIGN KEY (curso_id) REFERENCES cursos(id)
);
