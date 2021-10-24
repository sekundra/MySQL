-- Оптимизация запросов
-- 1 Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs и products в таблицу logs 
-- помещается время и дата создания записи, название таблицы, идентификатор первичного ключа и содержимое поля name.
USE shop;
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
	id INT UNSIGNED NOT NULL COMMENT 'Идентификатор первичного ключа',
	created_at DATETIME DEFAULT NOW() COMMENT 'Дата и время создания записи',
	table_name VARCHAR(50) NOT NULL COMMENT 'Название таблицы',
	`name` VARCHAR(100) COMMENT 'Содержимое поля name исходной таблицы'
) ENGINE = Archive COMMENT 'Лог записи в таблицы shop';
-- общая процедура вставки
DROP PROCEDURE IF EXISTS insert_proc;
CREATE PROCEDURE insert_proc (IN id INT, created_at DATETIME, tab_name VARCHAR(50), `name` VARCHAR(100))
BEGIN
  INSERT INTO logs VALUES 
	(id, created_at, tab_name, `name`);
END;
-- триггер на вставку в users
DROP TRIGGER IF EXISTS users_insert;
CREATE TRIGGER users_insert AFTER INSERT ON users
FOR EACH ROW
BEGIN
	CALL insert_proc(NEW.id, NEW.created_at, 'users', NEW.name);
END;

INSERT INTO users (name, birthday_at) VALUES 
('Новый пользователь','1999-01-01');

SELECT * FROM logs;
-- триггер на вставку в products
DROP TRIGGER IF EXISTS products_insert;
CREATE TRIGGER products_insert AFTER INSERT ON products
FOR EACH ROW
BEGIN
	CALL insert_proc(NEW.id, NEW.created_at, 'products', NEW.name);
END;

INSERT INTO products (name) VALUES 
('Новый товар');

SELECT * FROM logs;
-- триггер на вставку в catalogs
DROP TRIGGER IF EXISTS catalogs_insert;
CREATE TRIGGER catalogs_insert AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
	CALL insert_proc(NEW.id, NOW(), 'catalogs', NEW.name);
END;

INSERT INTO catalogs (name) VALUES 
('Новый каталог');

SELECT * FROM logs;