-- дз 1 Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. 
-- С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи"
DROP DATABASE IF EXISTS sample;
CREATE DATABASE sample;
USE sample;

DROP FUNCTION IF EXISTS hello;

CREATE FUNCTION hello()
RETURNS VARCHAR(25) DETERMINISTIC
BEGIN
	DECLARE hello VARCHAR(25);
	IF (HOUR(NOW()) < 6)
		THEN SET hello = 'Доброй ночи';
	ELSEIF (HOUR(NOW()) < 12)
		THEN SET hello = 'Доброе утро';
	ELSEIF (HOUR(NOW()) < 18)
		THEN SET hello = 'Добрый день';
	ELSE
		SET hello = 'Добрый вечер';
	END IF;
RETURN hello;
END

SELECT hello();
SELECT HOUR(NOW());


-- дз 2 В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
-- Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. 
-- Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. При попытке присвоить полям NULL-значение необходимо отменить операцию.
USE sample;

CREATE TABLE IF EXISTS products (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название',
  description TEXT COMMENT 'Описание',
  price DECIMAL (11,2) COMMENT 'Цена',
  catalog_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_catalog_id (catalog_id)
) COMMENT = 'Товарные позиции';

INSERT INTO products
  (name, description, price, catalog_id)
VALUES
  ('AMD FX-8320', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 7120.00, 1),
  ('ASUS ROG MAXIMUS X HERO', 'Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX', 19310.00, 2),
  ('Gigabyte H310M S2H', 'Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX', 4790.00, 2),
  ('MSI B250M GAMING PRO', 'Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX', 5060.00, 2)
 ;
-- триггер с запретом на вставку данных
DROP TRIGGER IF EXISTS name_desc_insert_null;
CREATE TRIGGER name_desc_insert_null BEFORE INSERT ON products
FOR EACH ROW
BEGIN
	IF NEW.name IS NULL AND NEW.description IS NULL THEN 
  		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INSERT canceled. NAME & Description both are empty';
	END IF;
END;

INSERT INTO products
  (description, price, catalog_id)
VALUES
  ('xxx', 7120.00, 1)
 ;
INSERT INTO products
  (price, catalog_id)
VALUES
  (7120.00, 1)
 ;
-- триггер с запретом на обновление данных
DROP TRIGGER IF EXISTS name_desc_update_null;
CREATE TRIGGER name_desc_update_null BEFORE UPDATE ON products
FOR EACH ROW
BEGIN
	IF NEW.name IS NULL AND NEW.description IS NULL THEN 
  		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'UPDATE canceled. NAME & Description both are empty';
	END IF;
END;

UPDATE products SET name=NULL, description=NULL WHERE name = 'MSI B250M GAMING PRO';

-- дз 3 (по желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи. 
-- Числами Фибоначчи называется последовательность в которой число равно сумме двух предыдущих чисел. Вызов функции FIBONACCI(10) должен возвращать число 55.
USE sample;

DROP FUNCTION IF EXISTS FIBONACCI;

CREATE FUNCTION FIBONACCI(num INT)
RETURNS INT DETERMINISTIC
BEGIN
	DECLARE i, fib1, fib2, sm INT DEFAULT 0;
	IF num < 0 THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Calculation impossible. Parameter out of range';
	END IF;
		WHILE i <= num DO
			IF i <= 1 THEN
				 SET sm = i;
				 SET fib2 = 1;
				 SET i = i + 1;
			ELSE 
				 SET sm = fib1 + fib2;
				 SET fib1 = fib2;
				 SET fib2 = sm;
				 SET i = i + 1;
			END IF;
		END WHILE;
	RETURN sm;
END;

SELECT fibonacci(-1);









