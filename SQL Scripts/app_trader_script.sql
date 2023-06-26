--COUNT of apple
SELECT COUNT(name) 
FROM app_store_apps

--7197

--COUNT OF google
SELECT COUNT(name)
FROM play_store_apps

--10840

SELECT COUNT(name)
FROM app_store_apps AS a
JOIN play_store_apps AS g
USING(name)

--553 toal apps on both 

--average rating is 4.4 of both app stores

WITH combined_average AS 
(SELECT
	((SELECT AVG(rating)
	FROM app_store_apps) + (SELECT AVG(rating)
	FROM play_store_apps))/ 2)


--ROUGH DRAFT
SELECT 
DISTINCT name, 
ROUND(a.rating+g.rating,2)/2 AS combined_average,
ROUND(a.rating *2,0) AS years_on_apple, 
(a.rating*2*12*10000)::MONEY AS apple_profit_over_time,  
g.rating AS google_rating, 
ROUND(g.rating*2,1) AS years_on_play, 
(g.rating*2*12*10000)::MONEY AS play_profit_over_time, 
CASE WHEN g.price = '0' THEN '$10,000' ELSE CAST(TRIM(REPLACE(g.price, '$', '')) AS numeric)*10000::MONEY END AS purchase_price , g.price::money AS total_price,
ROUND(g.rating*2*12*1000,1)::MONEY AS marketing_cost_over_time

FROM app_store_apps AS a
JOIN play_store_apps AS g
USING(name)
WHERE a.rating >
	( SELECT AVG(rating)
	 FROM app_store_apps
	 JOIN play_store_apps
	 USING (rating))
AND g.rating> 
( SELECT AVG(rating)
	 FROM app_store_apps
	 JOIN play_store_apps
 	USING(rating))
AND a.primary_genre LIKE '%Ent%'
OR g.genres LIKE '%Ent%'
ORDER BY combined_average DESC
LIMIT 10





--ROUNDED, FINAL

SELECT 
DISTINCT name, 
CASE 
	WHEN ((a.rating + g.rating) / 2) % 1 >= 0.25 AND ((a.rating + g.rating) / 2) % 1 <= 0.75 THEN FLOOR((a.rating + g.rating) / 2) + 0.5 
	WHEN ((a.rating + g.rating) / 2) % 1 > 0.75 THEN CEILING((a.rating + g.rating) / 2)
	ELSE FLOOR((a.rating + g.rating) / 2)
	END AS combined_average_rounded,
(5+5) AS life_span, 
(4.5*2*12*10000)::MONEY AS profit_over_time,  
CASE WHEN g.price = '0' THEN '$10,000' ELSE CAST(TRIM(REPLACE(g.price, '$', '')) AS numeric)*10000::MONEY END AS purchase_price , g.price::money AS total_price,
ROUND(g.rating*2*12*1000,1)::MONEY AS marketing_cost_over_time
FROM app_store_apps AS a
JOIN play_store_apps AS g
USING(name)
WHERE a.rating >
	( SELECT AVG(rating)
	 FROM app_store_apps
	 JOIN play_store_apps
	 USING (rating))
AND g.rating> 
( SELECT AVG(rating)
	 FROM app_store_apps
	 JOIN play_store_apps
 	USING(rating))
AND a.primary_genre LIKE '%Ent%'
OR g.genres LIKE '%Ent%'
ORDER BY combined_average_rounded DESC
LIMIT 10

--DATA TYPES

 SELECT column_name, data_type
 FROM information_schema.columnns
 WHERE table_name= app_store_apps
 
select column_name, data_type from information_schema.columns
where table=-app_store_apps = 'config';



SELECT AVG(CAST(g.price AS numeric)), AVG(a.price)
				FROM app_store_apps AS a
				JOIN play_store_apps AS g
				USING(name)
			
				
				
				
				SELECT column_name,
				data_type
				FROM information_schema.columns  
				WHERE table_name= 'play_store_apps'
				
				
--Highest rated apps for both stores 
SELECT DISTINCT name, a.rating, g.rating, g.genres,a.primary_genre 
FROM app_store_apps AS a
JOIN play_store_apps AS g
USING(name)
WHERE a.primary_genre LIKE '%Ent%'
OR g.genres LIKE '%Ent%'
ORDER BY a.rating DESC, g.rating	


SELECT a.name, a.price, p.install_count, ROUND((a.rating + p.rating),2) / 2 AS avg_rating
FROM app_store_apps AS a
INNER JOIN play_store_apps AS p
USING (name)
WHERE a.name = p.name
	AND a.rating > 3.5
    AND primary_genre = 'Entertainment'
    AND a.price = 0
ORDER BY avg_rating DESC
LIMIT 10;

SELECT DISTINCT name, rating
FROM play_store_apps
WHERE install_count= '1,000,000,000+'
ORDER BY rating DESC



WITH combined_table (name) AS (
	SELECT name
	FROM app_store_apps AS a
	INNER JOIN play_store_apps AS p
	USING (name)
	WHERE primary_genre = 'Entertainment'
		AND genres = 'Entertainment'
	)
SELECT DISTINCT name, ROUND((a.rating + p.rating),2) / 2 AS avg_rating
FROM combined_table
INNER JOIN app_store_apps AS a
USING(name)
INNER JOIN play_store_apps AS p
USING(name)
ORDER BY avg_rating DESC
LIMIT 10;



SELECT COUNT(DISTINCT )