CREATE DATABASE crmYonda;

USE crmYonda;

CREATE TABLE ROLES(

	id_rol		INT AUTO_INCREMENT PRIMARY KEY,
    rol			ENUM ('Jefe de Marketing','Asesor')

) ENGINE = INNODB;

INSERT INTO ROLES (rol) VALUES('Jefe de Marketing'),('Asesor');
SELECT * FROM ROLES;

CREATE TABLE ESTADOS(
	
    id_estado	INT AUTO_INCREMENT PRIMARY KEY,
    indice		INT UNIQUE,
    estado		ENUM('leads','MQL','SQL') 		NOT NULL
    
)ENGINE = INNODB;

INSERT INTO ESTADOS (indice,estado)VALUES
					(1,'leads'),
					(2,'MQL'),
					(3,'SQL');
SELECT * FROM ESTADOS;

CREATE TABLE origenes(

	id_origen	INT AUTO_INCREMENT PRIMARY KEY,
    origen		VARCHAR(30) UNIQUE

)ENGINE = INNODB;


INSERT INTO origenes(origen)values
('Instagram'),
('Facebook'),
('TikTok'),
('Yonda'),
('Fix360');
SELECT * FROM origenes;


CREATE TABLE personas(
	
	id_persona		INT AUTO_INCREMENT PRIMARY KEY,
    apellido_pat	VARCHAR(30),
    apellido_mat	VARCHAR(30),
    nombres			VARCHAR(30),
    tipodoc			ENUM('DNI','Carnet de extranjería'),
    numdoc			VARCHAR(12) UNIQUE,
    fechanac		DATE,
    telefono		VARCHAR(16),
    email			VARCHAR(255),
    id_origen		INT NULL,
    
    FOREIGN KEY (id_origen) REFERENCES origenes(id_origen)
    
)ENGINE = INNODB;


INSERT INTO personas (apellido_pat,apellido_mat,nombres,tipodoc,numdoc,fechanac,telefono,email,id_origen)values
('Pérez', 'González', 'Juan Carlos', 'DNI', '12345678', '1985-06-15', '987654321', 'juan.perez@example.com', NULL),
('Sánchez', 'Morales', 'Ana María', 'Carnet de extranjería', 'A1234567', '1990-09-10', '945678123', 'ana.sanchez@example.com', NULL),
('López', 'Ramírez', 'Carlos Alberto', 'DNI', '87654321', '1995-12-01', '912345678', 'carlos.lopez@example.com', NULL),

('Gómez', 'Martínez', 'Luisa Fernanda', 'Carnet de extranjería', 'B2345678', '1982-03-25', '965432109', 'luisa.gomez@example.com', 3),
('Martínez', 'Suárez', 'Ricardo', 'DNI', '23456789', '1992-11-20', '930123456', 'ricardo.martinez@example.com', 1),
('Vásquez', 'Luna', 'Elena', 'Carnet de extranjería', 'C3456789', '1988-04-12', '928765432', 'elena.vasquez@example.com', 1),

('Pipa', 'Castilla', 'Kelvin', 'DNI', '74747474', '2005-08-29', '955959955', 'kelvin@gmail.com', NULL);

INSERT INTO personas (apellido_pat,apellido_mat,nombres,tipodoc,numdoc,fechanac,telefono,email,id_origen)values
('Fernández', 'Torres', 'Marta Beatriz', 'DNI', '134345678', '1990-05-12', '982345678', 'marta.fernandez@example.com', 1),
('Castillo', 'Ríos', 'José Luis', 'Carnet de extranjería', 'C9876543', '1985-02-20', '961234567', 'jose.castillo@example.com', 2);
SELECT * FROM personas;





CREATE TABLE contratos(

	id_contrato		INT AUTO_INCREMENT PRIMARY KEY,
    id_persona		INT,
    fechainicio		DATE,
    fechafin		DATE,
    id_rol			INT,
    FOREIGN KEY (id_rol) REFERENCES ROLES(id_rol),
	FOREIGN KEY (id_persona) REFERENCES personas(id_persona)

)ENGINE = INNODB;

INSERT INTO contratos (id_persona, fechainicio, fechafin, id_rol)
VALUES
(1, '2025-01-01', '2025-06-28', 2),
(2, '2025-01-15', '2025-06-14', 2),
(3, '2025-02-01', '2025-06-25', 2),
(7, '2025-02-01', '2025-12-15', 1);

SELECT * FROM contratos;




CREATE TABLE usuarios(

	id_usuario		INT AUTO_INCREMENT PRIMARY KEY,
    id_contrato		INT,
    nomuser			VARCHAR(30) UNIQUE,
    passuser		VARCHAR(255),
    
    FOREIGN KEY (id_contrato) REFERENCES contratos(id_contrato)

)ENGINE = INNODB;

INSERT INTO usuarios(id_contrato,nomuser,passuser)VALUES
(1,'Juan','9IJN0OKM'),
(2,'Ana','8UHB7YGV'),
(3,'Carlos','6TFC5RDX'),
(4,'Kelvin','4ESZ3WA<');

SELECT * FROM usuarios;

CREATE TABLE asignaciones(
	id_asignaciones		INT AUTO_INCREMENT PRIMARY KEY,
    id_usuarioasigna	INT,
	id_usuarioasesor	INT,
    
	FOREIGN KEY (id_usuarioasigna) REFERENCES usuarios(id_usuario), -- NOMBRE DEL LA PERSONA QUE ASIGNO
	FOREIGN KEY (id_usuarioasesor) REFERENCES usuarios(id_usuario) -- NOMBRE DEL ASCESOR
)ENGINE =INNODB;





INSERT INTO asignaciones(id_usuarioasigna,id_usuarioasesor)
VALUES
(4,1),
(4,2),
(4,3);
SELECT * FROM asignaciones;

SELECT *
FROM asignaciones
INNER JOIN usuarios AS ua ON asignaciones.id_usuarioasigna = ua.id_usuario
INNER JOIN usuarios AS us ON asignaciones.id_usuarioasesor = us.id_usuario;


CREATE TABLE carga(

	id_carga	INT AUTO_INCREMENT PRIMARY KEY,
    id_asignaciones	INT,
    id_persona	INT,
    
	FOREIGN KEY (id_asignaciones) REFERENCES asignaciones(id_asignaciones),
	FOREIGN KEY (id_persona) REFERENCES personas(id_persona)
    
)ENGINE = INNODB;


INSERT INTO carga(id_asignaciones,id_persona)
VALUES
(1,4),
(2,5),
(3,6),
(3,8),
(2,9);
SELECT * FROM carga;

SELECT * 
FROM carga
INNER JOIN personas
ON carga.id_persona =personas.id_persona
INNER JOIN asignaciones
ON carga.id_asignaciones = asignaciones.id_asignaciones;





CREATE TABLE seguimiento(

	id_seguimiento	INT AUTO_INCREMENT PRIMARY KEY,
    fechainicio		DATE,
    fechafin		DATE,
    id_estado		INT,
    id_carga		INT,
	FOREIGN KEY (id_estado) REFERENCES estados(id_estado),
	FOREIGN KEY (id_carga) REFERENCES carga(id_carga)
)ENGINE = INNODB;

SELECT fechainicio,fechafin,estado
FROM seguimiento
INNER JOIN estados ON estados.id_estado = seguimiento.id_estado
INNER JOIN carga ON carga.id_carga = seguimiento.id_carga;


INSERT INTO seguimiento(fechainicio,fechafin,id_estado,id_carga)
VALUES
('2025-01-10','2025-03-24',1,1),
('2025-02-14','2025-02-21',1,2),
('2025-02-22','2025-02-23',2,2),
('2025-02-25','2025-02-27',2,1),
('2025-02-24',NULL,3,2),
('2025-02-28',NULL,3,1),
('2025-03-17','2025-03-22',1,5),
('2025-03-20',NULL,1,3),
('2025-03-23',NULL,2,5);



SELECT * FROM seguimiento;
