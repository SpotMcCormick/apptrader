##PROJECT
Here is a project that team members and I did in class for a company called AppTrader. Based on on our research we concluded that entertainment apps were highly profitable and want to strike at the opprotunity. We picked apps that ranker higher than the average rating between 2 app stores and averaged and rounded their ranking between the store. Down below are the assumptions of Apptraders business format.

##Assumptions

Based on research completed prior to launching App Trader as a company, you can assume the following:

a. App Trader will purchase apps for 10,000 times the price of the app. For apps that are priced from free up to $1.00, the purchase price is $10,000.
    
- For example, an app that costs $2.00 will be purchased for $20,000.
    
- The cost of an app is not affected by how many app stores it is on. A $1.00 app on the Apple app store will cost the same as a $1.00 app on both stores. 
    
- If an app is on both stores, it's purchase price will be calculated based off of the highest app price between the two stores. 

b. Apps earn $5000 per month, per app store it is on, from in-app advertising and in-app purchases, regardless of the price of the app.
    
- An app that costs $200,000 will make the same per month as an app that costs $1.00. 

- An app that is on both app stores will make $10,000 per month. 

c. App Trader will spend an average of $1000 per month to market an app regardless of the price of the app. If App Trader owns rights to the app in both stores, it can market the app for both stores for a single cost of $1000 per month.
    
- An app that costs $200,000 and an app that costs $1.00 will both cost $1000 a month for marketing, regardless of the number of stores it is in.

d. For every half point that an app gains in rating, its projected lifespan increases by one year. In other words, an app with a rating of 0 can be expected to be in use for 1 year, an app with a rating of 1.0 can be expected to last 3 years, and an app with a rating of 4.0 can be expected to last 9 years.
    
- App store ratings should be calculated by taking the average of the scores from both app stores and rounding to the nearest 0.5.

e. App Trader would prefer to work with apps that are available in both the App Store and the Play Store since they can market both for the same $1000 per month.


##Our Code
Our code consisted of finding entertainment apps that ranked higher than the averating rating. He also averaged and rounded all the app rankings between the 2 stores. The code looked like this. 


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

#Dashboard
Then our team made a dashboard and presented it to stake holders

![Charts](https://github.com/SpotMcCormick/apptrader/assets/132832823/db4e6252-5e84-4cda-b525-a87c3c07e806)

LINK HERE
https://public.tableau.com/app/profile/jeremy.mccormick/viz/Pesentation_16876278636820/Charts

##The Grand Total

<img width="339" alt="Image20230624120619" src="https://github.com/SpotMcCormick/apptrader/assets/132832823/5481e394-e4ac-43bd-a40e-feeb1ec89d65">

