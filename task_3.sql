/*добавьте сюда запрос для решения задания 3*/

/*Посчитайте среднюю цену всех автомобилей с разбивкой по месяцам в 2022 году 
с учётом скидки. Результат отсортируйте по месяцам в восходящем порядке. 
Среднюю цену округлите до второго знака после запятой.*/

SELECT 
    EXTRACT(MONTH FROM date) AS month,
    ROUND(AVG(price * (1 - discount / 100)), 2) AS price_avg
FROM car_shop.auto_sale
WHERE EXTRACT(YEAR FROM date) = 2022
GROUP BY month
ORDER BY month ASC;
