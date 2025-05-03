USE crmYonda;



-- Cuantas personas tienen el origen por cartel
SELECT p.apellidos, p.nombres, p.tipodoc, p.numdoc, p.telefono, p.email, o.origen FROM personas p
INNER JOIN origenes o
ON o.idorigen = p.idorigen
WHERE o.origen ='Cartel';

SELECT  count(p.idpersona) AS 'Total clientes',
		round((count(p.idpersona)*100.0/(select count(*) from personas)),2) AS porcentaje, o.origen FROM personas p
INNER JOIN origenes o
ON o.idorigen = p.idorigen
GROUP BY o.origen;





SELECT * FROM CARGA;


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



-- cuando quiera mostrar nuevo lead mostrar todos los registros ya que fueron nuevo al inicio
SELECT p.nombres,p.apellidos, e.estado,o.origen
FROM (
	SELECT s.*
    FROM seguimiento s
    INNER JOIN (
		SELECT c.idpersona,max(s.fechainicio) AS fechamax
        FROM seguimiento s
        INNER JOIN carga c ON c.idcarga = s.idcarga
        GROUP BY c.idpersona
	)ult ON ult.idpersona = (SELECT c2.idpersona FROM carga c2 WHERE c2.idcarga = s.idcarga)
		AND fechamax = s.fechainicio
        
)s
INNER JOIN carga c ON c.idcarga = s.idcarga 
INNER JOIN estados e ON e.idestado = s.idestado 
INNER JOIN personas p ON p.idpersona = c.idpersona 
INNER JOIN origenes o ON o.idorigen = p.idorigen
 WHERE e.estado='no calificado';
 

 
 
 -- encontrar el asesor de un cliente en especifico
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


SELECT * From contratos;

-- saber el rol que tiene un usuario
SELECT u.nomuser, r.rol
FROM usuarios u
INNER JOIN contratos ct ON ct.idcontrato = u.idcontrato
INNER JOIN roles r ON r.idrol = ct.idrol WHERE nomuser='Juan';

-- Cantidad de clientes que asesora un asesor
 SELECT u.nomuser as 'Asesor asignado', 
		COUNT(p.idpersona) AS 'Cantidad de clientes'
       FROM carga c
INNER JOIN asignaciones a ON a.idasignaciones = c.idasignaciones
INNER JOIN personas p ON p.idpersona = c.idpersona
INNER JOIN usuarios u ON a.idusuarioasesor= u.idusuario
group by nomuser;
