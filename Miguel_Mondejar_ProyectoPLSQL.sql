-------------- Script Proyecto PL/SQL || Miguel Mondéjar González --------------
  
-- BASE DE DATOS ---------------------------------------------------------------

-- Voy a crear una BBDD de Pokémon. Un Pokemon tiene su numero de pokedex con su informacion, su region donde habita, 
-- sus ataques, su altura, peso y sus tipos. 

-- Tablas --
CREATE TABLE POKEDEX( -- Donde vamos a tener toda la informacion acerca del pokemon
    COD_POKEDEX NUMBER(5),-- Tambien es el numero
    NOMBRE_POKEMON VARCHAR(15),
    REGION VARCHAR(10) NOT NULL,
    PESO DECIMAL(4,2),
    ALTURA DECIMAL(4,2),
    SEXO VARCHAR2(10),
    CONSTRAINT DEX_COD_PK PRIMARY KEY (COD_POKEDEX),
    CONSTRAINT DEX_REG_CK CHECK (UPPER(REGION) IN ('KANTO','JOHTO','HOENN','SINNOH','TESELIA','KALOS','ALOLA','GALAR')), 
    -- lista de regiones, luego añadiré una más
    CONSTRAINT DEX_COD_CK CHECK (COD_POKEDEX BETWEEN 1 AND 890), -- Total de Pokémon existentes
    CONSTRAINT DEX_SEX_CK CHECK (UPPER(SEXO) IN ('MACHO','HEMBRA','NULO'))
);

CREATE TABLE TIPOS( -- Almacenamos los tipos
    COD_TIPOS NUMBER(5),
    NOMBRE_TIPOS VARCHAR(10) NOT NULL, -- Obligatoriamente tiene que ser de un tipo
    CONSTRAINT TIP_COD_PK PRIMARY KEY (COD_TIPOS),
    CONSTRAINT TIP_NOM_UK UNIQUE (NOMBRE_TIPOS) -- Nombre del tipo unico
);

CREATE TABLE REGION( -- Almacenamos las regiones con sus rutas y ciudades
    COD_REGION NUMBER(5),
    NOMBRE_REGION VARCHAR(10) NOT NULL,
    RUTAS NUMBER(3),
    CIUDADES VARCHAR(10),
    CONSTRAINT REG_COD_PK PRIMARY KEY (COD_REGION),
    CONSTRAINT REG_NOM_UK UNIQUE (NOMBRE_REGION), -- El nombre de la región es unico
    CONSTRAINT REG_CIU_UK UNIQUE (CIUDADES) -- El nombre de las ciudades es unico
);

CREATE TABLE ATAQUES( -- Ataque del Pokémon
    COD_ATAQUE NUMBER(5),
    NOMBRE_ATAQUE VARCHAR2(15) NOT NULL,
    TIPO_ATAQUE NUMBER(3) NOT NULL, -- Si es tipo fuego, agua, etc
    APTO CHAR(2) DEFAULT 'NO' NOT NULL, -- Puede usarlo o no
    CONSTRAINT ATA_COD_PK PRIMARY KEY (COD_ATAQUE),
    CONSTRAINT ATA_TIP_FK FOREIGN KEY (TIPO_ATAQUE) REFERENCES TIPOS (COD_TIPOS),
    CONSTRAINT ATA_APT_CK CHECK (UPPER(APTO) IN ('SI','NO')),
    CONSTRAINT ATA_NOM_UK UNIQUE (NOMBRE_ATAQUE) -- Nombre del ataque unico
);

CREATE TABLE POKEMON( -- Aquí se almacenan los Pokémon con su nombre y los demás datos son claves ajenas
    NOMBRE VARCHAR(15),
    COD_POKEMON NUMBER(5),
    REGION NUMBER(5),
    TIPOS NUMBER(5) NOT NULL,
    POKEDEX NUMBER(5),
    ATAQUE NUMBER(5),
    CONSTRAINT POK_NOM_PK PRIMARY KEY (COD_POKEMON),
    CONSTRAINT POK_POK_FK FOREIGN KEY (POKEDEX) REFERENCES POKEDEX (COD_POKEDEX),
    CONSTRAINT POK_REG_FK FOREIGN KEY (REGION) REFERENCES REGION (COD_REGION),
    CONSTRAINT POK_TIP_FK FOREIGN KEY (TIPOS) REFERENCES TIPOS (COD_TIPOS),
    CONSTRAINT POK_ATA_FK FOREIGN KEY (ATAQUE) REFERENCES ATAQUES (COD_ATAQUE),
    CONSTRAINT POK_NOM_FK UNIQUE (NOMBRE) -- Nombre unico
);

-- MODIFICACIONES --

-- Vamos a mover el atributo sexo a la tabla Pokémon
ALTER TABLE POKEDEX DROP COLUMN SEXO CASCADE CONSTRAINTS;
ALTER TABLE POKEMON ADD SEXO VARCHAR2(10);
ALTER TABLE POKEMON ADD CONSTRAINT POK_SEX_CK CHECK (UPPER(SEXO) IN ('MACHO','HEMBRA','NULO'));

-- Añadimos una nueva región
ALTER TABLE POKEDEX DROP CONSTRAINT DEX_REG_CK;
ALTER TABLE POKEDEX ADD CONSTRAINT DEX_REG_CK CHECK (UPPER(REGION) IN ('KANTO','JOHTO','HOENN','SINNOH','TESELIA','KALOS','ALOLA','GALAR','HISUI')); -- Añadimo una region más

-- Desactivo que sean hasta 890 Pokemon (porque hemos metido una nueva región)
ALTER TABLE POKEDEX DISABLE CONSTRAINT DEX_COD_CK; 

-- INSERTAR DATOS --
-- Todos los tipos existentes actuales
INSERT INTO TIPOS VALUES(1, 'PLANTA');
INSERT INTO TIPOS VALUES(2, 'FUEGO');
INSERT INTO TIPOS VALUES(3, 'AGUA');
INSERT INTO TIPOS VALUES(4, 'ELÉCTRICO');
INSERT INTO TIPOS VALUES(5, 'SINIESTRO');
INSERT INTO TIPOS VALUES(6, 'FANTASMA');
INSERT INTO TIPOS VALUES(7, 'PSÍQUICO');
INSERT INTO TIPOS VALUES(8, 'VENENO');
INSERT INTO TIPOS VALUES(9, 'LUCHA');
INSERT INTO TIPOS VALUES(10, 'VOLADOR');
INSERT INTO TIPOS VALUES(11, 'HADA');
INSERT INTO TIPOS VALUES(12, 'NORMAL');
INSERT INTO TIPOS VALUES(13, 'TIERRA');
INSERT INTO TIPOS VALUES(14, 'ROCA');
INSERT INTO TIPOS VALUES(15, 'ACERO');
INSERT INTO TIPOS VALUES(16, 'BICHO');
INSERT INTO TIPOS VALUES(17, 'HIELO');
INSERT INTO TIPOS VALUES(18, 'DRAGÓN');

-- Todos los tipos con al menos un ataque (sería una locura meter todos los ataques)
INSERT INTO ATAQUES VALUES(1110, 'LÁTIGO CEPA', 1, 'SI');
INSERT INTO ATAQUES VALUES(1111, 'LANZALLAMAS', 2, 'SI');
INSERT INTO ATAQUES VALUES(1112, 'PISTOLA AGUA', 3, 'SI');
INSERT INTO ATAQUES VALUES(1113, 'RAYO', 4, 'SI');
INSERT INTO ATAQUES VALUES(1114, 'PULSO UMBRIO', 5, 'SI');
INSERT INTO ATAQUES VALUES(1115, 'BOLA SOMBRA', 6, 'SI');
INSERT INTO ATAQUES VALUES(1116, 'PSÍQUICO', 7, 'SI');
INSERT INTO ATAQUES VALUES(1117, 'PUYA NOCIVA', 8, 'SI');
INSERT INTO ATAQUES VALUES(1118, 'ULTRAPUÑO', 9, 'SI');
INSERT INTO ATAQUES VALUES(1119, 'PÁJARO OSADO', 10, 'SI');
INSERT INTO ATAQUES VALUES(1120, 'CARANTOÑA', 11, 'SI');
INSERT INTO ATAQUES VALUES(1121, 'PLACAJE', 12, 'SI');
INSERT INTO ATAQUES VALUES(1122, 'TERREMOTO', 13, 'SI');
INSERT INTO ATAQUES VALUES(1123, 'LANZA ROCAS', 14, 'SI');
INSERT INTO ATAQUES VALUES(1124, 'COLA FERREA', 15, 'SI');
INSERT INTO ATAQUES VALUES(1125, 'CHUPAVIDAS', 16, 'SI');
INSERT INTO ATAQUES VALUES(1126, 'RAYO HIELO', 17, 'SI');
INSERT INTO ATAQUES VALUES(1127, 'ENFADO', 18, 'SI');

-- Todas las regiones existentes actuales
INSERT INTO REGION VALUES(100, 'KANTO', 22, 'VERDE');
INSERT INTO REGION VALUES(200, 'JOHTO', 22, 'IRIS');
INSERT INTO REGION VALUES(300, 'HOENN', 34, 'PETALIA');
INSERT INTO REGION VALUES(400, 'SINNOH', 30, 'JUBILEO');
INSERT INTO REGION VALUES(500, 'TESELIA', 22, 'MAYÓLICA');
INSERT INTO REGION VALUES(600, 'KALOS', 22, 'LUMINALIA');
INSERT INTO REGION VALUES(700, 'ALOLA', 22, 'MELEMELE');
INSERT INTO REGION VALUES(800, 'GALAR', 10, 'PUNTERA');
INSERT INTO REGION VALUES(900, 'HISUI', NULL, 'VILLA JUB');

-- Algunas entradas de la Pokédex como prueba
INSERT INTO POKEDEX VALUES(001, 'BULBASAUR', 'KANTO', 6.9, 0.7);
INSERT INTO POKEDEX VALUES(004, 'CHARMANDER', 'KANTO', 8.5, 0.6);
INSERT INTO POKEDEX VALUES(007, 'SQUIRTLE', 'KANTO', 9.0, 0.5);
INSERT INTO POKEDEX VALUES(025, 'PIKACHU', 'KANTO', 6.0, 0.4);
INSERT INTO POKEDEX VALUES(181, 'AMPHAROS', 'JOHTO', 61.5, 1.4);
INSERT INTO POKEDEX VALUES(197, 'UMBREON', 'JOHTO', 27, 1);
INSERT INTO POKEDEX VALUES(252, 'TREECKO', 'HOENN', 5, 0.5); 
INSERT INTO POKEDEX VALUES(448, 'LUCARIO', 'SINNOH', 54, 1.2);
INSERT INTO POKEDEX VALUES(493, 'ARCEUS', 'SINNOH', 99, 3.2);
INSERT INTO POKEDEX VALUES(494, 'VICTINI', 'TESELIA', 4, 0.4);
INSERT INTO POKEDEX VALUES(658, 'GRENINJA', 'KALOS', 40, 1.5);
INSERT INTO POKEDEX VALUES(785, 'TAPU KOKO', 'ALOLA', 20.5, 1.8);
INSERT INTO POKEDEX VALUES(861, 'GRIMMSNARL', 'GALAR', 61, 1.5);
INSERT INTO POKEDEX VALUES(899, 'WYRDEER', 'HISUI', 95.1, 1.8);

-- Algunos Pokémon como prueba (sería una locura máxima meter más de 900 pokémon)
INSERT INTO POKEMON VALUES('BULBASAUR', 0, 100, 1, 001, 1110, 'HEMBRA');  
INSERT INTO POKEMON VALUES('CHARMANDER', 3, 100, 2, 004, 1111, 'MACHO'); 
INSERT INTO POKEMON VALUES('SQUIRTLE', 6, 100, 3, 007, 1112, 'HEMBRA'); 
INSERT INTO POKEMON VALUES('PIKACHU', 24, 100, 4, 025, 1113, 'MACHO');
INSERT INTO POKEMON VALUES('AMPHAROS', 180, 200, 4, 181, 1113, 'MACHO');
INSERT INTO POKEMON VALUES('TREECKO', 251, 300, 1, 252, 1110, 'MACHO'); 
INSERT INTO POKEMON VALUES('UMBREON', 196, 200, 5, 197, 1114, 'MACHO');
INSERT INTO POKEMON VALUES('LUCARIO', 447, 400, 9, 448, 1118, 'MACHO');
INSERT INTO POKEMON VALUES('ARCEUS', 492, 400, 12, 493, 1121, 'NULO');
INSERT INTO POKEMON VALUES('VICTINI', 493, 500, 2, 494, 1111, 'NULO');
INSERT INTO POKEMON VALUES('GRENINJA', 657, 600, 3, 658, 1112, 'HEMBRA');
INSERT INTO POKEMON VALUES('TAPU KOKO', 784, 700, 4, 785, 1113, 'NULO');
INSERT INTO POKEMON VALUES('GRIMMSNARL', 860, 800, 5, 861, 1114, 'MACHO');
INSERT INTO POKEMON VALUES('WYRDEER', 898, 900, 12, 899, 1121,'HEMBRA');

COMMIT;

-- Consulta de prueba
SELECT NOMBRE, NOMBRE_REGION, NOMBRE_TIPOS, COD_POKEDEX, NOMBRE_ATAQUE, PESO, ALTURA FROM POKEMON, POKEDEX, TIPOS, ATAQUES, REGION
WHERE COD_REGION=POKEMON.REGION AND COD_TIPOS=POKEMON.TIPOS AND COD_POKEDEX=POKEMON.POKEDEX AND COD_ATAQUE=POKEMON.ATAQUE ORDER BY COD_POKEDEX;

-- PL/SQL ----------------------------------------------------------------------

SET SERVEROUTPUT ON

-- PROCEDIMIENTOS --------------------------------------------------------------

-- pokemonRegistrado --
-- Este procedimiento va a servir para registrar un Pokémon en la Pokedex, se pedirán por parámetros
-- el número de la pokedex, el nombre, la región, el peso y altura del Pokémon
CREATE OR REPLACE PROCEDURE registrarPokemon (numPokedex NUMBER, nombre POKEMON.NOMBRE%TYPE, tipo TIPOS.NOMBRE_TIPOS%TYPE, region POKEDEX.REGION%TYPE, 
peso POKEDEX.PESO%TYPE, altura POKEDEX.ALTURA%TYPE) IS
    CURSOR POKE IS SELECT * FROM POKEDEX;
    -- Estos próximos cursores son para rellenar la tabla Pokémon, esta se compone de las claves (cod) así que vamos aprovechar y 
    -- hacer unas consultas a ellas y así ahorramos pedir más datos
    CURSOR REG IS SELECT COD_REGION FROM REGION WHERE NOMBRE_REGION LIKE UPPER(region); -- Buscar cod de región
    CURSOR TIP IS SELECT COD_TIPOS FROM TIPOS WHERE NOMBRE_TIPOS LIKE UPPER(tipo); -- Buscar cod de tipo
    CURSOR ATA IS SELECT COD_ATAQUE FROM ATAQUES WHERE TIPO_ATAQUE IN (SELECT COD_TIPOS FROM TIPOS WHERE NOMBRE_TIPOS LIKE UPPER(tipo)); -- Buscar cod de ataque
    pok POKE%ROWTYPE; 
    r REG%ROWTYPE;
    t TIP%ROWTYPE;
    a ATA%ROWTYPE;
BEGIN
    OPEN POKE; -- Abrimos cursor
        OPEN REG; -- Abrimos cursor
            OPEN TIP; -- Abrimos cursor
                OPEN ATA; -- Abrimos cursor
                    FETCH POKE INTO pok;
                    FETCH REG INTO r;
                    FETCH TIP INTO t;
                    FETCH ATA INTO a;
                        INSERT INTO POKEDEX VALUES(numPokedex,UPPER(nombre),UPPER(region),peso,altura); -- Insertamos en la pokedex
                        INSERT INTO POKEMON VALUES(UPPER(nombre), (numPokedex-1), r.COD_REGION, t.COD_TIPOS, numPokedex, a.COD_ATAQUE, null); -- Insertamos en la tabla pokémon   
                        DBMS_OUTPUT.PUT_LINE(nombre || ' REGISTRADO correctamente en la Pokédex'); -- Imprimimos
                CLOSE POKE; -- Cerramos cursor
            CLOSE REG; -- Cerramos cursor
        CLOSE TIP; -- Cerramos cursor
    CLOSE ATA; -- Cerramos cursor
END registrarPokemon;
/


-- deletePokemon --
-- Como su nombre indica, va a servir para eliminar un Pokémon de la tabla Pokémon y Pokédex, se pedirá 
-- solamente el nombre del Pokémon a eliminar y si existe, será eliminado.
CREATE OR REPLACE PROCEDURE deletePokemon (nombre_poke POKEMON.NOMBRE%TYPE) IS
BEGIN
    DELETE FROM POKEMON WHERE NOMBRE LIKE UPPER(nombre_poke); -- Eliminamos al pokémon de ambas tablas
    DELETE FROM POKEDEX WHERE NOMBRE_POKEMON LIKE UPPER(nombre_poke);
    DBMS_OUTPUT.PUT_LINE(nombre_poke || ' ELIMINADO correctamente de la Pokédex'); -- Imprimimos 
END deletePokemon;
/


-- datosRegion --
-- Este procedimiento sirve para que, dependiendo de la región, te va a decir toda la información
-- acerca de una región incluyendo el número de Pokémon que hay, número de tipos existentes, el peso y altura mayor
-- de la región. 
CREATE OR REPLACE PROCEDURE datosRegion (region_nombre REGION.NOMBRE_REGION%TYPE) IS
    CURSOR REGION_CURSOR IS SELECT COD_REGION, NOMBRE_REGION, RUTAS, CIUDADES, COUNT(POKEMON.REGION) AS NUM_DE_POKEMON, COUNT(POKEMON.TIPOS) AS NUM_TIPOS, MAX(PESO) AS MAYOR_PESO_PKMN, MAX(ALTURA) AS MAYOR_ALTURA_PKMN
    FROM REGION, POKEMON, TIPOS, POKEDEX
    WHERE COD_REGION=POKEMON.REGION AND COD_TIPOS=TIPOS AND COD_POKEDEX=POKEDEX AND POKEMON.REGION IN (SELECT COD_REGION FROM REGION WHERE NOMBRE_REGION LIKE UPPER(region_nombre)) 
    GROUP BY COD_REGION, NOMBRE_REGION, RUTAS, CIUDADES, POKEMON.REGION;
    r REGION_CURSOR%ROWTYPE;
BEGIN
    OPEN REGION_CURSOR; -- Abrimos cursor
        FETCH REGION_CURSOR INTO r;
            DBMS_OUTPUT.PUT_LINE('CÓDIGO: ' || r.COD_REGION || ' | NOMBRE: ' || r.NOMBRE_REGION || ' | NÚMERO DE RUTAS: ' || r.RUTAS || ' | CIUDAD: ' || r.CIUDADES 
            || ' | NÚMERO DE POKÉMON: ' || r.NUM_DE_POKEMON || ' | NÚMEROS DE TIPOS: ' || r.NUM_TIPOS|| ' | MAYOR PESO: ' || r.MAYOR_PESO_PKMN || ' | MAYOR ALTURA: ' 
            || r.MAYOR_ALTURA_PKMN);
    CLOSE REGION_CURSOR; -- Cerramos cursor
END datosRegion;
/


-- FUNCIONES -------------------------------------------------------------------

-- tablaDeTiposSupereficaz --
-- La tabla de tipos en Pokémon es una tabla donde te indica que tipos son super eficaces, poco eficaces o 
-- neutros a otros tipos. Esta función te va a decir, dependiendo del tipo que le pases por parámetro, a que 
-- tipos le "ganarías" con tu tipo (por así decirlo). Por ejemplo, si dices el tipo fuego pues la función te 
-- dirá que el fuego le gana al tipo bicho, planta, hielo y acero.
CREATE OR REPLACE FUNCTION tablaDeTiposSupereficaz (tipoTuPoke TIPOS.NOMBRE_TIPOS%TYPE)
RETURN VARCHAR2 IS
BEGIN
    -- Enorme if y elsif con todos los posibles resultados, en caso de poner un tipo erróneo, el programa te lo dice.
    IF LOWER(tipoTuPoke) = 'planta' THEN  
        RETURN 'El tipo PLANTA es SUPEREFICAZ CONTRA: Tierra, Roca, Agua';
    ELSIF LOWER(tipoTuPoke) = 'bicho' THEN
        RETURN 'El tipo BICHO es SUPEREFICAZ CONTRA: Planta, Siniestro, Psíquico';
    ELSIF LOWER(tipoTuPoke) = 'siniestro' THEN
        RETURN 'El tipo SINIESTRO es SUPEREFICAZ CONTRA: Fantasma, Psíquico';
    ELSIF LOWER(tipoTuPoke) = 'fantasma' THEN
        RETURN 'El tipo FANTASMA es SUPEREFICAZ CONTRA: Fantasma, Psíquico';
    ELSIF LOWER(tipoTuPoke) = 'electrico' THEN
        RETURN 'El tipo ELÉCTRICO es SUPEREFICAZ CONTRA: Volador, Agua';
    ELSIF LOWER(tipoTuPoke) = 'agua' THEN
        RETURN 'El tipo AGUA es SUPEREFICAZ CONTRA: Fuego, Tierra, Roca';
    ELSIF LOWER(tipoTuPoke) = 'psiquico' THEN
        RETURN 'El tipo PSIQUICO es SUPEREFICAZ CONTRA: Lucha, Veneno';
    ELSIF LOWER(tipoTuPoke) = 'hada' THEN
        RETURN 'El tipo HADA es SUPEREFICAZ CONTRA: Lucha, Siniestro, Dragón';
    ELSIF LOWER(tipoTuPoke) = 'acero' THEN
        RETURN 'El tipo ACERO es SUPEREFICAZ CONTRA: Hada, Hielo, Roca';
    ELSIF LOWER(tipoTuPoke) = 'veneno' THEN
        RETURN 'El tipo VENENO es SUPEREFICAZ CONTRA: Hada, Planta';
    ELSIF LOWER(tipoTuPoke) = 'tierra' THEN
        RETURN 'El tipo TIERRA es SUPEREFICAZ CONTRA: Eléctrico, Fuego, Veneno, Roca, Acero';
    ELSIF LOWER(tipoTuPoke) = 'hielo' THEN
        RETURN 'El tipo HIELO es SUPEREFICAZ CONTRA: Dragón, Volador, Planta, Tierra';
    ELSIF LOWER(tipoTuPoke) = 'dragon' THEN
        RETURN 'El tipo DRAGÓN es SUPEREFICAZ CONTRA: Dragón';
    ELSIF LOWER(tipoTuPoke) = 'lucha' THEN
        RETURN 'El tipo LUCHA es SUPEREFICAZ CONTRA: Siniestro, Hielo, Normal, Roca, Acero';
    ELSIF LOWER(tipoTuPoke) = 'fuego' THEN
        RETURN 'El tipo FUEGO es SUPEREFICAZ CONTRA: Bicho, Planta, Hielo, Acero';
    ELSIF LOWER(tipoTuPoke) = 'roca' THEN
        RETURN 'El tipo ROCA es SUPEREFICAZ CONTRA: Bicho, Fuego, Volador, Hielo';
    ELSIF LOWER(tipoTuPoke) = 'volador' THEN
        RETURN 'El tipo VOLADOR es SUPEREFICAZ CONTRA: Bicho, Lucha, Planta';
    ELSIF LOWER(tipoTuPoke) = 'normal' THEN
        RETURN 'El tipo NORMAL no es SUPEREFICAZ contra ninguno';
    ELSE RETURN '¡Ese tipo no existe!';
    END IF;
END tablaDeTiposSupereficaz;
/


-- Funcion buscarEnLaPokedex --
-- Como su nombre indica, esta función es para buscar TODA la información de un Pokémon específico. 
-- Para ello he hecho un cursor con muchas subconsultas que me devolverá toda la info 
-- (nombre, peso, altura, región, numero, tipo, …). Tienes que poner el nombre del Pokémon que quieras 
-- buscar y te dará el pedido.
CREATE OR REPLACE FUNCTION buscarEnLaPokedex (nombrePoke POKEMON.NOMBRE%TYPE) 
RETURN VARCHAR2 IS
    CURSOR INFO_POKEMON IS
            -- Select que duelve toda la info del pokemon
            SELECT NOMBRE, NOMBRE_REGION, NOMBRE_TIPOS, COD_POKEDEX, NOMBRE_ATAQUE, PESO, ALTURA FROM POKEMON, POKEDEX, TIPOS, ATAQUES, REGION
            WHERE COD_REGION=POKEMON.REGION AND COD_TIPOS=POKEMON.TIPOS AND COD_POKEDEX=POKEMON.POKEDEX AND COD_ATAQUE=POKEMON.ATAQUE 
            AND NOMBRE LIKE UPPER(nombrePoke);
            pok INFO_POKEMON%ROWTYPE;
BEGIN
    OPEN INFO_POKEMON; -- Abrimos cursor
        LOOP
        FETCH INFO_POKEMON INTO pok; -- Recuperamos un registro
        EXIT WHEN INFO_POKEMON%NOTFOUND; -- Salimos si no hay más registros
           RETURN 'NOMBRE: ' || pok.NOMBRE || ' | REGIÓN ORIGEN: ' || pok.NOMBRE_REGION || ' | TIPO: ' || pok.NOMBRE_TIPOS || ' | NÚMERO POKÉDEX: ' || pok.COD_POKEDEX
            || ' | ATAQUE PRINCIPAL: ' || pok.NOMBRE_ATAQUE || ' | PESO y ALTURA: ' || pok.PESO || ' kg y ' || pok.ALTURA || ' cm';
        END LOOP;
    CLOSE INFO_POKEMON; -- Cerramos cursor
END buscarEnLaPokedex;
/


-- BLOQUES ANÓNIMOS  -----------------------------------------------------------

-- Llamada procedimiento registrarPokemon
BEGIN
    DBMS_OUTPUT.PUT_LINE ('----');
    DBMS_OUTPUT.PUT_LINE ('Bienvenido/a al programa Registrar un Pokémon.');
       
    -- Registrar un Pokémon 
    registrarPokemon (&dimePokedex,'&dimeNombre','&dimeTipo','&dimeRegion',&dimePeso,&dimeAltura); 
    -- (Tienes que pasarle su número de pokedex, nombre, tipo, región, peso y altura)
    DBMS_OUTPUT.PUT_LINE ('----');

EXCEPTION -- Excepciones del prgrama por si ocurre algún error
    WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE ('Dato no encontrado');
    WHEN program_error THEN DBMS_OUTPUT.PUT_LINE('Error en la ejecución del programa');
    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('Error inesperado. Compruebe los datos, la región y el tipo deben ser existentes. Compruebe que el peso y altura tienen un formato correcto');
END;
/

-- Llamada procedimiento deletePokemon
BEGIN
    DBMS_OUTPUT.PUT_LINE ('----');
    DBMS_OUTPUT.PUT_LINE ('Bienvenido/a al programa borrar un Pokémon.');

    -- Borrar a un Pokémon 
    deletePokemon('&dimePokemonEliminar');
    -- (Solo tienes que pasar el nombre del Pokémon y se borrará de las tablas POKEDEX y POKEMON
    DBMS_OUTPUT.PUT_LINE ('----');
EXCEPTION -- Excepciones del prgrama por si ocurre algún error
    WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE ('Dato no encontrado');
    WHEN program_error THEN DBMS_OUTPUT.PUT_LINE('Error en la ejecución del programa');
    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('Error inesperado');
END;
/

-- Llamada procedimiento datosRegion
BEGIN
    DBMS_OUTPUT.PUT_LINE ('----');
    DBMS_OUTPUT.PUT_LINE ('Bienvenido/a al programa datos de la región.');
    
    -- Datos de la región
    datosRegion('&dimeRegion');
    -- (Solo tienes que poner el nombre de la región para saber todos sus datos)
    DBMS_OUTPUT.PUT_LINE ('----');
  
EXCEPTION -- Excepciones del prgrama por si ocurre algún error
    WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE ('Dato no encontrado');
    WHEN program_error THEN DBMS_OUTPUT.PUT_LINE('Error en la ejecución del programa');
    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('Error inesperado');
END;
/

-- Llamada función tablaDeTiposSupereficaz
BEGIN
    DBMS_OUTPUT.PUT_LINE ('----');
    DBMS_OUTPUT.PUT_LINE ('Bienvenido/a al programa Tabla de tipos.');
  
    DBMS_OUTPUT.PUT_LINE(tablaDeTiposSupereficaz('&DimeTipo')); 
    -- (Tienes que decir el nombre de un tipo de Pokémon y el programa te dirá que tipos son débiles a este)
    DBMS_OUTPUT.PUT_LINE ('----');

EXCEPTION -- Excepciones del prgrama por si ocurre algún error
    WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE ('Dato no encontrado');
    WHEN program_error THEN DBMS_OUTPUT.PUT_LINE('Error en la ejecución del programa');
    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('Error inesperado');
END;
/

-- Llamada función buscarEnLaPokedex
BEGIN
    DBMS_OUTPUT.PUT_LINE ('----');
    DBMS_OUTPUT.PUT_LINE ('Bienvenido/a al programa buscar en la Pokédex.');
   
    DBMS_OUTPUT.PUT_LINE(buscarEnLaPokedex('&DimeNombrePokemon')); 
    -- (Solo tienes que decir el nombre de un Pokémon que esté en la BBDD, te dirá todos los datos de este)
    DBMS_OUTPUT.PUT_LINE ('----');
    
EXCEPTION -- Excepciones del prgrama por si ocurre algún error
    WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE ('Dato no encontrado');
    WHEN program_error THEN DBMS_OUTPUT.PUT_LINE('Error en la ejecución del programa');
    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('Error inesperado. Compruebe que el nombre está correcto');
END;
/


-- BORRAR ----------------------------------------------------------------------

-- Tablas
DROP TABLE	POKEDEX	CASCADE CONSTRAINTS;
DROP TABLE	POKEMON	CASCADE CONSTRAINTS;
DROP TABLE	ATAQUES	CASCADE CONSTRAINTS;
DROP TABLE	TIPOS	CASCADE CONSTRAINTS;
DROP TABLE	REGION	CASCADE CONSTRAINTS;

-- Procedimientos y funciones
DROP PROCEDURE  registrarPokemon;
DROP PROCEDURE  deletePokemon;
DROP PROCEDURE  datosRegion;
DROP FUNCTION   tablaDeTiposSupereficaz;
DROP FUNCTION   buscarEnLaPokedex;