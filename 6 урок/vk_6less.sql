-- дз 1 Пусть задан некоторый пользователь. Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем. Решаем без JOIN
USE vk;
SELECT * FROM vk.users WHERE id = 20; -- пусть ищем для этого пользователя
SELECT * FROM vk.friendship WHERE user_id = 20;
-- генерим побольше друзей
UPDATE friendship SET user_id = 20 WHERE user_id < 20;
SELECT * FROM friendship where user_id=20;
UPDATE friendship_request_types SET name = 'friendship' WHERE id = 1;
UPDATE friendship_request_types SET name = 'subscribtion' WHERE id = 2;
UPDATE friendship_request_types SET name = 'block' WHERE id = 3;
UPDATE friendship SET request_type_id = FLOOR(1+RAND()*2) WHERE user_id = 20;
-- все друзья пользователя 20
SELECT * FROM friendship WHERE request_type_id = 1 and user_id = 20;
/*1
4
5
8
9
10
15
16
*/
-- делаем побольше сообщений между пользователем 20 и друзьями
UPDATE messages SET to_user_id = 20 where to_user_id > 70;
UPDATE messages SET from_user_id = 20 where to_user_id in (1,4,5,8,9);
-- ищем макс сообщений
WITH friend_id AS (
WITH grouped_messages AS (
WITH friends AS (
	SELECT
		friend_id
	FROM
		friendship
	WHERE
		user_id = 20
		AND request_type_id = 1
)
SELECT
	if(from_user_id= 20, to_user_id, from_user_id) friend
   ,count(*) message_cnt
FROM messages 
WHERE (from_user_id = 20 AND to_user_id IN (SELECT friend_id FROM friends )) or (to_user_id = 20 and from_user_id IN (SELECT friend_id FROM friends))
GROUP BY if(from_user_id= 20, to_user_id, from_user_id)
)
SELECT 
	friend
FROM grouped_messages
WHERE  message_cnt = (SELECT MAX(message_cnt) FROM grouped_messages)
) 
SELECT 
   id
  ,last_name
  ,first_name
FROM users
WHERE id =  (SELECT * FROM friend_id)
;
-- дз 2 Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.Решаем без JOIN
-- ищем самых молодых и генрерим побольше лайков
SELECT *
FROM users
ORDER BY birthday DESC
LIMIT 10;
/*96
95
92
79
73
63
53
32
28
6*/
UPDATE user_likes SET like_type = 'LIKE' where id>30;
UPDATE user_likes SET like_type = 'DISLIKE' where id<=30;
-- считаем лайки молодых
WITH yongsters AS (
	SELECT 
		id
	FROM users
	ORDER BY birthday DESC
	LIMIT 10
)
SELECT
	count(*) likes_cnt
FROM user_likes 
WHERE user_id in (SELECT * FROM yongsters) and like_type = 'LIKE'
;
-- дз 3 Определить кто больше поставил лайков (всего) - мужчины или женщины?Решаем без JOIN
UPDATE media_likes SET like_type = 'LIKE' where id>30;
UPDATE media_likes SET like_type = 'DISLIKE' where id<=30;
UPDATE post_likes SET like_type = 'LIKE' where id>30;
UPDATE post_likes SET like_type = 'DISLIKE' where id<=30;

WITH max_likes AS (
WITH agg_likes AS (
WITH gender_users AS (
	SELECT
		 id
        ,gender
    FROM users 
)
SELECT 
   count(*) cnt
  ,'media_likes' as `type`
  ,'M' as gender
FROM media_likes
WHERE user_id in (SELECT id FROM gender_users WHERE gender = 'M') and like_type = 'LIKE'
UNION ALL 
SELECT 
   count(*) cnt
  ,'media_likes' as `type`
  ,'F' as gender
FROM media_likes
WHERE user_id in (SELECT id FROM gender_users WHERE gender = 'F') and like_type = 'LIKE'
UNION ALL
SELECT 
   count(*) cnt
  ,'media_likes' as `type`
  ,'M' as gender
FROM post_likes
WHERE user_id in (SELECT id FROM gender_users WHERE gender = 'M') and like_type = 'LIKE'
UNION ALL
SELECT 
   count(*) cnt
  ,'media_likes' as `type`
  ,'F' as gender
FROM post_likes
WHERE user_id in (SELECT id FROM gender_users  WHERE gender = 'F') and like_type = 'LIKE'
UNION ALL
SELECT 
   count(*) cnt
  ,'media_likes' as `type`
  ,'M' as gender
FROM user_likes
WHERE author_id in (SELECT id FROM gender_users WHERE gender = 'M') and like_type = 'LIKE'
UNION ALL
SELECT 
   count(*) cnt
  ,'media_likes' as `type`
  ,'F' as gender
FROM user_likes
WHERE author_id in (SELECT id FROM gender_users  WHERE gender = 'F') and like_type = 'LIKE'
)
	SELECT
		 gender
		,SUM(cnt) amount
	FROM agg_likes
	GROUP BY gender
)
SELECT
  IF(gender='F','Женщины','Мужчины') max_likes_gender
FROM max_likes 
WHERE amount = (SELECT MAX(amount) FROM max_likes)
;
-- дз 4 Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.
-- считаем по сумме активностей в соцсети - отправленне сообщения, все виды лайков и дислайков и посты
WITH agg_activity AS (
WITH all_activity AS (
SELECT
	 from_user_id as user_id
    ,count(*) cnt
FROM messages
GROUP BY from_user_id
UNION 
SELECT
	 user_id
    ,count(*) cnt
FROM posts
GROUP BY user_id
UNION 
SELECT
	 author_id as user_id
    ,count(*) cnt
FROM user_likes
GROUP BY author_id
UNION 
SELECT
	 user_id
    ,count(*) cnt
FROM media_likes
GROUP BY user_id
UNION 
SELECT
	 user_id
    ,count(*) cnt
FROM post_likes
GROUP BY user_id
)
SELECT
   user_id
  ,SUM(cnt) activity_index
FROM all_activity
GROUP BY user_id
)
SELECT 
   id
  ,last_name
  ,first_name
FROM users WHERE id in (SELECT user_id FROM agg_activity ORDER BY activity_index)
;




