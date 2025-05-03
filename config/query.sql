USE crmYonda;


-- Cuantas personas tienen el origen por cartel
SELECT p.apellidos, p.nombres, p.tipodoc, p.numdoc, p.telefono, p.email, o.origen FROM personas p
INNER JOIN origenes o
ON o.idorigen = p.idorigen
WHERE o.origen ='Cartel';

SELECT * FROM CARGA;

SELECT * FROM carga c
INNER JOIN asignaciones a ON a.idasignaciones = c.idasignaciones
INNER JOIN personas p ON p.idpersona = c.idpersona WHERE c.idasignaciones = 1;



-- Carga de personas que tiene el asesor por id
SELECT u.nomuser as 'Asesor asignado', 
	   p.apellidos as 'Apellido del cliente', 
       p.nombres as 'Nombre del cliente', 
       p.tipodoc as 'tipo doc del cliente', 
       p.numdoc as 'Numero doc del cliente', 
       p.telefono as 'Telefono del cliente', 
       p.email as 'Email del cliente' FROM carga c
INNER JOIN asignaciones a ON a.idasignaciones = c.idasignaciones
INNER JOIN personas p ON p.idpersona = c.idpersona
INNER JOIN usuarios u ON a.idusuarioasesor= u.idusuario WHERE u.idusuario = 2;

-- Carga de personas que tiene el asesor por nombre de usuario
SELECT u.nomuser as 'Asesor asignado', 
	   p.apellidos as 'Apellido del cliente', 
       p.nombres as 'Nombre del cliente', 
       p.tipodoc as 'tipo doc del cliente', 
       p.numdoc as 'Numero doc del cliente', 
       p.telefono as 'Telefono del cliente', 
       p.email as 'Email del cliente' 
       FROM carga c
INNER JOIN asignaciones a ON a.idasignaciones = c.idasignaciones
INNER JOIN personas p ON p.idpersona = c.idpersona
INNER JOIN usuarios u ON a.idusuarioasesor= u.idusuario WHERE u.nomuser = 'Juan';


