-- дз 1 Создайте двух пользователей которые имеют доступ к базе данных shop. 
-- Первому пользователю shop_read должны быть доступны только запросы на чтение данных, второму пользователю shop — любые операции в пределах базы данных shop.
DROP DATABASE IF EXISTS shop;
CREATE DATABASE shop;
USE shop;
DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название раздела',
  UNIQUE unique_name(name(10))
) COMMENT = 'Разделы интернет-магазина';

INSERT INTO catalogs VALUES
  (NULL, 'Процессоры'),
  (NULL, 'Материнские платы'),
  (NULL, 'Видеокарты'),
  (NULL, 'Жесткие диски'),
  (NULL, 'Оперативная память');

CREATE USER shop_read;
GRANT SELECT ON shop.* TO shop_read;
CREATE USER shop;
GRANT ALL ON shop.* TO shop;
-- дз 2 (по желанию) Пусть имеется таблица accounts содержащая три столбца id, name, password, содержащие первичный ключ, имя пользователя и его пароль. 
-- Создайте представление username таблицы accounts, предоставляющий доступ к столбца id и name. 
-- Создайте пользователя user_read, который бы не имел доступа к таблице accounts, однако, мог бы извлекать записи из представления username.
USE shop;
DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (
  id SERIAL PRIMARY KEY,
  `name` VARCHAR(255) COMMENT 'Имя пользователя',
  `password` VARCHAR(255) COMMENT 'Пароль'
) COMMENT = 'Учетные записи';
INSERT INTO accounts (`name`,`password`) VALUES
  ('Иван Иванов', '12345'),
  ('Николай Петров', 'йцуккк'),
  ('Петр Сидоров', 'qwerty');
  
CREATE OR REPLACE VIEW part_accounts AS  
  SELECT 
	 id
	,`name`
  FROM accounts
 ;
 CREATE USER user_read;
 GRANT SELECT ON shop.part_accounts TO user_read;
 
  