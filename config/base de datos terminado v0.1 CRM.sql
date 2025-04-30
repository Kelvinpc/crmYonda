CREATE DATABASE crmYonda;

--
USE crmYonda;

CREATE TABLE roles(

	idrol		            INT AUTO_INCREMENT PRIMARY KEY,
    rol			            VARCHAR(30)
    fechacreacion           DATETIME DEFAULT NOW(),
    fechamodificado         DATETIME NULL
) ENGINE = INNODB;

INSERT INTO roles (rol) VALUES('Jefe de Marketing'),('Asesor');
SELECT * FROM roles;

CREATE TABLE estados(
	
    idestado	            INT AUTO_INCREMENT PRIMARY KEY,
    indice		            INT,
    estado		            VARCHAR(30)NOT NULL
    fechacreacion           DATETIME DEFAULT NOW(),
    fechamodificado         DATETIME NULL

    CONSTRAINT uk_indice_estados UNIQUE (indice)
    
)ENGINE = INNODB;

INSERT INTO estados (indice,estado)VALUES
					(1,'leads'),
					(2,'MQL'),
					(3,'SQL');
SELECT * FROM estados;

CREATE TABLE origenes(

	idorigen	            INT AUTO_INCREMENT PRIMARY KEY,
    origen		            VARCHAR(30),
    
    fechacreacion           DATETIME DEFAULT NOW(),
    fechamodificado         DATETIME NULL

    CONSTRAINT uk_origen_origenes UNIQUE (origen)

)ENGINE = INNODB;


INSERT INTO origenes(origen)values
('Instagram'),
('Facebook'),
('TikTok'),
('Yonda'),
('Fix360');
SELECT * FROM origenes;


CREATE TABLE personas(
	
	idpersona		        INT AUTO_INCREMENT PRIMARY KEY,
    apellidos               VARCHAR(50),
    nombres			        VARCHAR(30),
    tipodoc			        ENUM('DNI','CEX','PASS') COMMENT 'CEX = Carnet de EXtrangeria ; PASS=Pasaporte',
    numdoc			        VARCHAR(12),
    fechanac		        DATE,
    telefono		        VARCHAR(12),
    email			        VARCHAR(255),
    idorigen		        INT NULL,
    
    fechacreacion           DATETIME DEFAULT NOW(),
    fechamodificado         DATETIME NULL

    
    CONSTRAINT fk_idorigen_origenes FOREIGN KEY (idorigen) REFERENCES origenes(idorigen)
    
)ENGINE = INNODB;


INSERT INTO personas (apellidos,nombres,tipodoc,numdoc,fechanac,telefono,email,idorigen)values
('Pérez González', 'Juan Carlos', 'DNI', '12345678', '1985-06-15', '987654321', 'juan.perez@example.com', NULL),
('Sánchez Morales', 'Ana María', 'Carnet de extranjería', 'A1234567', '1990-09-10', '945678123', 'ana.sanchez@example.com', NULL),
('López Ramírez', 'Carlos Alberto', 'DNI', '87654321', '1995-12-01', '912345678', 'carlos.lopez@example.com', NULL),

('Gómez Martínez', 'Luisa Fernanda', 'Carnet de extranjería', 'B2345678', '1982-03-25', '965432109', 'luisa.gomez@example.com', 3),
('Martínez Suárez', 'Ricardo', 'DNI', '23456789', '1992-11-20', '930123456', 'ricardo.martinez@example.com', 1),
('Vásquez Luna', 'Elena', 'Carnet de extranjería', 'C3456789', '1988-04-12', '928765432', 'elena.vasquez@example.com', 1),

('Pipa Castilla', 'Kelvin', 'DNI', '74747474', '2005-08-29', '955959955', 'kelvin@gmail.com', NULL);

INSERT INTO personas (apellidos,nombres,tipodoc,numdoc,fechanac,telefono,email,idorigen)values
('Fernández Torres', 'Marta Beatriz', 'DNI', '134345678', '1990-05-12', '982345678', 'marta.fernandez@example.com', 1),
('Castillo Ríos', 'José Luis', 'Carnet de extranjería', 'C9876543', '1985-02-20', '961234567', 'jose.castillo@example.com', 2);
SELECT * FROM personas;





CREATE TABLE contratos(

	idcontrato		        INT AUTO_INCREMENT PRIMARY KEY,
    idpersona		        INT,
    fechainicio		        DATETIME,
    fechafin		        DATETIME,
    idrol			        INT,

    fechacreacion           DATETIME DEFAULT NOW(),
    fechamodificado         DATETIME NULL

    CONSTRAINT fk_idrol_roles FOREIGN KEY (idrol) REFERENCES roles(idrol),
	CONSTRAINT fk_idpersona_personas FOREIGN KEY (idpersona) REFERENCES personas(idpersona)
    

)ENGINE = INNODB;

INSERT INTO contratos (idpersona, fechainicio, fechafin, idrol)
VALUES
(1, '2025-01-01', '2025-06-28', 2),
(2, '2025-01-15', '2025-06-14', 2),
(3, '2025-02-01', '2025-06-25', 2),
(7, '2025-02-01', '2025-12-15', 1);

SELECT * FROM contratos;




CREATE TABLE usuarios(

	id_usuario		        INT AUTO_INCREMENT PRIMARY KEY,
    id_contrato		        INT,
    nomuser			        VARCHAR(30) UNIQUE,
    passuser		        VARCHAR(255),

    fechacreacion           DATETIME DEFAULT NOW(),
    fechamodificado         DATETIME NULL

    
    CONSTRAINT fk_idcontrato_usuarios FOREIGN KEY (id_contrato) REFERENCES contratos(id_contrato)

)ENGINE = INNODB;

INSERT INTO usuarios(idcontrato,nomuser,passuser)VALUES
(1,'Juan','9IJN0OKM'),
(2,'Ana','8UHB7YGV'),
(3,'Carlos','6TFC5RDX'),
(4,'Kelvin','4ESZ3WA<');

SELECT * FROM usuarios;

CREATE TABLE asignaciones(
	idasignaciones		    INT AUTO_INCREMENT PRIMARY KEY,
    idusuarioasigna	        INT,
	idusuarioasesor	        INT,

    fechacreacion           DATETIME DEFAULT NOW(),
    fechamodificado         DATETIME NULL

    
	CONSTRAINT fk_idusuarioasigna_usuarios FOREIGN KEY (idusuarioasigna) REFERENCES usuarios(idusuario), -- NOMBRE DEL LA PERSONA QUE ASIGNO
	CONSTRAINT fk_idusuarioasesor_usuarios FOREIGN KEY (idusuarioasesor) REFERENCES usuarios(idusuario) -- NOMBRE DEL ASCESOR
)ENGINE =INNODB;





INSERT INTO asignaciones(idusuarioasigna,idusuarioasesor)
VALUES
(4,1),
(4,2),
(4,3);
SELECT * FROM asignaciones;




CREATE TABLE carga(

	idcarga	                INT AUTO_INCREMENT PRIMARY KEY,
    idasignaciones	        INT,
    idpersona	            INT,

    fechacreacion           DATETIME DEFAULT NOW(),
    fechamodificado         DATETIME NULL

    
	CONSTRAINT fk_idasignaciones_asignaciones FOREIGN KEY (idasignaciones) REFERENCES asignaciones(idasignaciones),
	CONSTRAINT fk_idpersona_personas FOREIGN KEY (idpersona) REFERENCES personas(idpersona)
    
)ENGINE = INNODB;   


INSERT INTO carga(idasignaciones,idpersona)
VALUES
(1,4),
(2,5),
(3,6),
(3,8),
(2,9);
SELECT * FROM carga;



CREATE TABLE seguimiento(

	idseguimiento	        INT AUTO_INCREMENT PRIMARY KEY,
    fechainicio		        DATETIME,
    fechafin		        DATETIME,
    idestado		        INT,
    idcarga		            INT,

    fechacreacion           DATETIME DEFAULT NOW(),
    fechamodificado         DATETIME NULL

	CONSTRAINT fk_idestado_estados FOREIGN KEY (idestado) REFERENCES estados(idestado),
	CONSTRAINT fk_idcarga_carga FOREIGN KEY (idcarga) REFERENCES carga(idcarga)
)ENGINE = INNODB;




INSERT INTO seguimiento(fechainicio,fechafin,idestado,idcarga)
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
