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
	booking_id INT UNSIGNED UNIQUE NOT NULL COMMENT 'Ссылка на бронь',
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

-- 3 Наполнение БД - частично использован сервис автонаполнения БД с корректировкой полей, которые должны иметь осмысленные значения
INSERT INTO currency_type (currency_name, сurrency_code) VALUES 
('Российский рубль','RUR'),
('Доллар США','USD'),
('Евро','EUR')
;

INSERT INTO object_type (type_name) VALUES 
('Квартира'),
('Хостел'),
('Гостиница'),
('Гостевой дом')
;

INSERT INTO price_type (price_name) VALUES 
('За гостя'),
('За место размещения')
;

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
('Место размещения')
;

INSERT INTO user_status (status_name) VALUES 
('Genius10'),
('Genius15'),
('Обычный')
;

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
INSERT INTO owners VALUES 
(1,'Clare','omnis','Maggio','murphy.flatley@example.org','+90(2)5401629236','1989-08-28 16:55:03','2001-11-03 13:25:58'),
(2,'Eusebio','quia','Ritchie','brady.stoltenberg@example.com','338-080-4975','2016-05-05 23:17:16','1983-11-26 02:03:27'),
(3,'Billie','voluptatum','Nader','brent03@example.org','(974)241-0584','1981-12-01 17:06:25','2003-05-29 18:34:33'),
(4,'Ricky','minima','O\'Conner','don42@example.org','1-159-733-0445x456','2003-03-06 22:45:43','1985-05-03 02:07:21'),
(5,'Chaim','et','Lebsack','electa.lang@example.com','(054)270-6971x9344','1974-01-20 01:11:53','2020-09-22 22:02:27'),
(6,'Janet','doloremque','Auer','runte.delaney@example.com','573-763-3277x4204','1998-03-14 23:48:54','1983-07-29 04:21:44'),
(7,'Reta','quis','White','zdouglas@example.com','+69(7)3589540000','1979-04-25 11:59:33','1992-11-18 17:22:00'),
(8,'Koby','explicabo','Hand','auer.concepcion@example.com','(037)975-1030','1997-07-13 01:20:38','2003-08-18 22:14:29'),
(9,'Anya','quis','Lockman','reinger.myriam@example.net','07134225578','2011-09-05 14:01:26','2005-03-20 11:43:34'),
(10,'Gaylord','expedita','West','shaina.wiza@example.net','801-302-9179','2014-11-09 07:26:14','1975-06-04 16:38:27');

-- приводим номера телефонам к формату
UPDATE owners SET phone = CONCAT('+7', 9000000000 + FLOOR(999999999 * RAND()));
-- ограничение на формат номера телефона
ALTER TABLE owners ADD CONSTRAINT сheck_phone CHECK (REGEXP_LIKE(phone, '^\\+7[0-9]{10}$')) ;

INSERT INTO objects VALUES 
(1,'ex','Omnis id eaque voluptatum autem dolores quo et. Eum voluptatum laborum eaque. Rem iusto culpa perferendis sapiente eligendi inventore nulla.',0,0,'886227900','Port Kamronland',1,1,'1984-06-13 02:41:20','2007-02-19 02:34:00'),
(2,'quibusdam','Perspiciatis praesentium iure nihil odit ea praesentium qui nihil. Molestias vel deleniti ad dolorum. Veritatis aspernatur aliquam autem et. Deleniti in possimus tenetur quas.',0,0,'6212','Bertramville',1,1,'1974-07-29 18:44:48','1998-12-18 01:24:54'),
(3,'voluptates','Et doloremque qui eos quas eos. Quos odit est qui harum omnis ut voluptatum. Cumque deleniti placeat ducimus eligendi. Voluptas maxime sit est facilis dolorum.',0,0,'','Lake Kenstad',1,1,'1991-08-13 13:40:44','2015-08-27 20:02:38'),
(4,'expedita','Eum incidunt autem velit repudiandae aliquid optio vitae hic. Qui sunt quos quo quas.',0,0,'','Port Jon',1,1,'1973-12-20 21:30:04','1988-01-28 00:24:09'),
(5,'maxime','Itaque praesentium quas occaecati vel rerum blanditiis. Debitis et magnam et voluptatem. Explicabo sequi non mollitia neque veritatis maiores.',0,0,'234331273','New Heathershire',1,1,'2003-07-05 02:25:39','2016-01-08 20:16:25'),
(6,'aut','Consequatur impedit placeat qui iste ut minima et consequatur. Dolor earum autem numquam rerum dolore accusamus. Sit atque optio quis et dolor id. Optio numquam maiores cum nemo alias assumenda tenetur.',0,0,'','Port Ari',1,1,'2007-12-19 14:10:02','1984-08-22 23:03:36'),
(7,'non','Sapiente sunt aut in ratione impedit qui et numquam. Qui adipisci molestiae voluptatum minus voluptas omnis odit. Cumque ipsum modi perferendis possimus et. Iure ut eaque sed corporis.',0,0,'1','New Angelitaview',1,1,'1995-10-26 16:25:37','1984-01-01 02:34:06'),
(8,'aliquid','Aut repudiandae ullam accusantium tempora amet laboriosam qui quo. Molestias dolores recusandae et quae deleniti rerum. Aut et unde et quia.',0,0,'','Jedediahside',8,8,'1975-09-09 22:45:30','2013-09-26 04:54:33'),
(9,'dolor','Dolores perferendis officia ut sit. Consequuntur sit fugiat voluptas.',0,0,'46','Robelmouth',1,1,'1990-01-03 19:07:37','1976-08-04 03:10:59'),
(10,'magni','Quam dolor quos aut doloribus accusantium nulla quia. Pariatur tenetur fugiat quia. Ex culpa enim maxime possimus dolores sed et. Quos doloremque repellendus et omnis sed temporibus.',0,0,'650','Port Sabina',1,1,'1984-01-20 04:15:58','2004-08-15 17:41:10');

UPDATE objects SET type_id = FLOOR(1 + RAND() * (4 - 1 + 1));
UPDATE objects SET owner_id = FLOOR(5 + RAND() * (10 - 5 + 1));
UPDATE objects SET gps_lattitude = (100 + RAND() * (100 - 1 + 1))/10;
UPDATE objects SET gps_longitude = (100 + RAND() * (100 - 1 + 1))/10;
UPDATE objects SET country = 'USA' WHERE id IN (1,2,3);
UPDATE objects SET country = 'RUSSIA' WHERE id IN (5,6,7,10);
UPDATE objects SET country = 'GERMANY' WHERE country NOT IN ('RUSSIA','USA');
UPDATE objects SET city = 'New York' WHERE country = 'USA';
UPDATE objects SET city = 'Moscow' WHERE country = 'RUSSIA';
UPDATE objects SET city = 'Berlin' WHERE country = 'GERMANY';

INSERT INTO places VALUES 
(1,'комната','Ex eos tenetur ullam modi commodi eligendi. Qui quaerat quasi vero in sed consequatur. Aut ut qui molestiae. Dolorem deleniti id vero sapiente.',1,0,'2001-12-02 20:42:38','1994-06-15 14:43:25'),
(2,'дом','Quidem tempore quidem suscipit. Aut quia rerum cupiditate sed necessitatibus. Tempora alias hic labore quam enim officia.',2,0,'1998-01-11 01:28:45','1980-06-30 20:28:30'),
(3,'комната','Qui atque error nihil sit molestias. Suscipit ipsum sint magnam ut et et. Est autem sequi facilis.',3,0,'2018-02-21 01:01:49','1992-03-31 13:29:13'),
(4,'студия','Molestiae vel quas non dolores. Ad expedita facere unde quo aut. Illum sed iure repellendus praesentium. Eum dolorem in nihil ut. Aspernatur qui assumenda ut tenetur occaecati et facilis.',4,0,'1980-04-01 03:33:38','1988-06-04 10:33:48'),
(5,'комната','Quia perspiciatis placeat labore aliquam nisi nobis. At enim officia quia eum alias.',5,0,'1985-10-21 18:47:28','1972-11-04 07:27:51'),
(6,'студия','Modi aliquam quae aliquam. Accusantium quam magnam minima consectetur. Natus quia consequatur voluptate dolorem aut est quia.',6,0,'2008-04-20 12:50:32','1971-05-09 02:00:31'),
(7,'апартамент','Sunt illo vitae accusamus ad dolores earum omnis. Aut labore optio omnis dignissimos. In delectus sequi et culpa molestiae. Ratione ipsam fugit consequatur et quo animi. Iusto rerum dolore tempore quaerat voluptatem dolorum voluptate et.',7,0,'2019-03-19 22:08:55','1995-03-10 23:44:20'),
(8,'кровать в общей комнате','Iste eius aut repudiandae est ut. Eaque laborum repellendus doloribus veniam voluptas qui sed. Doloremque eligendi pariatur natus magni omnis. Ut incidunt exercitationem sit vel quibusdam non.',8,0,'2011-08-03 10:48:05','2004-05-07 04:26:21'),
(9,'кровать в общей комнате','Voluptas consectetur quia quas qui nostrum qui aut. Et quo alias occaecati voluptatem quia velit ut. Et reiciendis ipsam quaerat quas et.',9,0,'2003-09-18 18:19:16','1988-10-29 22:33:35'),
(10,'дом','Error aliquid porro sint adipisci inventore ipsum. Repudiandae dicta alias doloremque. Cupiditate incidunt possimus aperiam dolorem eum totam similique.',10,0,'1988-09-21 11:29:01','1991-03-09 23:55:02');

UPDATE places SET object_id = FLOOR(3 + RAND() * (6 - 3 + 1));
UPDATE places SET capacity = FLOOR(1 + RAND() * (5 - 1 + 1)) WHERE place_name !='кровать в общей комнате';
UPDATE places SET capacity = 1 WHERE place_name ='кровать в общей комнате';


INSERT INTO prices (price,currency_id,place_id,type_id,effective_from,effective_to) VALUES 
(RAND()*1000,FLOOR(1 + RAND() * (3 - 1 + 1)),1,FLOOR(1 + RAND() * (2 - 1 + 1)),'1900-01-01 00:00:00','4000-01-01 00:00:00'),
(RAND()*1000,FLOOR(1 + RAND() * (3 - 1 + 1)),2,FLOOR(1 + RAND() * (2 - 1 + 1)),'1900-01-01 00:00:00','4000-01-01 00:00:00'),
(RAND()*1000,FLOOR(1 + RAND() * (3 - 1 + 1)),3,FLOOR(1 + RAND() * (2 - 1 + 1)),'1900-01-01 00:00:00','4000-01-01 00:00:00'),
(RAND()*1000,FLOOR(1 + RAND() * (3 - 1 + 1)),4,FLOOR(1 + RAND() * (2 - 1 + 1)),'1900-01-01 00:00:00','4000-01-01 00:00:00'),
(RAND()*1000,FLOOR(1 + RAND() * (3 - 1 + 1)),5,FLOOR(1 + RAND() * (2 - 1 + 1)),'1900-01-01 00:00:00','4000-01-01 00:00:00'),
(RAND()*1000,FLOOR(1 + RAND() * (3 - 1 + 1)),6,FLOOR(1 + RAND() * (2 - 1 + 1)),'1900-01-01 00:00:00','4000-01-01 00:00:00'),
(RAND()*1000,FLOOR(1 + RAND() * (3 - 1 + 1)),7,FLOOR(1 + RAND() * (2 - 1 + 1)),'1900-01-01 00:00:00','4000-01-01 00:00:00'),
(RAND()*1000,FLOOR(1 + RAND() * (3 - 1 + 1)),8,FLOOR(1 + RAND() * (2 - 1 + 1)),'1900-01-01 00:00:00','4000-01-01 00:00:00'),
(RAND()*1000,FLOOR(1 + RAND() * (3 - 1 + 1)),9,FLOOR(1 + RAND() * (2 - 1 + 1)),'1900-01-01 00:00:00','4000-01-01 00:00:00'),
(RAND()*1000,FLOOR(1 + RAND() * (3 - 1 + 1)),10,FLOOR(1 + RAND() * (2 - 1 + 1)),'1900-01-01 00:00:00','4000-01-01 00:00:00')
;

INSERT INTO place_x_utility (place_id,utility_id) VALUES 
(1,1),
(1,4),
(1,6),
(1,2),
(3,3),
(3,4),
(3,1),
(3,2),
(5,1),
(5,3),
(5,6),
(5,4),
(4,1),
(4,5),
(4,6),
(7,2),
(7,3),
(8,1),
(8,3),
(8,2),
(9,1),
(9,3),
(9,2)
;
INSERT INTO pictures VALUES
(1,FLOOR(1 + RAND() * (2 - 1 + 1)),FLOOR(1 + RAND() * (10 - 1 + 1)),'http://murray.com/','1974-03-09 17:46:42','2013-03-26 21:43:13'),
(2,FLOOR(1 + RAND() * (2 - 1 + 1)),FLOOR(1 + RAND() * (10 - 1 + 1)),'http://kris.org/','1998-09-17 18:47:23','1975-10-09 00:15:23'),
(3,FLOOR(1 + RAND() * (2 - 1 + 1)),FLOOR(1 + RAND() * (10 - 1 + 1)),'http://www.bernierschuppe.com/','2010-06-19 07:31:19','1983-04-15 06:12:21'),
(4,FLOOR(1 + RAND() * (2 - 1 + 1)),FLOOR(1 + RAND() * (10 - 1 + 1)),'http://www.kiehndeckow.info/','2018-10-29 11:02:38','1978-09-26 13:36:08'),
(5,FLOOR(1 + RAND() * (2 - 1 + 1)),FLOOR(1 + RAND() * (10 - 1 + 1)),'http://www.spinka.com/','1978-04-09 12:41:19','2017-08-08 22:31:41'),
(6,FLOOR(1 + RAND() * (2 - 1 + 1)),FLOOR(1 + RAND() * (10 - 1 + 1)),'http://pagac.com/','2015-10-11 03:10:19','2003-03-05 12:02:48'),
(7,FLOOR(1 + RAND() * (2 - 1 + 1)),FLOOR(1 + RAND() * (10 - 1 + 1)),'http://www.gottliebschneider.org/','2002-01-18 23:46:30','1983-11-16 15:33:47'),
(8,FLOOR(1 + RAND() * (2 - 1 + 1)),FLOOR(1 + RAND() * (10 - 1 + 1)),'http://haley.com/','1982-05-13 14:24:28','2005-11-27 18:45:28'),
(9,FLOOR(1 + RAND() * (2 - 1 + 1)),FLOOR(1 + RAND() * (10 - 1 + 1)),'http://lockmanruecker.com/','1977-01-02 22:29:47','2019-06-08 05:03:28'),
(10,FLOOR(1 + RAND() * (2 - 1 + 1)),FLOOR(1 + RAND() * (10 - 1 + 1)),'http://kuhlman.info/','2003-07-21 10:59:09','1982-04-03 17:16:47');

INSERT INTO users VALUES
(1,'Jeremy','ea','Conroy','emclaughlin@example.com','336-566-5028x12537','','1972-04-23','13140',1,'1973-08-21 08:40:41','2020-02-18 03:58:55'),
(2,'Luella','non','Nicolas','lschulist@example.net','1-593-365-0832x0536','','2017-03-26','9878014',1,'1979-08-11 01:36:23','2020-10-10 22:56:50'),
(3,'Karli','veritatis','Hudson','hswift@example.net','904-059-8566x1059','','2009-05-20','63289',1,'1980-05-14 12:12:12','1980-09-16 08:17:08'),
(4,'Shaylee','perspiciatis','Bartell','baby84@example.net','726.313.2923x3255','','1986-10-01','71998808',1,'2015-11-28 12:03:49','1989-02-11 06:13:20'),
(5,'Lauryn','ut','Marvin','graciela.stark@example.com','(260)063-2812x23983','','1998-11-29','8561',1,'1990-12-13 08:34:30','1970-09-28 06:43:53'),
(6,'Ruben','in','Lynch','ncollins@example.org','038.394.6746','','1986-02-09','9589482',1,'2020-02-15 19:28:12','1999-10-01 02:29:54'),
(7,'Lionel','deleniti','Bode','dhilll@example.net','(282)699-7428','','2007-01-20','',1,'1981-08-11 21:34:07','2008-03-27 00:28:11'),
(8,'Katherine','quis','Jacobi','hermiston.ellis@example.org','+06(7)9684203523','','1987-09-18','2579',1,'1999-12-06 17:54:30','1982-07-05 12:13:08'),
(9,'Amelia','quaerat','Kshlerin','viviane02@example.org','02454533231','','2021-03-01','505',1,'2009-09-27 15:08:57','2014-10-17 17:16:04'),
(10,'Zita','sed','Torp','cortney06@example.com','865-210-0272','','1986-01-30','326',1,'1977-08-22 10:13:04','2020-02-07 23:02:54');

-- приводим номера телефонам к формату
UPDATE users SET phone = CONCAT('+7', 9000000000 + FLOOR(999999999 * RAND()));
-- ограничение на формат номера телефона
ALTER TABLE users ADD CONSTRAINT сheck_phone_user CHECK (REGEXP_LIKE(phone, '^\\+7[0-9]{10}$')) ;
-- распределяем страны
UPDATE users SET country = 'USA' WHERE id IN (1,2,3);
UPDATE users SET country = 'RUSSIA' WHERE id IN (5,6,7,10);
UPDATE users SET country = 'GERMANY' WHERE country NOT IN ('RUSSIA','USA');
-- распределяем пол
UPDATE users SET gender = 'Female' WHERE id IN (1,2,3);
UPDATE users SET gender = 'Male' WHERE gender != 'Female';
-- распределяем статусы пользователей
UPDATE users SET status_id = FLOOR(1 + RAND() * (3 - 1 + 1));

INSERT INTO booking_history (place_id,effective_from,effective_to,user_id,status_id,type_id) VALUES 
(1,'1900-01-01 00:00:00','4000-01-01 00:00:00',1,1,1),
(2,'1900-01-01 00:00:00','4000-01-01 00:00:00',2,1,1),
(3,'1900-01-01 00:00:00','4000-01-01 00:00:00',3,1,1),
(4,'1900-01-01 00:00:00','4000-01-01 00:00:00',4,1,1),
(5,'1900-01-01 00:00:00','4000-01-01 00:00:00',5,1,1),
(6,'1900-01-01 00:00:00','4000-01-01 00:00:00',6,1,1),
(7,'1900-01-01 00:00:00','4000-01-01 00:00:00',7,1,1),
(8,'1900-01-01 00:00:00','4000-01-01 00:00:00',8,1,1),
(9,'1900-01-01 00:00:00','4000-01-01 00:00:00',9,1,1),
(10,'1900-01-01 00:00:00','4000-01-01 00:00:00',10,1,1),
(1,'1900-01-01 00:00:00','4000-01-01 00:00:00',1,1,1),
(2,'1900-01-01 00:00:00','4000-01-01 00:00:00',2,1,1),
(3,'1900-01-01 00:00:00','4000-01-01 00:00:00',3,1,1),
(4,'1900-01-01 00:00:00','4000-01-01 00:00:00',4,1,1),
(5,'1900-01-01 00:00:00','4000-01-01 00:00:00',5,1,1),
(6,'1900-01-01 00:00:00','4000-01-01 00:00:00',6,1,1),
(7,'1900-01-01 00:00:00','4000-01-01 00:00:00',7,1,1),
(8,'1900-01-01 00:00:00','4000-01-01 00:00:00',8,1,1),
(9,'1900-01-01 00:00:00','4000-01-01 00:00:00',9,1,1),
(10,'1900-01-01 00:00:00','4000-01-01 00:00:00',10,1,1);

-- устанавливаем реальные статусы и типы брони
UPDATE booking_history SET status_id = FLOOR(1 + RAND() * (4 - 1 + 1)), type_id = FLOOR(1 + RAND() * (2 - 1 + 1));
-- устанавливаем реалистичные даты брони с учетом статусов
UPDATE booking_history SET effective_from = DATE_ADD(NOW(), INTERVAL FLOOR(1 + RAND() * (350 - 1 + 1)) DAY) WHERE status_id NOT IN (2,4);
UPDATE booking_history SET effective_from = DATE_ADD(NOW(), INTERVAL -FLOOR(1 + RAND() * (350 - 1 + 1)) DAY) WHERE status_id IN (2,4);
UPDATE booking_history SET effective_to = DATE_ADD(effective_from, INTERVAL FLOOR(1 + RAND() * (30 - 1 + 1)) DAY);
-- распределяем брони по объектам размещения и пользователям
UPDATE booking_history SET place_id = FLOOR(1 + RAND() * (5 - 1 + 1)), user_id = FLOOR(1 + RAND() * (5 - 1 + 1));

INSERT INTO place_review (booking_id,body) VALUES 
(1,'Libero velit fugit deserunt eos nihil laboriosam assumenda. Aut aperiam nihil rem necessitatibus sunt dolor omnis. Aut accusantium omnis exercitationem nam ipsum voluptates enim. Expedita quisquam enim voluptas velit accusamus.'),
(2,'Et doloribus repudiandae et omnis totam. Voluptatem commodi rerum beatae exercitationem. Omnis ratione aut consequatur qui quasi deleniti.'),
(3,'Voluptatum at provident cumque at. Ut quis quidem exercitationem ex quas reiciendis. Est eos est optio rerum delectus dignissimos ut consequuntur. Qui consequatur vel ea maiores assumenda.'),
(4,'Omnis placeat omnis praesentium facere iusto rerum et. Eos ipsam est tenetur numquam commodi incidunt. Excepturi est molestiae beatae sunt. Sed est maiores quidem sit recusandae veritatis.'),
(5,'Similique ad aut possimus rerum. Explicabo consequatur soluta molestias ex. Consequatur laboriosam libero est maxime similique.'),
(6,'Ab sit sit ullam porro in. Illo vitae quos magnam eius vel eligendi eum ipsum. Possimus quod quia maiores libero architecto.'),
(7,'Consectetur molestiae occaecati quo at laborum odit. Nisi qui ratione vel illo molestias hic sit. Nihil repudiandae similique nihil deleniti aut a quia. Aperiam laudantium nisi aspernatur.'),
(8,'Laborum voluptates rerum asperiores ipsam aut. Nostrum dolores laboriosam incidunt tempora suscipit.'),
(9,'In nesciunt aut ea nostrum cumque quisquam. In quia quibusdam placeat excepturi debitis aut. Recusandae amet eveniet voluptatem.'),
(10,'Natus ipsum aut itaque explicabo et sunt. Placeat id dolore aut architecto excepturi optio. Excepturi doloremque recusandae doloribus.'),
(11,'Libero velit fugit deserunt eos nihil laboriosam assumenda. Aut aperiam nihil rem necessitatibus sunt dolor omnis. Aut accusantium omnis exercitationem nam ipsum voluptates enim. Expedita quisquam enim voluptas velit accusamus.'),
(12,'Et doloribus repudiandae et omnis totam. Voluptatem commodi rerum beatae exercitationem. Omnis ratione aut consequatur qui quasi deleniti.'),
(13,'Voluptatum at provident cumque at. Ut quis quidem exercitationem ex quas reiciendis. Est eos est optio rerum delectus dignissimos ut consequuntur. Qui consequatur vel ea maiores assumenda.'),
(14,'Omnis placeat omnis praesentium facere iusto rerum et. Eos ipsam est tenetur numquam commodi incidunt. Excepturi est molestiae beatae sunt. Sed est maiores quidem sit recusandae veritatis.'),
(15,'Similique ad aut possimus rerum. Explicabo consequatur soluta molestias ex. Consequatur laboriosam libero est maxime similique.'),
(16,'Ab sit sit ullam porro in. Illo vitae quos magnam eius vel eligendi eum ipsum. Possimus quod quia maiores libero architecto.'),
(17,'Consectetur molestiae occaecati quo at laborum odit. Nisi qui ratione vel illo molestias hic sit. Nihil repudiandae similique nihil deleniti aut a quia. Aperiam laudantium nisi aspernatur.'),
(18,'Laborum voluptates rerum asperiores ipsam aut. Nostrum dolores laboriosam incidunt tempora suscipit.'),
(19,'In nesciunt aut ea nostrum cumque quisquam. In quia quibusdam placeat excepturi debitis aut. Recusandae amet eveniet voluptatem.'),
(20,'Natus ipsum aut itaque explicabo et sunt. Placeat id dolore aut architecto excepturi optio. Excepturi doloremque recusandae doloribus.');

INSERT INTO rates VALUES 
(1,'1','1982-11-22 14:51:06','2010-12-23 10:45:53'),
(2,'2','2012-06-26 14:55:02','1995-11-02 22:30:11'),
(3,'3','2004-03-21 20:38:20','1996-09-13 14:35:58'),
(4,'4','1976-09-21 16:35:51','1985-08-15 12:12:09'),
(5,'5','1996-07-03 05:11:35','1992-09-08 08:36:57'),
(6,'6','2000-11-17 22:31:08','2005-03-29 07:42:00'),
(7,'7','2010-05-25 12:32:10','2001-10-21 12:50:53'),
(8,'8','2009-07-08 05:05:08','2013-04-27 15:51:39'),
(9,'9','1979-12-18 12:05:43','1980-10-18 03:43:04'),
(10,'10','1998-09-17 08:37:50','1976-12-24 14:20:55');

INSERT INTO place_rating (booking_id, rate_id, parametr_id) VALUES 
(FLOOR(1 + RAND() * (20 - 1 + 1)),FLOOR(1 + RAND() * (10 - 1 + 1)),FLOOR(1 + RAND() * (5 - 1 + 1))),
(FLOOR(1 + RAND() * (20 - 1 + 1)),FLOOR(1 + RAND() * (10 - 1 + 1)),FLOOR(1 + RAND() * (5 - 1 + 1))),
(FLOOR(1 + RAND() * (20 - 1 + 1)),FLOOR(1 + RAND() * (10 - 1 + 1)),FLOOR(1 + RAND() * (5 - 1 + 1))),
(FLOOR(1 + RAND() * (20 - 1 + 1)),FLOOR(1 + RAND() * (10 - 1 + 1)),FLOOR(1 + RAND() * (5 - 1 + 1))),
(FLOOR(1 + RAND() * (20 - 1 + 1)),FLOOR(1 + RAND() * (10 - 1 + 1)),FLOOR(1 + RAND() * (5 - 1 + 1))),
(FLOOR(1 + RAND() * (20 - 1 + 1)),FLOOR(1 + RAND() * (10 - 1 + 1)),FLOOR(1 + RAND() * (5 - 1 + 1))),
(FLOOR(1 + RAND() * (20 - 1 + 1)),FLOOR(1 + RAND() * (10 - 1 + 1)),FLOOR(1 + RAND() * (5 - 1 + 1))),
(FLOOR(1 + RAND() * (20 - 1 + 1)),FLOOR(1 + RAND() * (10 - 1 + 1)),FLOOR(1 + RAND() * (5 - 1 + 1))),
(FLOOR(1 + RAND() * (20 - 1 + 1)),FLOOR(1 + RAND() * (10 - 1 + 1)),FLOOR(1 + RAND() * (5 - 1 + 1))),
(FLOOR(1 + RAND() * (20 - 1 + 1)),FLOOR(1 + RAND() * (10 - 1 + 1)),FLOOR(1 + RAND() * (5 - 1 + 1))),
(FLOOR(1 + RAND() * (20 - 1 + 1)),FLOOR(1 + RAND() * (10 - 1 + 1)),FLOOR(1 + RAND() * (5 - 1 + 1))),
(FLOOR(1 + RAND() * (20 - 1 + 1)),FLOOR(1 + RAND() * (10 - 1 + 1)),FLOOR(1 + RAND() * (5 - 1 + 1))),
(FLOOR(1 + RAND() * (20 - 1 + 1)),FLOOR(1 + RAND() * (10 - 1 + 1)),FLOOR(1 + RAND() * (5 - 1 + 1))),
(FLOOR(1 + RAND() * (20 - 1 + 1)),FLOOR(1 + RAND() * (10 - 1 + 1)),FLOOR(1 + RAND() * (5 - 1 + 1))),
(FLOOR(1 + RAND() * (20 - 1 + 1)),FLOOR(1 + RAND() * (10 - 1 + 1)),FLOOR(1 + RAND() * (5 - 1 + 1))),
(FLOOR(1 + RAND() * (20 - 1 + 1)),FLOOR(1 + RAND() * (10 - 1 + 1)),FLOOR(1 + RAND() * (5 - 1 + 1))),
(FLOOR(1 + RAND() * (20 - 1 + 1)),FLOOR(1 + RAND() * (10 - 1 + 1)),FLOOR(1 + RAND() * (5 - 1 + 1))),
(FLOOR(1 + RAND() * (20 - 1 + 1)),FLOOR(1 + RAND() * (10 - 1 + 1)),FLOOR(1 + RAND() * (5 - 1 + 1))),
(FLOOR(1 + RAND() * (20 - 1 + 1)),FLOOR(1 + RAND() * (10 - 1 + 1)),FLOOR(1 + RAND() * (5 - 1 + 1))),
(FLOOR(1 + RAND() * (20 - 1 + 1)),FLOOR(1 + RAND() * (10 - 1 + 1)),FLOOR(1 + RAND() * (5 - 1 + 1))),
(FLOOR(1 + RAND() * (20 - 1 + 1)),FLOOR(1 + RAND() * (10 - 1 + 1)),FLOOR(1 + RAND() * (5 - 1 + 1))),
(FLOOR(1 + RAND() * (20 - 1 + 1)),FLOOR(1 + RAND() * (10 - 1 + 1)),FLOOR(1 + RAND() * (5 - 1 + 1))),
(FLOOR(1 + RAND() * (20 - 1 + 1)),FLOOR(1 + RAND() * (10 - 1 + 1)),FLOOR(1 + RAND() * (5 - 1 + 1))),
(FLOOR(1 + RAND() * (20 - 1 + 1)),FLOOR(1 + RAND() * (10 - 1 + 1)),FLOOR(1 + RAND() * (5 - 1 + 1))),
(FLOOR(1 + RAND() * (20 - 1 + 1)),FLOOR(1 + RAND() * (10 - 1 + 1)),FLOOR(1 + RAND() * (5 - 1 + 1))),
(FLOOR(1 + RAND() * (20 - 1 + 1)),FLOOR(1 + RAND() * (10 - 1 + 1)),FLOOR(1 + RAND() * (5 - 1 + 1))),
(FLOOR(1 + RAND() * (20 - 1 + 1)),FLOOR(1 + RAND() * (10 - 1 + 1)),FLOOR(1 + RAND() * (5 - 1 + 1))),
(FLOOR(1 + RAND() * (20 - 1 + 1)),FLOOR(1 + RAND() * (10 - 1 + 1)),FLOOR(1 + RAND() * (5 - 1 + 1))),
(FLOOR(1 + RAND() * (20 - 1 + 1)),FLOOR(1 + RAND() * (10 - 1 + 1)),FLOOR(1 + RAND() * (5 - 1 + 1))),
(FLOOR(1 + RAND() * (20 - 1 + 1)),FLOOR(1 + RAND() * (10 - 1 + 1)),FLOOR(1 + RAND() * (5 - 1 + 1)))
;

-- 4 скрипты характерных выборок из БД

-- (1) свободные доступные места размещения во всех гостиницах Москвы с ценой за 1-го гостя в сутки и вместимостью на сегодня
SELECT 
	 ob.object_name
	,pl.place_name 
	,pl.capacity 
	,ROUND(IF(pt.price_name = 'За гостя', pl.capacity*pr.price, pr.price),2) price
	,ct.сurrency_code 
FROM objects ob INNER JOIN places pl ON ob.id = pl.object_id AND ob.city = 'Moscow'
					INNER JOIN object_type ot ON ob.type_id = ot.id AND ot.type_name = 'Гостиница'
						INNER JOIN prices pr ON pr.place_id =pl.id  AND NOW() BETWEEN pr.effective_from AND pr.effective_to 
							INNER JOIN currency_type ct ON pr.currency_id = ct.id 
						 		INNER JOIN price_type pt ON pr.type_id = pt.id 
									LEFT JOIN booking_history bh ON pl.id = bh.place_id  AND NOW() BETWEEN bh.effective_from AND bh.effective_to
WHERE bh.id IS NULL 
;
-- (2) вывести из выборки (1) место размещения с максимальным числом удобств и все удобства в нем
WITH hotels_moscow AS (
	SELECT 
		ob.object_name 
		,pl.place_name
		,pl.id
		,COUNT(pxu.utility_id) util_cnt
	FROM objects ob INNER JOIN places pl ON ob.id = pl.object_id AND ob.city = 'Moscow'
						INNER JOIN object_type ot ON ob.type_id = ot.id AND ot.type_name = 'Гостиница'
							LEFT JOIN booking_history bh ON pl.id = bh.place_id  AND NOW() BETWEEN bh.effective_from AND bh.effective_to
								INNER JOIN place_x_utility pxu ON pxu.place_id =pl.id 
									INNER JOIN utilities ut ON pxu.utility_id =ut.id 
	WHERE bh.id IS NULL 
	GROUP BY ob.object_name, pl.place_name, pl.id 
)
SELECT 
	 hm.object_name
	,hm.place_name
	,ut.utility_name 
FROM hotels_moscow hm INNER JOIN  (SELECT MAX(util_cnt) util_max FROM hotels_moscow) hm_gr ON hm.util_cnt = hm_gr.util_max
						INNER JOIN place_x_utility pxu ON pxu.place_id =hm.id 
							INNER JOIN utilities ut ON pxu.utility_id =ut.id 
;

-- (3) вывести из выборки (1) место размещения с самой высокой оценкой по всем параметрам и показать отзывы и оценки этого места по времени проживания от новых к старым с указанием автора отзыва
WITH hotels_moscow AS (
	SELECT 
		ob.object_name 
		,pl.place_name
		,pl.id
		,SUM(IFNULL( CONVERT(rt.rating_name,UNSIGNED INTEGER),0)) overall_rate
	FROM objects ob INNER JOIN places pl ON ob.id = pl.object_id AND ob.city = 'Moscow'
						INNER JOIN object_type ot ON ob.type_id = ot.id AND ot.type_name = 'Гостиница'
							LEFT JOIN booking_history bh ON pl.id = bh.place_id  AND NOW() BETWEEN bh.effective_from AND bh.effective_to
								LEFT JOIN booking_history hb ON pl.id = hb.place_id	
									LEFT JOIN place_rating pr ON hb.id = pr.booking_id 
										LEFT JOIN rates rt ON pr.rate_id = rt.id
	WHERE bh.id IS NULL
	GROUP BY ob.object_name, pl.place_name, pl.id
) 
SELECT 
	 hm.object_name
	,hm.place_name
	,DATE_FORMAT(hb.effective_to, '%d %M %Y') booking_end
	,SUM(IFNULL( CONVERT(rt.rating_name, UNSIGNED INTEGER),0)) overall_rate
	,prw.body review
	,CONCAT(us.first_name," ", us.middle_name," ", us.last_name) author_name
FROM hotels_moscow hm INNER JOIN  (SELECT MAX(overall_rate) rate_max FROM hotels_moscow) hm_gr ON hm.overall_rate = hm_gr.rate_max
					  	INNER JOIN booking_history hb ON hm.id = hb.place_id	
							INNER JOIN place_rating pr ON hb.id = pr.booking_id 
								INNER JOIN rates rt ON pr.rate_id = rt.id
									INNER JOIN users us ON us.id =hb.user_id 
										LEFT JOIN place_review prw ON prw.booking_id=hb.id
GROUP BY hm.object_name
		,hm.place_name
		,DATE_FORMAT(hb.effective_to, '%d %M %Y')
		,prw.body
		,CONCAT(us.first_name," ", us.middle_name," ", us.last_name)
ORDER BY hb.effective_to desc
;

-- 5 Представления

-- пользователи со статусом лояльности Genius разных уровней
CREATE OR REPLACE VIEW genius_users AS 
SELECT
	 UPPER(us.first_name) first_name 
	,UPPER(us.middle_name) middle_name 
	,UPPER(us.last_name) last_name 
	,us.email 
	,us.phone 
	,us.gender 
	,TIMESTAMPDIFF(YEAR, us.birth_dt , NOW()) age
	,us.country 
	,uss.status_name 
FROM users us INNER JOIN user_status uss ON us.status_id = uss.id
WHERE UPPER(uss.status_name) LIKE '%GENIUS%'
;
-- объекты, которые не бронировались ни разу с начала текущего года, показать также из владельцев
CREATE OR REPLACE VIEW unpopular_objects AS
SELECT
	 ob.object_name
	,UPPER(ow.first_name) first_name
	,UPPER(ow.middle_name) middle_name
	,UPPER(ow.last_name) last_name
	,ow.phone 
	,ow.email 
	,SUM(IF(bh.id IS NULL,0,1)) booking_cnt
FROM objects ob INNER JOIN places pl ON ob.id = pl.object_id 
					INNER JOIN owners ow ON ob.owner_id = ow.id 
						LEFT JOIN booking_history bh ON bh.place_id = pl.id AND bh.created_at >= MAKEDATE(YEAR(NOW()),1)
WHERE bh.id IS NULL
GROUP BY ob.object_name, ow.first_name, ow.middle_name, ow.last_name, ow.phone, ow.email
HAVING SUM(IF(bh.id IS NULL,0,1)) = 0;
;

-- 6 Хранимые процедуры и триггеры

-- (1) триггеры, выдающие предупреждение при попытке записать в БД номер телефона пользователя и владельца, не соответствующий нужному формату. Действуют на вставку нового пользователя или изменение старого
-- общая процедура проверки для обоих триггеров
DROP PROCEDURE IF EXISTS phone_format;
CREATE PROCEDURE phone_format (IN phone VARCHAR(100))
BEGIN
  IF NOT REGEXP_LIKE(phone, '^\\+7[0-9]{10}$') THEN 
  		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Incorrect phone format';
  END IF;
END;

-- триггер вставки в users
DROP TRIGGER IF EXISTS user_phone_format_ins;
CREATE TRIGGER user_phone_format_ins BEFORE INSERT ON users
FOR EACH ROW
BEGIN
	CALL phone_format(NEW.phone);
END;
-- проверка вставки
INSERT INTO users VALUES
(11,'Zita','sed','Torp','cortney06@example.com','865-210-0272','','1986-01-30','326',1,'1977-08-22 10:13:04','2020-02-07 23:02:54');

-- триггер изменения в users
DROP TRIGGER IF EXISTS user_phone_format_upd;
CREATE TRIGGER user_phone_format_upd BEFORE UPDATE ON users
FOR EACH ROW
BEGIN
	CALL phone_format(NEW.phone);
END;
-- проверка изменения
UPDATE users SET phone = '865-210-0272' WHERE id = 10;

-- триггер вставки в owners
DROP TRIGGER IF EXISTS owner_phone_format_ins;
CREATE TRIGGER owner_phone_format_ins BEFORE INSERT ON owners
FOR EACH ROW
BEGIN
	CALL phone_format(NEW.phone);
END;
-- проверка вставки
INSERT INTO owners VALUES
(11,'Gaylord','expedita','West','shaina.wiza@example.net','801-302-9179','2014-11-09 07:26:14','1975-06-04 16:38:27');

-- триггер изменения в owners
DROP TRIGGER IF EXISTS owner_phone_format_upd;
CREATE TRIGGER owner_phone_format_upd BEFORE UPDATE ON owners
FOR EACH ROW
BEGIN
	CALL phone_format(NEW.phone);
END;
-- проверка изменения
UPDATE owners SET phone = '865-210-0272' WHERE id = 10;

-- (2) процедура поиска всех броней пользователя со статусом 'Незаезд' по фамилии, если пользователя нет в системе, выдать сообщение
DROP PROCEDURE IF EXISTS user_booking;
CREATE PROCEDURE user_booking (IN LastName VARCHAR(100))
BEGIN
	DECLARE u_cnt INT;
	SELECT 
		1 
	INTO u_cnt	
	FROM users us 
	WHERE UPPER(us.last_name) = UPPER(LastName)
	LIMIT 1;
	  IF u_cnt IS NULL THEN 
	  	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'User not found';
	  ELSE 
		SELECT 
	 		 us.last_name 
	 		,us.middle_name 
	 		,us.first_name 
	 		,ob.object_name 
	 		,pl.place_name 
	 		,bh.effective_from 
	 		,bh.effective_to 
	 		,bs.status_name 
		  FROM users us INNER JOIN booking_history bh ON us.id =bh.user_id AND UPPER(us.last_name) = UPPER(LastName)
		 					INNER JOIN places pl ON bh.place_id = pl.id
		 						INNER JOIN objects ob ON ob.id = pl.object_id
		 							INNER JOIN booking_status bs ON bs.id = bh.status_id AND bs.status_name = 'Незаезд';
	  END IF;
END;

CALL user_booking('conroy');
CALL user_booking('петров');







