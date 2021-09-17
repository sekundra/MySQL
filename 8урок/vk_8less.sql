-- дз 1 Пусть задан некоторый пользователь. Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем. Решаем через JOIN
USE vk;
SELECT * FROM users WHERE id = 20; -- пусть ищем для этого пользователя
SELECT * FROM friendship WHERE user_id = 20;
SELECT * FROM friendship;
-- генерим побольше друзей
UPDATE friendship SET user_id = 20 WHERE friend_id in (1,4,5,8,9,15,72,100,12,18,22);
SELECT * FROM friendship where user_id=20;
UPDATE friendship_request_types SET name = 'friendship' WHERE id = 1;
UPDATE friendship_request_types SET name = 'subscribtion' WHERE id = 2;
UPDATE friendship_request_types SET name = 'block' WHERE id = 3;
UPDATE friendship SET request_type_id = FLOOR(1+RAND()*2) WHERE user_id = 20;
-- все друзья пользователя 20
SELECT * FROM friendship WHERE request_type_id = 1 and user_id = 20;
-- делаем побольше сообщений между пользователем 20 и друзьями
UPDATE messages SET to_user_id = 20 where to_user_id > 70;
UPDATE messages SET from_user_id = 20 where to_user_id in (1,4,5,8,9,15,72,100,12);
SELECT * FROM messages WHERE (to_user_id = 20 and from_user_id in(1,9,12,22,23)) or (from_user_id=20 and to_user_id in(1,9,12,22,23));
-- ищем макс сообщений
WITH message_agg AS (
		SELECT 
			if(ms.from_user_id= 20, ms.to_user_id, ms.from_user_id) friend_id
		   ,count(*) message_cnt
		FROM users us INNER JOIN friendship fr ON us.id = fr.user_id AND us.id = 20 AND fr.request_type_id = 1
						INNER JOIN messages ms ON (ms.from_user_id = us.id AND ms.to_user_id = fr.friend_id) OR (ms.from_user_id = fr.friend_id AND ms.to_user_id = us.id)
		GROUP BY if(ms.from_user_id= 20, ms.to_user_id, ms.from_user_id)
	)
SELECT
	  ma.friend_id
     ,us.last_name
     ,us.first_name
FROM message_agg ma INNER JOIN users us ON (ma.friend_id = us.id AND ma.message_cnt in (SELECT max(message_cnt) FROM message_agg))
;
-- дз 2 Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.Решаем через JOIN
-- ищем самых молодых и генрерим побольше лайков
SELECT *
FROM users
ORDER BY birthday DESC
LIMIT 10;
UPDATE user_likes SET like_type = 'LIKE' where id>30;
UPDATE user_likes SET like_type = 'DISLIKE' where id<=30;
-- считаем лайки молодых
SELECT
	count(*) likes_cnt
FROM user_likes ul INNER JOIN (SELECT id FROM users ORDER BY birthday DESC LIMIT 10) us ON (ul.user_id = us.id AND like_type = 'LIKE')
;
-- дз 3 Определить кто больше поставил лайков (всего) - мужчины или женщины?Решаем через JOIN
UPDATE media_likes SET like_type = 'LIKE' where id>30;
UPDATE media_likes SET like_type = 'DISLIKE' where id<=30;
UPDATE post_likes SET like_type = 'LIKE' where id>30;
UPDATE post_likes SET like_type = 'DISLIKE' where id<=30;

WITH grouped_likes AS (
WITH all_likes AS (
					SELECT
						 user_id
						,count(*) likes_cnt
					FROM media_likes WHERE like_type = 'LIKE'
					GROUP BY user_id
					UNION ALL 
					SELECT
						 user_id
						,count(*) likes_cnt
					FROM post_likes WHERE like_type = 'LIKE'
					GROUP BY user_id
					UNION ALL 
					SELECT
						 author_id user_id
						,count(*) likes_cnt
					FROM user_likes WHERE like_type = 'LIKE'
					GROUP BY author_id
                    )
SELECT
     if(us.gender='F', 'Женщины','Мужчины') likes_gender
    ,sum(likes_cnt) all_likes
FROM all_likes al inner join users us on (al.user_id = us.id)
GROUP BY if(us.gender='F', 'Женщиный','Мужчины')
)
SELECT
	likes_gender
FROM grouped_likes
WHERE all_likes IN (SELECT max(all_likes) FROM grouped_likes)
;
