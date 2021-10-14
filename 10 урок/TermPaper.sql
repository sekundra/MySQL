-- Создание БД для booking.com - ресруса для поиска и бронирования жилья по всему миру.
-- 1. Описание БД 
/*
БД должна обеспечивать хранение инфрмации об объектах бронирования, их владельцах, месте расположения, доступных местах размещения, удобствах,
отзывах и оценках объектов размещения, полученных от арендаторов.
Также БД хранит информацию об арендаторах, их статусе в программе лояльности, истории бронирования и фактического проживания.
*/
-- 2.  Создание БД и таблиц
DROP DATABASE IF EXISTS booking_db;
CREATE DATABASE booking_db;
USE booking_db;

CREATE TABLE owners (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Искусственный ключ',
	first_name VARCHAR(50) NOT NULL COMMENT 'Имя владельца',
    middle_name VARCHAR(50) COMMENT 'Отчество владельца',
    last_name VARCHAR(50) NOT NULL COMMENT 'Отчество владельца',
    email VARCHAR(100) NOT NULL UNIQUE COMMENT 'Email владельца',
    phone VARCHAR(100) NOT NULL UNIQUE COMMENT 'Номер телефона владельца',
    created_at DATETIME DEFAULT NOW() COMMENT 'Дата создания строки',
	updated_at DATETIME DEFAULT NOW() ON UPDATE NOW() COMMENT 'Дата обновления строки'
) COMMENT 'Таблица владельцев объектов';

CREATE TABLE object_type (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Искусственный ключ',
	type_name VARCHAR(100) NOT NULL COMMENT 'Название типа объекта размещения (гостиница, дом, хостел и т.д.)',
    created_at DATETIME DEFAULT NOW() COMMENT 'Дата создания строки',
	updated_at DATETIME DEFAULT NOW() ON UPDATE NOW() COMMENT 'Дата обновления строки'
) COMMENT 'Таблица типов объектов размещения';

CREATE TABLE objects (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Искусственный ключ',
	object_name VARCHAR(100) NOT NULL COMMENT 'Название объекта размещения',
    description TEXT NOT NULL COMMENT 'Описание объекта',
    GPS_lattitude FLOAT NOT NULL COMMENT 'Широта расположения объекта в десятичном выражении',
    GPS_longitude FLOAT NOT NULL COMMENT 'Широта расположения объекта в десятичном выражении',
    country VARCHAR(100) NOT NULL COMMENT 'Страна объекта размещения',
    city VARCHAR(100) NOT NULL COMMENT 'Город объекта размещения',
    type_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на справочник типов объектов',
    owner_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на владельца объекта',
    created_at DATETIME DEFAULT NOW() COMMENT 'Дата создания строки',
	updated_at DATETIME DEFAULT NOW() ON UPDATE NOW() COMMENT 'Дата обновления строки'
) COMMENT 'Таблица объектов размещения';

-- ограничения ссылочной целостности для таблица объектов размещения
ALTER TABLE objects ADD CONSTRAINT objects_type_id FOREIGN KEY (type_id) REFERENCES object_type(id);
ALTER TABLE objects ADD CONSTRAINT objects_owner_id FOREIGN KEY (owner_id) REFERENCES owners(id);

CREATE TABLE places (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Искусственный ключ',
	place_name VARCHAR(100) NOT NULL COMMENT 'Название места размещения в объекте - комната в доме, номер в отеле и т.д.',
    description TEXT NOT NULL COMMENT 'Описание места размещения',
    object_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на объект размещения',
    capacity INT UNSIGNED NOT NULL COMMENT 'Вместимость места размещения (кол-во спальных мест)',
    created_at DATETIME DEFAULT NOW() COMMENT 'Дата создания строки',
	updated_at DATETIME DEFAULT NOW() ON UPDATE NOW() COMMENT 'Дата обновления строки'
) COMMENT 'Таблица мест размещения внутри объектов';

-- ограничения ссылочной целостности для таблицы мест размещения
ALTER TABLE places ADD CONSTRAINT places_object_id FOREIGN KEY (object_id) REFERENCES objects(id);

CREATE TABLE currency_type (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Искусственный ключ',
	currency_name VARCHAR(100) NOT NULL COMMENT 'Название валюты',
	сurrency_code VARCHAR(10) NOT NULL COMMENT 'Универсальный код валюты (EUR,USD)',
    created_at DATETIME DEFAULT NOW() COMMENT 'Дата создания строки',
	updated_at DATETIME DEFAULT NOW() ON UPDATE NOW() COMMENT 'Дата обновления строки'
) COMMENT 'Таблица валют';


CREATE TABLE price_type (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Искусственный ключ',
	price_name VARCHAR(25) NOT NULL COMMENT 'Название типа цены - гость\место',
    created_at DATETIME DEFAULT NOW() COMMENT 'Дата создания строки',
	updated_at DATETIME DEFAULT NOW() ON UPDATE NOW() COMMENT 'Дата обновления строки'
) COMMENT 'Таблица типов цен';

CREATE TABLE prices (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Искусственный ключ',
	price FLOAT NOT NULL COMMENT 'Цена места размещения',
    currency_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на валюту',
    place_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на место размещения',
    type_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на тип цены (за гостя\за место целиком)',
    effective_from DATETIME NOT NULL COMMENT 'Дата начала действия цены',
    effective_to DATETIME NOT NULL COMMENT 'Дата окончания действия цены',
    created_at DATETIME DEFAULT NOW() COMMENT 'Дата создания строки',
	updated_at DATETIME DEFAULT NOW() ON UPDATE NOW() COMMENT 'Дата обновления строки'
) COMMENT 'Таблица цен за место размещения внутри объекта';


-- ограничения ссылочной целостности для таблицы цен
ALTER TABLE prices ADD CONSTRAINT prices_place_id FOREIGN KEY (place_id) REFERENCES places(id);
ALTER TABLE prices ADD CONSTRAINT prices_type_id FOREIGN KEY (type_id) REFERENCES price_type(id);
ALTER TABLE prices ADD CONSTRAINT prices_curr_id FOREIGN KEY (currency_id) REFERENCES currency_type(id);

CREATE TABLE utilities (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Искусственный ключ',
	utility_name VARCHAR(25) NOT NULL COMMENT 'Название удобства (кондиционер, белье, холодильник и т.д.)',
    created_at DATETIME DEFAULT NOW() COMMENT 'Дата создания строки',
	updated_at DATETIME DEFAULT NOW() ON UPDATE NOW() COMMENT 'Дата обновления строки'
) COMMENT 'Таблица типов удобств в местах размещения';

CREATE TABLE place_x_utility (
	place_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на место размещения',
	utility_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на удобство',
	created_at DATETIME DEFAULT NOW() COMMENT 'Дата создания строки',
	updated_at DATETIME DEFAULT NOW() ON UPDATE NOW() COMMENT 'Дата обновления строки',
	PRIMARY KEY (place_id, utility_id) COMMENT 'Составной первичный ключ'
) COMMENT 'Таблица связи мест размещения и удобств в них';

-- ограничения ссылочной целостности для таблицы связи мест и удобств
ALTER TABLE place_x_utility ADD CONSTRAINT place_x_utility_place_id FOREIGN KEY (place_id) REFERENCES places(id);
ALTER TABLE place_x_utility ADD CONSTRAINT place_x_utility_utility_id FOREIGN KEY (utility_id) REFERENCES utilities(id);

CREATE TABLE target_types (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Искусственный ключ',
	target_name VARCHAR(50) NOT NULL COMMENT 'Ссылка на объект фото (объект размещения или место размещения)',
	created_at DATETIME DEFAULT NOW() COMMENT 'Дата создания строки',
	updated_at DATETIME DEFAULT NOW() ON UPDATE NOW() COMMENT 'Дата обновления строки'
) COMMENT 'Таблица видов объектов для привязки фото (сам обект размещения или место размещения внутри объекта)';


CREATE TABLE pictures (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Искусственный ключ',
	target_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на объект фото (объект размещения или место размещения)',
	target_type_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на вид объекта фото (объект размещения или место размещения)',
	pic_url VARCHAR(100) NOT NULL COMMENT 'Ссылка на размещение фото',
	created_at DATETIME DEFAULT NOW() COMMENT 'Дата создания строки',
	updated_at DATETIME DEFAULT NOW() ON UPDATE NOW() COMMENT 'Дата обновления строки'
) COMMENT 'Таблица с фото объектов и мест размещения';

-- ограничения ссылочной целостности для таблицы фото
ALTER TABLE pictures ADD CONSTRAINT pictures_target_type FOREIGN KEY (target_type_id) REFERENCES target_types(id);

CREATE TABLE user_status (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Искусственный ключ',
	status_name VARCHAR(25) NOT NULL COMMENT 'Статус лояльности',
    created_at DATETIME DEFAULT NOW() COMMENT 'Дата создания строки',
	updated_at DATETIME DEFAULT NOW() ON UPDATE NOW() COMMENT 'Дата обновления строки'
) COMMENT 'Таблица статусов арендатора в программе лояльности';


CREATE TABLE users (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Искусственный ключ',
	first_name VARCHAR(50) NOT NULL COMMENT 'Имя арендатора',
    middle_name VARCHAR(50) COMMENT 'Отчество арендатора',
    last_name VARCHAR(50) NOT NULL COMMENT 'Отчество арендатора',
    email VARCHAR(100) NOT NULL UNIQUE COMMENT 'Email арендатора',
    phone VARCHAR(100) NOT NULL UNIQUE COMMENT 'Номер телефона арендатора',
    gender VARCHAR(10) NOT NULL COMMENT 'Пол арендатора',
    birth_dt DATE NOT NULL COMMENT 'Дата рождения арендатора',
    country VARCHAR(100) NOT NULL COMMENT 'Страна местонахождения арендатора',
    status_id INT UNSIGNED NOT NULL COMMENT 'Ссылка статус арендатора',
    created_at DATETIME DEFAULT NOW() COMMENT 'Дата создания строки',
	updated_at DATETIME DEFAULT NOW() ON UPDATE NOW() COMMENT 'Дата обновления строки'
) COMMENT 'Таблица арендаторов';

-- ограничения ссылочной целостности для таблицы арендаторов
ALTER TABLE users ADD CONSTRAINT user_status FOREIGN KEY (status_id) REFERENCES user_status(id);

CREATE TABLE booking_status (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Искусственный ключ',
	status_name VARCHAR(25) NOT NULL COMMENT 'Статус бронирования - бронь\заезд\не заезд',
    created_at DATETIME DEFAULT NOW() COMMENT 'Дата создания строки',
	updated_at DATETIME DEFAULT NOW() ON UPDATE NOW() COMMENT 'Дата обновления строки'
) COMMENT 'Таблица статусов бронирования';

CREATE TABLE booking_types (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Искусственный ключ',
	type_name VARCHAR(25) NOT NULL COMMENT 'Тип бронирования - отдых\командировка',
    created_at DATETIME DEFAULT NOW() COMMENT 'Дата создания строки',
	updated_at DATETIME DEFAULT NOW() ON UPDATE NOW() COMMENT 'Дата обновления строки'
) COMMENT 'Таблица типов бронирования';

CREATE TABLE booking_history (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Искусственный ключ',
    place_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на место размещения',
    effective_from DATETIME NOT NULL COMMENT 'Дата начала брони',
    effective_to DATETIME NOT NULL COMMENT 'Дата окончания брони',
    user_id INT UNSIGNED NOT NULL COMMENT 'Ссылка арендатора',
    status_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на статус брони',
    type_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на тип брони',
 	created_at DATETIME DEFAULT NOW() COMMENT 'Дата создания строки',
	updated_at DATETIME DEFAULT NOW() ON UPDATE NOW() COMMENT 'Дата обновления строки'
) COMMENT 'Таблица с периодами брони на места проживания';

-- ограничения ссылочной целостности для таблицы бронирования
ALTER TABLE booking_history ADD CONSTRAINT booking_history_user FOREIGN KEY (user_id) REFERENCES users(id);
ALTER TABLE booking_history ADD CONSTRAINT booking_history_status FOREIGN KEY (status_id) REFERENCES booking_status(id);
ALTER TABLE booking_history ADD CONSTRAINT booking_history_type FOREIGN KEY (type_id) REFERENCES booking_types(id);

CREATE TABLE place_review (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Искусственный ключ',
	booking_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на бронь',
    body TEXT NOT NULL COMMENT 'Текст отзыва',
 	created_at DATETIME DEFAULT NOW() COMMENT 'Дата создания строки',
	updated_at DATETIME DEFAULT NOW() ON UPDATE NOW() COMMENT 'Дата обновления строки'
) COMMENT 'Таблица с отзывами арендаторов';

-- ограничения ссылочной целостности для таблицы отзывов
ALTER TABLE place_review ADD CONSTRAINT place_review_booking FOREIGN KEY (booking_id) REFERENCES booking_history(id);

CREATE TABLE rates (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Искусственный ключ',
	rating_name VARCHAR(25) NOT NULL COMMENT 'Оценка',
    created_at DATETIME DEFAULT NOW() COMMENT 'Дата создания строки',
	updated_at DATETIME DEFAULT NOW() ON UPDATE NOW() COMMENT 'Дата обновления строки'
) COMMENT 'Таблица видов оценок';

CREATE TABLE parametrs (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Искусственный ключ',
	parametr_name VARCHAR(25) NOT NULL COMMENT 'Оцениваемая характеристика',
    created_at DATETIME DEFAULT NOW() COMMENT 'Дата создания строки',
	updated_at DATETIME DEFAULT NOW() ON UPDATE NOW() COMMENT 'Дата обновления строки'
) COMMENT 'Таблица оцениваемых характеристик';

CREATE TABLE place_rating (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Искусственный ключ',
	booking_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на бронь',
	rate_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на оценку',
    parametr_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на оцениваемую характеристику',
 	created_at DATETIME DEFAULT NOW() COMMENT 'Дата создания строки',
	updated_at DATETIME DEFAULT NOW() ON UPDATE NOW() COMMENT 'Дата обновления строки'
) COMMENT 'Таблица с оценками арендаторов';

-- ограничения ссылочной целостности для таблицы оценок
ALTER TABLE place_rating ADD CONSTRAINT place_rating_booking FOREIGN KEY (booking_id) REFERENCES booking_history(id);
ALTER TABLE place_rating ADD CONSTRAINT place_rating_rate FOREIGN KEY (rate_id) REFERENCES rates(id);
ALTER TABLE place_rating ADD CONSTRAINT place_rating_parametr FOREIGN KEY (parametr_id) REFERENCES parametrs(id);

-- 3 Наполнение БД - основная часть наполнения выполнена на внешнем сервисе fill_db, в раздел включено наполнение таблиц, в которых д.б. осмысленные данны (справочники и т.д.)
INSERT INTO currency_type (currency_name, сurrency_code) VALUES 
('Российский рубль','RUR'),
('Доллар США','USD'),
('Евро','EUR');

INSERT INTO object_type (type_name) VALUES 
('Квартира'),
('Хостел'),
('Гостиница'),
('Гостевой дом');

INSERT INTO price_type (price_name) VALUES 
('За гостя'),
('За место размещения');

INSERT INTO utilities (utility_name) VALUES 
('Ванна'),
('Кондиционер'),
('Фен'),
('Холодильник'),
('Москитные сетки'),
('Wi-Fi')
;

INSERT INTO target_types (target_name) VALUES 
('Объект размещения'),
('Место размещения');

INSERT INTO user_status (status_name) VALUES 
('Genius10'),
('Genius15'),
('Обычный');


INSERT INTO booking_status (status_name) VALUES 
('Бронь'),
('Заселение'),
('Отмена'),
('Незаезд')
;

INSERT INTO booking_types (type_name) VALUES 
('Отдых'),
('Командировка')
;

INSERT INTO parametrs (parametr_name) VALUES 
('Чистота'),
('Близость к центру'),
('Удобная кровать'),
('Хозяева'),
('Тишина')
;





