/*добавьте сюда запрос для решения задания 5*/

/*Напишите запрос, который вернёт самую большую и самую маленькую 
цену продажи автомобиля с разбивкой по стране без учёта скидки. 
Цена в колонке price дана с учётом скидки.*/

SELECT 
    country AS country, 
    ROUND(MAX((csas.price * 100) / (100 - csas.discount)), 2) AS price_max,
    ROUND(MIN((csas.price * 100) / (100 - csas.discount)), 2) AS price_min
FROM car_shop.auto_sale AS csas
GROUP BY country
ORDER BY price_max DESC;

/*В коде внесла изменения:*/
SELECT 
    c.brand_country AS country, 
    ROUND(MAX(s.price / (1 - s.discount / 100)), 2) AS price_max,
    ROUND(MIN(s.price / (1 - s.discount / 100)), 2) AS price_min
FROM car_shop.auto_sale AS s
LEFT JOIN car_shop.auto_version AS csav ON s.auto_version_id = csav.id
LEFT JOIN car_shop.auto_model AS m ON csav.auto_model = m.auto_model
LEFT JOIN car_shop.auto_brand AS b ON m.auto_brand_id = b.id
LEFT JOIN car_shop.country AS c ON b.country_id = c.id
GROUP BY c.brand_country
ORDER BY price_max DESC;
