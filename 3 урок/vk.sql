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

 CREATE TABLE friendship (
	user_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на инициатора дружеских отношений',
    friend_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на получателя запроса о дружбе',
    request_type VARCHAR(10) COMMENT 'Тип запроса',
    requested_at DATETIME DEFAULT NOW() COMMENT 'Время отправки приглашения',
    confirmed_at DATETIME DEFAULT NOW() COMMENT 'Время подтверждения приглашения',
    created_at DATETIME DEFAULT NOW() COMMENT 'Дата создания строки',
	updated_at DATETIME DEFAULT NOW() ON UPDATE NOW() COMMENT 'Дата обновления строки',
    PRIMARY KEY (user_id, friend_id) COMMENT 'Составной первичный ключ'
)COMMENT 'Таблица друзей';

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

CREATE TABLE friendship_request_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор строки',
  `name` VARCHAR(150) NOT NULL UNIQUE COMMENT 'Название статуса',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки'  
) COMMENT 'Типы запроса на дружбы';


-- таблицы сообщетсв и сообщений (ДЗ-3)

CREATE TABLE community (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор строки',
  community_name VARCHAR(250) NOT NULL UNIQUE COMMENT 'Название сообщества',
  community_type VARCHAR(250) NOT NULL COMMENT 'Тип группы(публичная\закрытая)',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки'  
) COMMENT "Таблица сообществ";


 CREATE TABLE user_x_community (
  community_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на сообщество',
  user_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на пользователя, вступившего в сообщество',
  joined_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Время вступления пользователя в сообщество',
  PRIMARY KEY (user_id, community_id) COMMENT 'Составной первичный ключ'
) COMMENT "Таблица связи сообщество - пользователь";

ALTER TABLE user_x_community ADD CONSTRAINT uxc_user_id FOREIGN KEY (user_id) REFERENCES users(id);
ALTER TABLE user_x_community ADD CONSTRAINT uxc_community_id FOREIGN KEY (community_id) REFERENCES community(id); 

CREATE TABLE messages (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор сообщения',
  content VARCHAR(500) NOT NULL COMMENT 'Текст сообщения',
  sender_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на пользователя - отправителя сообщения',
  sent_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Время отправки(создания) сообщения' 
) COMMENT "Таблица сообщений";

ALTER TABLE messages ADD CONSTRAINT messages FOREIGN KEY (sender_id) REFERENCES users(id);

-- таблица свзяи сообщение - получатель, т.к. рассылка сообщения может быть на нескольких получателей
CREATE TABLE messages_x_recepient (
  message_id INT UNSIGNED NOT NULL COMMENT 'ссылка на идентификатор сообщения',
  recepient_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на пользователя - отправителя сообщения',
  `status` VARCHAR(10) NOT NULL COMMENT 'Текущий статус сообщения (отправлено\прочитано и т.д.)',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки - изменения статуса',
  PRIMARY KEY (message_id, recepient_id) COMMENT 'Составной первичный ключ'
) COMMENT "Таблица связи сообщение - получатель";

ALTER TABLE messages_x_recepient ADD CONSTRAINT mxr_message_id FOREIGN KEY (message_id) REFERENCES messages(id);
ALTER TABLE messages_x_recepient ADD CONSTRAINT mxr_recepient_id FOREIGN KEY (recepient_id) REFERENCES users(id); 


