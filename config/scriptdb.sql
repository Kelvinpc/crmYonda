CREATE DATABASE crmyonda;
USE crmYonda;

CREATE TABLE roles(

	idrol		            INT AUTO_INCREMENT PRIMARY KEY,
    rol			            VARCHAR(30)             NOT NULL,
    fechacreacion           DATETIME DEFAULT NOW()  NOT NULL,
    fechamodificado         DATETIME                NULL

) ENGINE = INNODB;
-- falta cambiar el unique

CREATE TABLE estados(
	
    idestado	            INT AUTO_INCREMENT PRIMARY KEY,
    indice		            INT                     NOT NULL,
    estado		            VARCHAR(30)             NOT NULL,
    fechacreacion           DATETIME DEFAULT NOW()  NOT NULL,
    fechamodificado         DATETIME                NULL,
    
    CONSTRAINT uk_estado_estados UNIQUE (estado)
    
)ENGINE = INNODB;



CREATE TABLE origenes(

	idorigen	            INT AUTO_INCREMENT PRIMARY KEY,
    origen		            VARCHAR(30)             NOT NULL,
    fechacreacion           DATETIME DEFAULT NOW()  NOT NULL,
    fechamodificado         DATETIME                NULL,

    CONSTRAINT uk_origen_origenes UNIQUE (origen)

)ENGINE = INNODB;





CREATE TABLE personas(
	
	idpersona		        INT AUTO_INCREMENT PRIMARY KEY,
    apellidos               VARCHAR(50)             NOT NULL,
    nombres			        VARCHAR(30)             NOT NULL,
    tipodoc			        ENUM('DNI','CEX','PASS')NOT NULL COMMENT 'CEX = Carnet de EXtrangeria ; PASS=Pasaporte' ,
    numdoc			        VARCHAR(12)             NOT NULL,
    fechanac		        DATE                    NULL,
    telefono		        VARCHAR(12)             NULL,
    email			        VARCHAR(255)            NULL,
    idorigen		        INT                     NULL,
    fechacreacion           DATETIME DEFAULT NOW()  NOT NULL,
    fechamodificado         DATETIME                NULL,

    CONSTRAINT fk_idorigen_personas FOREIGN KEY (idorigen) REFERENCES origenes(idorigen)
    
)ENGINE = INNODB;



CREATE TABLE contratos(

	idcontrato		        INT AUTO_INCREMENT PRIMARY KEY,
    idpersona		        INT                     NOT NULL,
    fechainicio		        DATETIME                NOT NULL,
    fechafin		        DATETIME                NULL,
    idrol			        INT                     NOT NULL,
    fechacreacion           DATETIME DEFAULT NOW()  NOT NULL,
    fechamodificado         DATETIME                NULL,

    CONSTRAINT fk_idrol_roles FOREIGN KEY (idrol) REFERENCES roles(idrol),
	CONSTRAINT fk_idpersona_contratos FOREIGN KEY (idpersona) REFERENCES personas(idpersona)
    
)ENGINE = INNODB;



CREATE TABLE usuarios(

	idusuario		        INT AUTO_INCREMENT PRIMARY KEY,
    idcontrato		        INT                     NOT NULL,
    nomuser			        VARCHAR(30)             NOT NULL,
    passuser		        VARCHAR(255)            NOT NULL,
    fechacreacion           DATETIME DEFAULT NOW()  NOT NULL,
    fechamodificado         DATETIME                NULL,

    CONSTRAINT uk_nomuser_usuarios UNIQUE (nomuser), 
    CONSTRAINT fk_idcontrato_usuarios FOREIGN KEY (idcontrato) REFERENCES contratos(idcontrato)

)ENGINE = INNODB;


			
CREATE TABLE asignaciones(
	idasignaciones		    INT AUTO_INCREMENT PRIMARY KEY,
    idusuarioasigna	        INT                     NOT NULL,
	idusuarioasesor	        INT                     NOT NULL,
    fechacreacion           DATETIME DEFAULT NOW()  NOT NULL,
    fechamodificado         DATETIME                NULL,

    
	CONSTRAINT fk_idusuarioasigna_asignaciones FOREIGN KEY (idusuarioasigna) REFERENCES usuarios(idusuario), -- NOMBRE DEL LA PERSONA QUE ASIGNO
	CONSTRAINT fk_idusuarioasesor_asignaciones FOREIGN KEY (idusuarioasesor) REFERENCES usuarios(idusuario) -- NOMBRE DEL ASCESOR
)ENGINE =INNODB;




CREATE TABLE carga(

	idcarga	                INT AUTO_INCREMENT PRIMARY KEY,
    idasignaciones	        INT                     NOT NULL,
    idpersona	            INT                     NOT NULL,
    fechacreacion           DATETIME DEFAULT NOW()  NOT NULL,
    fechamodificado         DATETIME                NULL,
    
	CONSTRAINT fk_idasignaciones_asignaciones FOREIGN KEY (idasignaciones) REFERENCES asignaciones(idasignaciones),
	CONSTRAINT fk_idpersona_asignaciones FOREIGN KEY (idpersona) REFERENCES personas(idpersona)
    
)ENGINE = INNODB;  


CREATE TABLE seguimiento(

	idseguimiento	        INT AUTO_INCREMENT PRIMARY KEY,
    fechainicio		        DATETIME                NOT NULL,
    fechafin		        DATETIME                NOT NULL,
    idestado		        INT                     NOT NULL,
    idcarga		            INT                     NOT NULL,
    fechacreacion           DATETIME DEFAULT NOW()  NOT NULL,
    fechamodificado         DATETIME                NULL,

	CONSTRAINT fk_idestado_seguimiento FOREIGN KEY (idestado) REFERENCES estados(idestado),
	CONSTRAINT fk_idcarga_seguimiento FOREIGN KEY (idcarga) REFERENCES carga(idcarga)
)ENGINE = INNODB;