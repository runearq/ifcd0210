#
# Prueba Objetiva Practica final - UF1845_3/  
# UF1845: ACCESO A DATOS EN APLICACIONES WEB DEL ENTORNO SERVIDOR
# EXAMEN PRACTICO: E4_UF1845
# RUNE BRITO NUÑEZ


#----------------------------------------
# Soluciones a los ejercicios propuestos: 
# ---------------------------------------

/* APARTADO #1 
--------------
 _____                            _             _                 ____  _____  
|_   _|                          | |           (_)               |  _ \|  __ \ 
  | |  _ __ ___  _ __   ___  _ __| |_ __ _  ___ _  ___  _ __     | |_) | |  | |
  | | | '_ ` _ \| '_ \ / _ \| '__| __/ _` |/ __| |/ _ \| '_ \    |  _ <| |  | |
 _| |_| | | | | | |_) | (_) | |  | || (_| | (__| | (_) | | | |   | |_) | |__| |
|_____|_| |_| |_| .__/ \___/|_|   \__\__,_|\___|_|\___/|_| |_|   |____/|_____/ 
                | |                                                        
                |_|              

Importacion de la base de datos salila dentro de Mysq (mariaDB)

Lo primero será importar la estructura, para lo cual teniendo el archivo “sakila-schema.sql” ubicado en C:/ */

SOURCE C:/sakila-schema.sql; 


/* luego impòrtar los datos de dicha tabla “sakila-schema.sql” ubicado en C:/ tambien */

SOURCE C:/sakila-data.sql;


/* APARTADO #1-B
----------------
  _____                     _                     _            _        _     _           
 / ____|                   (_)                   | |          | |      | |   | |          
| |     _ __ ___  __ _  ___ _  ___  _ __       __| | ___      | |_ __ _| |__ | | __ _ ___ 
| |    | '__/ _ \/ _` |/ __| |/ _ \| '_ \     / _` |/ _ \     | __/ _` | '_ \| |/ _` / __|
| |____| | |  __/ (_| | (__| | (_) | | | |   | (_| |  __/     | || (_| | |_) | | (_| \__ \
 \_____|_|  \___|\__,_|\___|_|\___/|_| |_|    \__,_|\___|      \__\__,_|_.__/|_|\__,_|___/

/* Creacion de una base de datos llamada artista_cd dentro de la base de datos de sakila
Se creo una tabla con sus campos y contenidos en dentro de la base de datos Sakila que 
lleva por nombre “Artistas_CD” y que lleva diversos campos campos para ser rellenados 
tales como: nombre, apellidos, agrupación, email, teléfono y país. */

 CREATE TABLE IF NO EXIST `artista_cd` ( `nombre` varchar(16) NOT NULL,
`Apellidos` varchar(30) NOT NULL,
`agrupacion` varchar(30) NOT NULL,
`email` varchar(255) DEFAULT NULL,
`télefono` varchar(32) NOT NULL,
`Pais` varchar(50) DEFAULT NULL ) 
ENGINE=InnoDB DEFAULT CHARSET=UTT-8


/* APARTADO #2 
--------------
  _____                      _ _            
 / ____|                    | | |           
| |     ___  _ __  ___ _   _| | |_ __ _ ___ 
| |    / _ \| '_ \/ __| | | | | __/ _` / __|
| |___| (_) | | | \__ \ |_| | | || (_| \__ \
 \_____\___/|_| |_|___/\__,_|_|\__\__,_|___/    

2.1  Consultas de tipo simple  

# Esta sentencia fue para generar todos los datos y campos de una tabla; en este caso "actor" */

SELECT * FROM actor;


# Esta sentencia fue para generar los datos y campos especificos de una tabla; tambien en la tabla "actor" 

SELECT first_name,last_name, last_update FROM actor;


# Esta sentencia fue para generar una consulta que muestra los clientes que estan están en la tabla rental 

SELECT rental.rental_id,customer.first_name,
customer.last_name,rental.rental_date,rental.return_date
FROM rental
INNER JOIN customer
ON rental.customer_id=customer.customer_id


# Esta sentencia fue para generar los apellidos de los actores y la cantidad de actores que tienen ese 
# apellido,  pero solo para nombres compartidos por al menos dos actores. 

SELECT last_name, COUNT(*)
FROM actor
GROUP BY 1
HAVING COUNT(*) >= 2

# Esta sentencia fue para generar una consulta en SQL para enumerar todas las películas de paises que exceptuando
# en el Reino Unido

SELECT mov_title, mov_year, mov_time, 
mov_dt_rel AS Date_of_Release, 
mov_rel_country AS Releasing_Country
FROM movie
WHERE mov_rel_country<>'UK';


#  Esta sentencia junto al comando LEFT OUTHER JOINT, se utilizo para la consulta de nombres y apellidos, 
#  así como la dirección de cada miembro del personal y nombre del personal del staff. 

SELECT s.first_name, s.last_name, a.address
FROM staff s LEFT OUTER JOIN address a ON s.address_id = a.address_id;


#  Esta sentencia junto al comando INNER JOINT fue para generar una consulta 
#  que muestra los clientes que estan están en la tabla rental.

SELECT rental.rental_id,customer.first_name,
customer.last_name,rental.rental_date,rental.return_date
FROM rental
INNER JOIN customer
ON rental.customer_id=customer.customer_id

/* Para este ejercicio Se utilizaron un par de consultas “Joint”, para  ello se tomó como ejemplo de la 
vida real dentro de Sakila y por ende de una tienda de DVD, la cuales pueden  producir una lista diaria 
de alquileres vencidos para que los clientes puedan ser contactados y pedirles que devuelvan sus DVD 
vencidos. Para esta consulta  se buscaron  películas en la tabla de alquiler con una fecha de retorno 
NULL y donde la fecha de alquiler sea más antigua que la duración del alquiler especificada en la tabla 
de películas. Con ello, si la película está vencida, muestra el nombre de la película junto con el nombre
 del cliente y su número de teléfono. */


SELECT CONCAT (customer.last_name,', ',customer.first_name)AScustomer,
address.phone, film.title
FROM rental INNERJOIN customer
ON rental.customer_id=customer.customer_id
INNER JOIN addressONcustomer.address_id=address.address_id
INNER JOIN inventoryONrental.inventory_id=inventory.inventory_id
INNER JOIN film ONinventory.film_id=film.film_id
WHERE rental.return_dateI SNULL
AND rental_date + INTERVALfilm.rental_duration DAY < CURRENT_DATE ()
LIMIT5;


/* Esta sentencia fue para generar la mejor pelicula de misterio calificada e informando el título, el año y la calificación. */

SELECT mov_title, mov_year, rev_stars
FROM movie 
NATURAL JOIN movie_genres 
NATURAL JOIN genres 
NATURAL JOIN rating
WHERE gen_title = 'Mystery' AND rev_stars >= ALL (
SELECT rev_stars
FROM rating 
NATURAL JOIN movie_genres 
NATURAL JOIN genres
WHERE gen_title = 'Mystery');



/* APARTADO #3 
-------------- 
__      ___     _            
\ \    / (_)   | |           
 \ \  / / _ ___| |_ __ _ ___ 
  \ \/ / | / __| __/ _` / __|
   \  /  | \__ \ || (_| \__ \
    \/   |_|___/\__\__,_|___/ 

Con ésta sentencia se obtuvo una vista con los datos de films cuyos nombres empiezan por un o una protagonista;
para este caso Jonh.  */

CREATE VIEW john AS
SELECT first_name as nombre, last_name as apellido, actor_id as id
FROM actor
WHERE first_name = 'John';


/* Esta sentencia se para generar una vista para ver los cinco primeros géneros que ocupàn los mayores ingresos en la tienda. */


CREATE VIEW top_5  as 
SELECT c.name as 'Film', sum(p.amount) as 'Gross Revenue'
from category as c
join film_category as fc on fc.category_id = c.category_id
join inventory as i on i.film_id = fc.film_id
join rental as r on r.inventory_id = i.inventory_id
join payment as p on p.rental_id = r.rental_id
group by c.name
order by sum(p.amount) desc
limit 5;


/* APARTADO #4 
--------------
 _        _                           
| |      (_)                          
| |_ _ __ _  __ _  __ _  ___ _ __ ___ 
| __| '__| |/ _` |/ _` |/ _ \ '__/ __|
| |_| |  | | (_| | (_| |  __/ |  \__ \
 \__|_|  |_|\__, |\__, |\___|_|  |___/
             __/ | __/ |              
            |___/ |___/                 

Disparadores (trigger) 


Trigger para insertar una oferta de 7.50$ cuando el DVD tenga un precio de 10$ 
*/


CREATE DEFINER=`root`@`localhost` TRIGGER `sakila`.`payment_BEFORE_INSERT` 
BEFORE INSERT ON `payment` FOR EACH ROW
BEGIN
if NEW.amount>=10 then
set NEW.amount=7.50;
end if;
END


/* Disparadores (trigger) para generar una actualizacion de pago por el alquler de cada dvd */

CREATE DEFINER=`root`@`localhost` TRIGGER `sakila`.`payment_BEFORE_UPDATE` BEFORE UPDATE ON `payment` FOR EACH ROW
BEGIN
if NEW.amount > OLD.amount then
set NEW.amount=OLD.amount;
end if;

END


 /* APARTADO #5 
---------------    
  __                  _                       
 / _|                (_)                      
| |_ _   _ _ __   ___ _  ___  _ __   ___  ___ 
|  _| | | | '_ \ / __| |/ _ \| '_ \ / _ \/ __|
| | | |_| | | | | (__| | (_) | | | |  __/\__ \
|_|  \__,_|_| |_|\___|_|\___/|_| |_|\___||___/ 

/* Esta función devuelve el customer_id del cliente que actualmente alquila el artículo, o NULL si el artículo está en stock.
donde p_inventory_id: es el ID o numero entre () del artículo de inventario que se debe verificar. */

SELECT inventory_held_by_customer(9);


/* APARTADO #6 
--------------
 _____                        _ _           _            _            
|  __ \                      | (_)         (_)          | |           
| |__) | __ ___   ___ ___  __| |_ _ __ ___  _  ___ _ __ | |_ ___  ___ 
|  ___/ '__/ _ \ / __/ _ \/ _` | | '_ ` _ \| |/ _ \ '_ \| __/ _ \/ __|
| |   | | | (_) | (_|  __/ (_| | | | | | | | |  __/ | | | || (_) \__ \
|_|   |_|  \___/ \___\___|\__,_|_|_| |_| |_|_|\___|_| |_|\__\___/|___/ 

/* Este procedimiento produce una tabla de números de ID de inventario para las copias de la película
en stock y devuelve (en el parámetro p_film_count) un recuento que indica el número de filas en esa tabla. */

CALL film_in_stock(1,1,@count);


/* Procedimiento que aumenta en una semana la fecha de entrega de la película alquilada (rental) 
y que el precio del alquiler aumente en 0,25$. */

UPDATE sakila.rental 
SET rental.return_date = DATE_ADD(rental.return_date, INTERVAL 7 DAY); 
UPDATE sakila.payment 
SET payment.amount = payment.amount + 0.5; 


/* La función inventory_held_by_customer devuelve el customer_id del cliente que ha alquilado el artículo de inventario especificado. */

BEGIN
  DECLARE v_customer_id INT;
  DECLARE EXIT HANDLER FOR NOT FOUND RETURN NULL;
  SELECT customer_id INTO v_customer_id
  FROM rental
  WHERE return_date IS NULL
  AND inventory_id = p_inventory_id;
  RETURN v_customer_id;
END




































