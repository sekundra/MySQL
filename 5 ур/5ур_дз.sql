DROP DATABASE IF EXISTS shop;
CREATE DATABASE shop;
use shop;
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  `name` VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

INSERT INTO users (name, birthday_at) VALUES
  ('Геннадий', '1990-10-05'),
  ('Наталья', '1984-11-12'),
  ('Александр', '1985-05-20'),
  ('Сергей', '1988-02-14'),
  ('Иван', '1998-01-12'),
  ('Мария', '1992-08-29');
  
  DROP TABLE IF EXISTS catalogs;
  CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  `name` VARCHAR(255) COMMENT 'Название раздела',
  UNIQUE unique_name(name(10))
) COMMENT = 'Разделы интернет-магазина';

INSERT INTO catalogs VALUES
  (NULL, 'Процессоры'),
  (NULL, 'Материнские платы'),
  (NULL, 'Видеокарты'),
  (NULL, 'Жесткие диски'),
  (NULL, 'Оперативная память');
    
  -- дз 1: Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.
  UPDATE users SET created_at = NOW(), updated_at=NOW();
  -- дз 2:Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения в формате 20.10.2017 8:10. Необходимо преобразовать поля к типу DATETIME, сохранив введённые ранее значения.
TRUNCATE users;
ALTER TABLE users MODIFY created_at VARCHAR(20);
ALTER TABLE users MODIFY updated_at VARCHAR(20);
INSERT INTO users (name, birthday_at, created_at, updated_at) VALUES
  ('Геннадий', '1990-10-05','20.10.2017 8:10','20.10.2017 12:10'),
  ('Наталья', '1984-11-12','30.10.2014 8:10','20.10.2017 12:10'),
  ('Александр', '1985-05-20','01.10.2014 5:10','23.12.2017 12:10');
UPDATE users SET created_at = STR_TO_DATE(created_at,'%d.%m.%Y %h:%i'), updated_at = STR_TO_DATE(updated_at,'%d.%m.%Y %h:%i');
ALTER TABLE users MODIFY created_at DATETIME DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE users MODIFY updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
DESCRIBE users;

 /* дз 3:В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, если товар закончился и выше нуля, если на складе имеются запасы. 
 Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. Однако нулевые запасы должны выводиться в конце, после всех */
 CREATE TABLE storehouses_products (
  id SERIAL PRIMARY KEY,
  storehouse_id INT UNSIGNED,
  product_id INT UNSIGNED,
  `value` INT UNSIGNED COMMENT 'Запас товарной позиции на складе',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Запасы на складе';
INSERT INTO storehouses_products (id, storehouse_id, product_id, `value`) VALUES
  (NULL, 1, 1, 0),
  (NULL, 1, 2, 2500),
  (NULL, 2, 3, 0),
  (NULL, 2, 4, 30),
  (NULL, 1, 5, 500),
  (NULL, 1, 6, 1);

SELECT *
FROM storehouses_products
ORDER BY `value` = 0, `value`;

-- дз 4: Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. Месяцы заданы в виде списка английских названий (may, august)
INSERT INTO users (`name`, birthday_at) VALUES
   ('Сергей', '1988-02-14'),
  ('Иван', '1998-01-12'),
  ('Мария', '1992-08-29');
  
  SELECT *
  FROM users
  WHERE MONTHNAME(birthday_at) in ('may','august');
  
-- дз 5: Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке, заданном в списке IN
  SELECT *
  FROM catalogs
  WHERE id IN (5, 1, 2)
  ORDER BY FIELD(id,5,1,2);
  
-- дз 6 Подсчитайте средний возраст пользователей в таблице users
SELECT 
	ROUND(AVG(TIMESTAMPDIFF(YEAR, birthday_at, NOW()))) as Average_age
FROM users; 

-- дз 7 Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. Следует учесть, что необходимы дни недели текущего года, а не года рождения.
CREATE TABLE week_days (
   id INT UNSIGNED PRIMARY KEY,
   day_name VARCHAR(10) NOT NULL
) COMMENT 'Дни недели'
;
INSERT INTO week_days (id, day_name) VALUES
   (0, 'Mon'),
   (1, 'Tue'),
   (2, 'Wed'),
   (3, 'Thu'),
   (4, 'Fri'),
   (5, 'Sat'),
   (6, 'Sun');
SELECT 
   wd.day_name
  ,ifnull(av_bd.birthday_count,0) birthday_count
FROM week_days wd LEFT JOIN (SELECT
                                 WEEKDAY(DATE_ADD(birthday_at, INTERVAL YEAR(NOW()) - YEAR(birthday_at) YEAR)) wd_id
                                ,COUNT(*) birthday_count
                             FROM users
                             GROUP BY WEEKDAY(DATE_ADD(birthday_at, INTERVAL YEAR(NOW()) - YEAR(birthday_at) YEAR))
							) av_bd on 	av_bd.wd_id = wd.id
ORDER BY wd.id
;