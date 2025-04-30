USE crmYonda;

truncate roles;
truncate estados;
truncate origenes;
truncate personas;
truncate contratos;
truncate usuarios;
truncate asignaciones;
truncate carga;
truncate seguimiento;

SELECT p.apellidos, p.nombres, p.tipodoc, p.numdoc, p.telefono, p.email, o.origen FROM personas p
INNER JOIN origenes o
ON o.idorigen = p.idorigen
WHERE o.origen ='Cartel';

SELECT * FROM CARGA

SELECT * FROM carga c
INNER JOIN asignaciones a
INNER JOIN personas p
ON a.idasignaciones =c.idasignaciones
ON p.idpersona = c.idpersona;

