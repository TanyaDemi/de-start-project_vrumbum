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
