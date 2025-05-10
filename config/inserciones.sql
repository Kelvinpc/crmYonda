USE crmYonda;

INSERT INTO roles (rol) VALUES('Jefe de Marketing'),('Asesor');
SELECT * FROM roles;


INSERT INTO estados (indice,estado)VALUES
					(1,'Lead nuevo'),
					(2,'No calificado'),
					(3,'Calificado'),
					(4,'Contactado'),
					(5,'Intento de contacto');
SELECT * FROM estados;



INSERT INTO origenes(origen)values
('Instagram'),
('Facebook'),
('Cartel'),
('anuncios'),
('TikTok');

SELECT * FROM origenes;




INSERT INTO personas (apellidos,nombres,tipodoc,numdoc,fechanac,telefono,email,idorigen)values
		('Pérez González', 'Juan Carlos', 'DNI', '12345678', '1985-06-15', '987654321', 'juan.perez@example.com', NULL),
		('Sánchez Morales', 'Ana María', 'CEX', 'A1234567', '1990-09-10', '945678123', 'ana.sanchez@example.com', NULL),
		('López Ramírez', 'Carlos Alberto', 'DNI', '87654321', '1995-12-01', '912345678', 'carlos.lopez@example.com', NULL),

		('Gómez Martínez', 'Luisa Fernanda', 'CEX', 'B2345678', '1982-03-25', '965432109', 'luisa.gomez@example.com', 3),
		('Martínez Suárez', 'Ricardo', 'DNI', '23456789', '1992-11-20', '930123456', 'ricardo.martinez@example.com', 1),
		('Vásquez Luna', 'Elena', 'PASS', 'C3456789', '1988-04-12', '928765432', 'elena.vasquez@example.com', 1),

		('Pipa Castilla', 'Kelvin', 'DNI', '74747474', '2005-08-29', '955959955', 'kelvin@gmail.com', NULL);

INSERT INTO personas (apellidos,nombres,tipodoc,numdoc,fechanac,telefono,email,idorigen)values
		('Fernández Torres', 'Marta Beatriz', 'DNI', '134345678', '1990-05-12', '982345678', 'marta.fernandez@example.com', 1),
		('Gomez', 'Juan', 'DNI', '12345678', '1990-05-15', '987654321', 'juan.gomez@example.com', 1),
		('Perez', 'Maria', 'PASS', 'X1234567', '1985-08-22', '987654322', 'maria.perez@example.com', 2),
		('Lopez', 'Carlos', 'CEX', 'P9876543', '1992-12-01', '987654323', 'carlos.lopez@example.com', 3),
		('Fernandez', 'Laura', 'DNI', '23456789', '1988-03-30', '987654324', 'laura.fernandez@example.com', 4),
		('Martinez', 'Luis', 'PASS', 'Y1234567', '1995-01-10', '987654325', 'luis.martinez@example.com', 5),
		('Castillo Ríos', 'José Luis', 'CEX', 'C9876543', '1985-02-20', '961234567', 'jose.castillo@example.com', 2);
SELECT * FROM personas;



INSERT INTO contratos (idpersona, fechainicio, fechafin, idrol)
VALUES
(1, '2025-01-01', '2025-06-28', 2),
(2, '2025-01-15', '2025-06-14', 2),
(3, '2025-02-01', '2025-06-25', 2),
(7, '2025-02-01', '2025-12-15', 1);
SELECT * FROM contratos;



INSERT INTO usuarios(idcontrato,nomuser,passuser)VALUES
(1,'Juan','9IJN0OKM'),
(2,'Ana','8UHB7YGV'),
(3,'Carlos','6TFC5RDX'),
(4,'Kelvin','4ESZ3WA<');
SELECT * FROM usuarios;




INSERT INTO asignaciones(idusuarioasigna,idusuarioasesor)
VALUES
(4,1),
(4,2),
(4,3);
SELECT * FROM asignaciones;




INSERT INTO carga(idasignaciones,idpersona)
VALUES
(1,4),
(2,5),
(3,6),
(3,8),
(2,9),
(2,12),
(1,13),
(2,14),
(2,11),
(3,10);
SELECT * FROM carga;





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
('2025-03-23',NULL,2,5),

('2025-02-15',NULL,1,6),
('2025-02-24',NULL,1,7),

('2025-03-11','2025-03-24',1,8),
('2025-02-01','2025-03-24',1,9),
('2025-01-22','2025-03-24',1,10),

('2025-03-26',NULL,2,8),
('2025-02-15',NULL,2,9),
('2025-02-10',NULL,2,10);

SELECT * FROM seguimiento;


