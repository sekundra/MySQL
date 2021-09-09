DROP DATABASE vk;
CREATE DATABASE vk;

SHOW DATABASES;
-- для хранения стабильной информации
-- типы ограничений целостности:
-- тип данных
-- не пустые
-- уникальные
-- значение по умолчанию для атрибута
-- внешний ключ(ссылочная целостность)
USE VK;

CREATE TABLE users(
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Искусственный ключ',
	first_name VARCHAR(100) NOT NULL COMMENT 'Имя пользователя',
    last_name VARCHAR(100) NOT NULL COMMENT 'Фамилия пользователя',
    birthday DATE NOT NULL COMMENT 'Дата рождения',
    gender CHAR(1) NOT NULL COMMENT 'Пол',
    email VARCHAR(100) NOT NULL UNIQUE COMMENT 'Email пользователя', -- email + phone натуральный ключ
    phone VARCHAR(100) NOT NULL UNIQUE COMMENT 'Номер телефона пользователя',
    created_at DATETIME DEFAULT NOW() COMMENT 'Дата создания строки',
	updated_at DATETIME DEFAULT NOW() ON UPDATE NOW() COMMENT 'Дата обновления строки'
) COMMENT 'Таблица пользователей';

-- для хранения динамической информации, которая часто меняется
CREATE TABLE `profiles`(
	user_id INT UNSIGNED NOT NULL PRIMARY KEY COMMENT 'Идентификатор строки',
	city VARCHAR(100) NOT NULL COMMENT 'Город проживания',
    country VARCHAR(100) NOT NULL COMMENT 'Страна проживания',
    `status` VARCHAR(10) NOT NULL COMMENT 'Текущий статус',
    created_at DATETIME DEFAULT NOW() COMMENT 'Дата создания строки',
	updated_at DATETIME DEFAULT NOW() ON UPDATE NOW() COMMENT 'Дата обновления строки'
) COMMENT 'Таблица профилей';

ALTER TABLE `profiles` ADD CONSTRAINT porfiles_user_id FOREIGN KEY (user_id) REFERENCES users(id);

DROP TABLE friendship;
 CREATE TABLE friendship (
	user_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на инициатора дружеских отношений',
    friend_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на получателя запроса о дружбе',
    request_type_id INT UNSIGNED NOT NULL COMMENT 'Тип запроса',
    requested_at DATETIME NOT NULL COMMENT 'Время отправки приглашения',
    confirmed_at DATETIME COMMENT 'Время подтверждения приглашения',
    created_at  DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',    
    updated_at  DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время обновленния строки',
    PRIMARY KEY (user_id, friend_id) COMMENT 'Составной первичный ключ'
); 

ALTER TABLE friendship ADD CONSTRAINT friendship_user_id FOREIGN KEY (user_id) REFERENCES users(id); -- 1:n
ALTER TABLE friendship ADD CONSTRAINT friendship_friend_id FOREIGN KEY (friend_id) REFERENCES users(id); -- 1:n

-- Cвязи
-- 1. Через внешний ключ. Внешний ключ всегда связывает одно поле таблицы с другим полем другой таблицы. 1:1, 1:n
-- 2. Через таблицу связи n:n

-- Алгоритм
-- 1. Создаем первую широкую сущность (основная/основные сущности домменной области)
-- 2. Нормалируем исходные сущности
-- 3. Связываем сущности
-- 4. Определяем первичный ключ
-- 5. Создаем остальные ОЦ
-- 6. GO TO 1 (Пытаемся описать новый функционал в рамках существующих сущностей)

-- user_id, friend_id 
drop table friendship_request_types;
CREATE TABLE friendship_request_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  name VARCHAR(150) NOT NULL UNIQUE COMMENT "Название статуса",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"  
) COMMENT "Типы запроса на дружбы";

-- имя-таблицы_имя-поля
ALTER TABLE friendship ADD CONSTRAINT friendship_request_type_id FOREIGN KEY (request_type_id) REFERENCES friendship_request_types(id); 


CREATE TABLE communities (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор сроки",
  name VARCHAR(150) NOT NULL UNIQUE COMMENT "Название группы",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Группы";

CREATE TABLE communities_users (
  community_id INT UNSIGNED NOT NULL COMMENT "Ссылка на группу",
  user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя",
  PRIMARY KEY (community_id, user_id) COMMENT "Составной первичный ключ",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки", 
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Участники групп, связь между пользователями и группами";

ALTER TABLE communities_users ADD CONSTRAINT communities_community_id FOREIGN KEY (community_id) REFERENCES communities(id); 
ALTER TABLE communities_users ADD CONSTRAINT communities_user_id FOREIGN KEY (user_id) REFERENCES users(id); 

drop table messages;
CREATE TABLE messages (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  from_user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на отправителя сообщения",
  to_user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на получателя сообщения",
  body TEXT NOT NULL COMMENT "Текст сообщения",
  is_important BOOLEAN COMMENT "Признак важности",
  is_delivered BOOLEAN COMMENT "Признак доставки",
  created_at DATETIME DEFAULT NOW() COMMENT "Время создания строки",
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Сообщения";

ALTER TABLE messages ADD CONSTRAINT messages_from_user_id FOREIGN KEY (from_user_id) REFERENCES users(id); 
ALTER TABLE messages ADD CONSTRAINT messages_to_user_id FOREIGN KEY (to_user_id) REFERENCES users(id); 

CREATE TABLE media (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
	filename VARCHAR(255) NOT NULL COMMENT "Полный путь к файлу",
    media_type_id INT UNSIGNED NOT NULL COMMENT "Ссылка на тип файла",
    metadata JSON NOT NULL COMMENT "Метаданные файла (дополнительные параметры, переменного числа в вазисимости от типа файла)",
    user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя",
	created_at DATETIME DEFAULT NOW() COMMENT "Время создания строки",
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Медиафайлы";

CREATE TABLE media_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  name VARCHAR(255) NOT NULL UNIQUE COMMENT "Название типа",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Типы медиафайлов";

ALTER TABLE media ADD CONSTRAINT media_media_type_id FOREIGN KEY (media_type_id) REFERENCES media_types(id); 
ALTER TABLE media ADD CONSTRAINT media_user_id FOREIGN KEY (user_id) REFERENCES users(id);

-- ДЗ 4 таблицы с лайками для медиа, пользователей и постов и CRUD на предыдущие таблицы
ALTER TABLE users MODIFY gender ENUM('M', 'F') NOT NULL COMMENT 'Пол'; 
ALTER TABLE users MODIFY phone VARCHAR(12) NOT NULL UNIQUE COMMENT 'Номер телефона пользователя'; 
ALTER TABLE users ADD CONSTRAINT сheck_phone CHECK (REGEXP_LIKE(phone, '^\\+7[0-9]{10}$')) ; -- пользвательское правило
ALTER TABLE profiles MODIFY `status` ENUM('Online', 'Offline', 'Inactive') NOT NULL; 


CREATE TABLE media_likes (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  like_type VARCHAR(25) NOT NULL COMMENT "Тип лайка",
  media_id INT UNSIGNED NOT NULL COMMENT "Ссылка на медиа",
  user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя-автора лайка",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Лайки медиа";

ALTER TABLE media_likes ADD CONSTRAINT mlikes_user FOREIGN KEY (user_id) REFERENCES users(id);
ALTER TABLE media_likes ADD CONSTRAINT mlikes_media FOREIGN KEY (media_id) REFERENCES media(id); 

CREATE TABLE user_likes (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  like_type VARCHAR(25) NOT NULL COMMENT "Тип лайка",
  user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя, получившего лайк",
  author_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя - автора лайка",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Лайки пользователей";

ALTER TABLE user_likes ADD CONSTRAINT likes_user FOREIGN KEY (user_id) REFERENCES users(id);
ALTER TABLE user_likes ADD CONSTRAINT likes_author FOREIGN KEY (user_id) REFERENCES users(id); 

CREATE TABLE posts (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
	post_body TEXT NOT NULL COMMENT "Содержание поста",
    user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя - автора поста",
	created_at DATETIME DEFAULT NOW() COMMENT "Время создания строки",
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Посты";

ALTER TABLE posts ADD CONSTRAINT posts_user FOREIGN KEY (user_id) REFERENCES users(id);

CREATE TABLE post_likes (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  like_type VARCHAR(25) NOT NULL COMMENT "Тип лайка",
  post_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пост",
  user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя - автора лайка",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Лайки постов";

ALTER TABLE post_likes ADD CONSTRAINT plikes_user FOREIGN KEY (user_id) REFERENCES users(id);
ALTER TABLE post_likes ADD CONSTRAINT plikes_post FOREIGN KEY (post_id) REFERENCES posts(id); 

 -- изменение сгенерированных данных
UPDATE users SET phone = CONCAT('+7', 9000000000 + FLOOR(999999999 * RAND())) WHERE id < 200;

UPDATE messages SET
	from_user_id = FLOOR(1 + RAND() * 100),
    to_user_id = FLOOR(1 + RAND() * 100) 
     WHERE id < 200;
     
UPDATE media_types SET name = 'audio' WHERE id = 1;
UPDATE media_types SET name = 'image' WHERE id = 2;
UPDATE media_types SET name = 'video' WHERE id = 3;
UPDATE media_types SET name = 'gif' WHERE id = 4;
UPDATE media_types SET name = 'document' WHERE id = 5;

INSERT INTO media (filename, media_type_id, metadata, user_id) VALUE (
	CONCAT('https://www.some_server.com/some_directory/', SUBSTR(MD5(RAND()), 1, 10)),
    FLOOR(1 + RAND() * 5),
    '{}',
    FLOOR(1 + RAND() * 100)
);

UPDATE media SET filename = CONCAT_WS('.', filename, metadata -> "$.extension")
WHERE media_type_id = 1;

UPDATE media SET metadata = CONCAT('{"size" : ' , FLOOR(1 + RAND() * 1000000), ', "extension" : "png", "resolution" : "', CONCAT_WS('x', FLOOR(100 + RAND() * 1000), FLOOR(100 + RAND() * 1000)), '"}')
WHERE media_type_id = 2; 



