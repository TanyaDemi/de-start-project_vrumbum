/*добавьте сюда запрос для решения задания 1*/

/*Напишите запрос, который выведет процент моделей машин, 
у которых нет параметра gasoline_consumption.*/

SELECT 
    ROUND((COUNT(id) FILTER (WHERE gasoline_consumption IS NULL) * 100.0) 
    / 
    COUNT(id), 2) AS nulls_percentage_gasoline_consumption
FROM car_shop.auto_version;
