CREATE TABLE FRUTA_M(
ID_FRUTA NUMBER PRIMARY KEY,
NOMBRE NVARCHAR2(100),
COLOR NUMBER,--1 ROJO--2 VERDE-- 3AMARILLO--4CAFE--5GRIS--6MORADO
PRECIO NUMBER
);

INSERT INTO FRUTA_M VALUES(1,'Mango',2,25);
INSERT INTO FRUTA_M VALUES(2,'Uva',6,40);
INSERT INTO FRUTA_M VALUES(3,'Sandia',1,25);
INSERT INTO FRUTA_M VALUES(4,'Platano',3,30);
INSERT INTO FRUTA_M VALUES(5,'Papa',4,20);

SELECT*FROM FRUTA_M;


---CASE WHEN

SELECT ID_FRUTA,NOMBRE,COLOR,
(
CASE COLOR
WHEN 1 THEN 'Rojo'
WHEN 2 THEN 'Verde'
WHEN 3 THEN 'Amarillo'
WHEN 4 THEN 'Cafe'
WHEN 5 THEN 'Gris'
WHEN 6 THEN 'Morado'
ELSE 'SIN COLOR' END
)DETALLE_COLOR,PRECIO,
(
CASE
WHEN PRECIO=20 THEN 'PRECIO ECONIMICO'
WHEN PRECIO BETWEEN 19 AND 30 THEN 'PRECIO JUSTO'
WHEN PRECIO>=31 THEN 'PRECIO CARO' END
)DETALLE_PRECIO
FROM FRUTA_M;

--SUBCONSULTA ES HACER UNA CONSULTA DENTRO DE OTRA CONSULTA

SELECT MAX(PRECIO) FROM FRUTA_M;

--SUB CONSULTA DENTRO DE OTRA CONSULTA

SELECT*FROM FRUTA_M WHERE PRECIO IN(SELECT PRECIO FROM FRUTA_M);

---ACTIVIDAD

CREATE TABLE SERIES_M(
ID_SERIE NUMBER PRIMARY KEY,
NOMBRE NVARCHAR2(100),
NO_TEMPORADA NUMBER,
GENERO NUMBER,--1DRAMA2CIENCIA FICCION2TERROR 4 ACCION 5 HEROES
PRESUPUESTO NUMBER,
PAIS NVARCHAR2(100)--USA ESTADOR UNIDOS, ING INGLATERRA, ARG ARGENTENINA, MEX MEXICO, ESP ESPA�A, KOR KORE
);


INSERT INTO SERIES_M VALUES(1,'Kobra Kai',5,2,10000,'Usa');
INSERT INTO SERIES_M VALUES(2,'Black Mirror',2,3,230000,'Usa');
INSERT INTO SERIES_M VALUES(3,'Sobre NaturaL',15,3,670000,'ING');
INSERT INTO SERIES_M VALUES(4,'Dark',4,1,780000,'Kor');
INSERT INTO SERIES_M VALUES(5,'Strager Things',5,2,150000,'ESP');
INSERT INTO SERIES_M VALUES(6,'Futurama',20,2,40000,'Usa');
INSERT INTO SERIES_M VALUES(7,'Simuladores',3,1,10000,'MEX');
SELECT*FROM SERIES_M;


--1 MOSTRAR LOS CASE DE GENERO Y PAIS Y ORDENARLOS POR SUS TEMPORADAS

SELECT ID_SERIE,NOMBRE,NO_TEMPORADA,PRESUPUESTO,
(
CASE GENERO
WHEN 1 THEN 'DRAMA'
WHEN 2 THEN 'CIENCIA FICCION'
WHEN 3 THEN 'TERROR'
WHEN 4 THEN 'ACCION'
WHEN 5 THEN 'HEROES'
ELSE 'SIN GENERO' END
)DETALLE_GENERO,PAIS,
(
CASE
WHEN PAIS = 'Usa' THEN 'Estados Unidos De America' 
WHEN PAIS = 'ING' THEN 'Inglaterra' 
WHEN PAIS = 'ARG' THEN 'Argentina' 
WHEN PAIS = 'ESP' THEN 'Espa�a'
WHEN PAIS = 'Kor' THEN 'Korea'
WHEN PAIS = 'MEX' THEN 'Mexico' 
ELSE 'ESTA FUERA DE RANGO' END
)DETALLE_PAIS
FROM SERIES_M ORDER BY NO_TEMPORADA DESC; 


--2 CONTAR CUANTOS REGISTROS TENGO


SELECT  COUNT(ID_SERIE)CONTADOR 
FROM SERIES_M;


--3 BUSCAR LA SERIE CON EL PROSUPUESTO MAS CARA

SELECT MAX(PRESUPUESTO)MAX_PRESUPUESTO FROM SERIES_M; -- NOMBRE


--4 SACAR LA MEDIA DEL PROSUPUESTO DE LAS SERIES QUE SU GENERO SEA 1,2,5


SELECT AVG(PRESUPUESTO) FROM SERIES_M WHERE GENERO IN(1,2,5);

--5 MOSTRAR LOS REGISTROS ORDENADOS POR PROSUPUESTO Y CONTATENARLE EL SIGNO $


SELECT NOMBRE ,CONCAT('$',PRESUPUESTO)PRESUPUESTO FROM SERIES_M ORDER BY PRESUPUESTO ASC;


--6 BUSCAR LA SERIES QUE SUS TEMPOTADAS ESTEN ENTRE 5 Y 10

SELECT*FROM SERIES_M WHERE NO_TEMPORADA BETWEEN 5 AND 6;


CREATE TABLE PADRE_M(
ID_PADRE NUMBER PRIMARY KEY,
NOMBRE NVARCHAR2(100),
APP NVARCHAR2(100),
APM NVARCHAR2(100),
EDAD NUMBER,
TRABAJO NVARCHAR2(100)
);



CREATE TABLE HIJO_M(
ID_HIJO NUMBER PRIMARY KEY,
NOMBRE NVARCHAR2(100),
APP NVARCHAR2(100),
APM NVARCHAR2(100),
EDAD NUMBER,
HOBBIE NVARCHAR2(100),
PADRE_ID NUMBER,
CONSTRAINT FK_PADRE_HIJO_M FOREIGN KEY(PADRE_ID)REFERENCES PADRE_M(ID_PADRE));
--FOREING KEY(PADRE_ID)REFERENCES PADRE_M(IS_PADRE)


--BORRRA PRIMERO PADRE

DROP TABLE PADRE_M;

DROP TABLE HIJO_M;


INSERT INTO PADRE_M VALUES(1,'GOKU','SON','CACAROTO',55,'LUCHAR');
INSERT INTO PADRE_M VALUES(2,'HOMERO','SIMPSON','JAY',50,'OBRERO');
INSERT INTO PADRE_M VALUES(3,'DON','RAMON','VALDES',65,'LECHERO');
SELECT*FROM PADRE_M;

--HIJOS DE LOS PAPAS

INSERT INTO HIJO_M VALUES(1,'GOHAN','SON','OCCSATAN',30,'ESTUDIAR',1);
INSERT INTO HIJO_M VALUES(2,'GOTEN','SON','OCCSATAN',18,'JUGAR',1);

INSERT INTO HIJO_M VALUES(3,'BART','SIPSON','BUBIER',12,'JUGAR',2);
INSERT INTO HIJO_M VALUES(4,'LISA','SIPSON','BUBIER',8,'ESTUDIAR',2);
INSERT INTO HIJO_M VALUES(5,'MAGGIE','SIPSON','BUBIER',3,'DORMIR',2);

INSERT INTO HIJO_M VALUES(6,'CHAVO','DEL','8',12,'JUGAR',NULL);

SELECT*FROM HIJO_M;

---INNER JOIN
SELECT HIJO_M.ID_HIJO HIJO_ID,HIJO_M.NOMBRE NOMBRE_H, HIJO_M.APP APP_H, HIJO_M.APM APM_H, HIJO_M.EDAD EDAD_H, HIJO_M.HOBBIE,
PADRE_M.ID_PADRE, PADRE_M.NOMBRE NOMBRE_P, PADRE_M.APP APP_P,PADRE_M.APM APM_P, PADRE_M.EDAD EDAD_P, PADRE_M.TRABAJO
FROM HIJO_M INNER JOIN PADRE_M
ON PADRE_M.ID_PADRE = HIJO_M.PADRE_ID;

--INTER JOIN CORTA

SELECT H.ID_HIJO HIJO_ID, H.NOMBRE NOMBRE_H, H.APP APP_H, H.APM APPM_H, H.EDAD EDDA__H, H.HOBBIE,
P.ID_PADRE, P.NOMBRE NOMB_P,P.APP APP_P, P.APM APM_P,P.EDAD EDAD_P,P.TRABAJO
FROM HIJO_M H
INNER JOIN PADRE_M P
ON P.ID_PADRE = H.PADRE_ID;

--LEFT JOIN

SELECT H.ID_HIJO HIJO_ID, H.NOMBRE NOMBRE_H, H.APP APP_H, H.APM APPM_H, H.EDAD EDDA__H, H.HOBBIE,
P.ID_PADRE, P.NOMBRE NOMB_P,P.APP APP_P, P.APM APM_P,P.EDAD EDAD_P,P.TRABAJO
FROM HIJO_M H
LEFT JOIN PADRE_M P
ON P.ID_PADRE = H.PADRE_ID;


--RIGTH JOIN

SELECT H.ID_HIJO HIJO_ID, H.NOMBRE NOMBRE_H, H.APP APP_H, H.APM APPM_H, H.EDAD EDDA__H, H.HOBBIE,
P.ID_PADRE, P.NOMBRE NOMB_P,P.APP APP_P, P.APM APM_P,P.EDAD EDAD_P,P.TRABAJO
FROM HIJO_M H
RIGHT JOIN PADRE_M P
ON P.ID_PADRE = H.PADRE_ID;

--FULL JOIN

SELECT H.ID_HIJO HIJO_ID, H.NOMBRE NOMBRE_H, H.APP APP_H, H.APM APPM_H, H.EDAD EDDA__H, H.HOBBIE,
P.ID_PADRE, P.NOMBRE NOMB_P,P.APP APP_P, P.APM APM_P,P.EDAD EDAD_P,P.TRABAJO
FROM HIJO_M H
FULL JOIN PADRE_M P
ON P.ID_PADRE = H.PADRE_ID;


CREATE TABLE PAIS_M(
ID_PAIS NUMBER PRIMARY KEY,
NOMBRE NVARCHAR2(100),
CONTINENTE NUMBER,--1 ASIA 2 AFRICA 3 EUROPA 4 OCEANIA 5 AMERICA
EXTENCION NUMBER,
FECHA_DES DATE
);


CREATE TABLE PAIS_M(
ID_PAIS NUMBER PRIMARY KEY,
NOMBRE NVARCHAR2(100),
CONTINENTE NUMBER,--1 ASIA 2 AFRICA 3 EUROPA 4 OCEANIA 5 AMERICA
EXTENCION NUMBER,
FECHA_DES DATE
);


CREATE TABLE ESTADO_M(
ID_ESTADO NUMBER PRIMARY KEY,
NOMBRE NVARCHAR2(100),
HABITANTES NUMBER,--1 ASIA 2 AFRICA 3 EUROPA 4 OCEANIA 5 AMERICA
CAPITAL NVARCHAR2(100),
PAIS_ID NUMBER,
REGION NUMBER,--1SUR 2NORTE 3 OESTE 4 OESTE
FOREIGN KEY(PAIS_ID)REFERENCES PAIS_M(ID_PAIS)
);
DROP TABLE PAIS_M;

DROP TABLE ESTADO_M;

INSERT INTO PAIS_M VALUES(1,'Mexico',5,600,'01/01/1700');
INSERT INTO PAIS_M VALUES(2,'Espa�a',3,300,'01/07/1970');
INSERT INTO PAIS_M VALUES(3,'Korea',1,100,'01/01/1460');
SELECT*FROM PAIS_M;


INSERT INTO ESTADO_M VALUES(1,'Puebla',120,'Puebla',1,1);
INSERT INTO ESTADO_M VALUES(2,'Veracruz',150,'Xalapa',1,2);
INSERT INTO ESTADO_M VALUES(3,'Tlaxcala',60,'Tlaxcala',1,3);
INSERT INTO ESTADO_M VALUES(4,'Guerrero',200,'Chimpancingo',1,2);
INSERT INTO ESTADO_M VALUES(5,'Madrid',90,'Espa�a',2,1);
INSERT INTO ESTADO_M VALUES(6,'Barcelona',120,'Coru�a',2,4);
INSERT INTO ESTADO_M VALUES(7,'Valencia',120,'Betis',2,2);
INSERT INTO ESTADO_M VALUES(8,'Seul',120,'Korea',3,1);
SELECT*FROM ESTADO_M;


--1 ASIA 2 AFRICA 3 EUROPA 4 OCEANIA 5 AMERICA
--1 SUR 2 NORTE 3 ESTE 4 OESTE


--MOSTRAT LOS REGISTROS DEL PAIS CON SI INNER Y SU CASE DE REGION Y DE CONTINENTE


SELECT ID_ESTADO,NOMBRE,ID_PAIS,
(
CASE CONTINENTE
WHEN 1 THEN 'ASIA'
WHEN 2 THEN 'AFRICA'
WHEN 3 THEN 'EUROPA'
WHEN 4 THEN 'OCEANIA'
WHEN 5 THEN 'AMERICA'
ELSE 'SIN CONTINENTE' END
)DETALLE_CONTINENTE,REGION
(
CASE
WHEN REGION = 1 THEN 'SUR' 
WHEN REGION = 2 THEN 'NORTE'
WHEN REGION = 3 THEN 'ESTE' 
WHEN REGION = 4 THEN 'OESTE' 
ELSE 'SIN REGION' END
)DETALLE_REGION
FROM PAIS_M; 



--CONTAR CUANTOS ESTADOS TENGO EN CADA PAIS
--CONTAR CUANTOS ESTADOS TENGO EN CADA CONTINENTE
--BURCAR EL ESTADO CON EL MAYOR NUMERO  DE EXTENCION DE SU PAIS
--5 ORDENAR LOS ESTADOS POR SU PAIS Y LUEGO POS SU EXTENCION Y MOSTSR EL MONBRE EN MINUSCULAS




























--------------------------------------------------------------------




CREATE TABLE MARCA_M(
ID_MARCA NUMBER PRIMARY KEY,
NOMBRE NVARCHAR2(100),
PAIS NVARCHAR2(100)
);


CREATE TABLE ORIGEN_M(
ID_ORIGEN NUMBER PRIMARY KEY,
NOMBRE NVARCHAR2(100),
PAIS NUMBER, ---1 USA 2RURIA 3 MEX 4 JAPON 5 CHINA 6 FRANCIA 7 ESPA�A 8 ITALIA
FECHA_CREACION DATE
);

CREATE TABLE SUPERHEROES_M(
ID_SUPER NUMBER PRIMARY KEY,
NOMBRE NVARCHAR2(100),
APP NVARCHAR2(100),
ALIAS NVARCHAR2(100),
MARCA_ID NUMBER,
PODER NUMBER,
ORIGEN_ID NUMBER,
DEBILIDAD NVARCHAR2(100),
FECHA_NAC DATE,
CONSTRAINT FK_SUPER_ORIGEN_M FOREIGN KEY(ORIGEN_ID) REFERENCES ORIGEN_M(ID_ORIGEN),
FOREIGN KEY(MARCA_ID)REFERENCES MARCA_M(ID_MARCA)
);

SELECT*FROM SUPERHERORES_M;

DROP TABLE MARCA_M;
DROP TABLE ORIGEN_M;
DROP TABLE SUPERHEROES_M;


INSERT INTO MARCA_M VALUES(1, 'DC', 'USA');
INSERT INTO MARCA_M VALUES(2, 'Marvel', 'USA');
INSERT INTO MARCA_M VALUES(3, 'Toe Animation', 'JAPON');

SELECT*FROM MARCA_M;

INSERT INTO ORIGEN_M VALUES(1, 'Cripton', 1, '01/01/1989');
INSERT INTO ORIGEN_M VALUES(2, 'Aldea escondida entre las hojas', 1, '01/01/1989');
INSERT INTO ORIGEN_M VALUES(3, 'Came house ', 4, '01/07/1979');
INSERT INTO ORIGEN_M VALUES(4, 'Tokio', 4, '01/09/2018');
INSERT INTO ORIGEN_M VALUES(5, 'New York', 1, '08/12/2000');
SELECT*FROM ORIGEN_M;

INSERT INTO SUPERHERORES_M VALUES(1, 'Clark', 'Ken', 'SuperMan', 1, 800, 1, 'Kriptonita', '03/08/1969');
INSERT INTO SUPERHERORES_M VALUES(2, 'Naruto', 'Usumaki', 'El Guerrero de 9 colas', 3, 600, 2, 'Perder el control', '04/10/1989');
INSERT INTO SUPERHERORES_M VALUES(3, 'Beymax', 'T100', 'Chalala', 3, 400, 4, 'Bateria', '06/11/2000');
INSERT INTO SUPERHERORES_M VALUES(4, 'Goku', 'Son', 'Super Sayayin', 3, 1800, 3, 'La comida', '24/12/2003');
INSERT INTO SUPERHERORES_M VALUES(5, 'Peter', 'Parquer', 'Spiderman', 2, 400, 5, 'La familia', '07/02/1959');
INSERT INTO SUPERHERORES_M VALUES(6, 'Tony', 'Stark', 'Iroman', 2, 900, 5, 'Sobervia', '03/09/2000');
SELECT*FROM SUPERHERORES_M;

--------------------------------------------------
--ACTIVIDAD


--PAIS NUMBER 1USA 2RUSIA 3MEX 4JAPON 5CHINA 6FRANCIA 7ESP 8ITALIA
--1MOSTRAR LOS DATOS DEL SUPER HEROE SU INNER SU CASE DE ORIGEN 





--2 CONTAR CUANTOS HEROES TENGO EN CADA MARCA

SELECT NOMBRE, COUNT(ID_SUPER)CONTADOR
FROM SUPERHERORES_M
GROUP BY NOMBRE;


--3BUSCAR AL HEROE MAS PODEROSO




--4 BUSCAR AL HEROE QUE SU PAIS SEA USA Y ORDENARLOS POR SU NOMBRE 
--5 SUMAR LOS PODERES DE LOS HEROES QUE SU NOMBRE TENGA UNA o