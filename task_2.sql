/*добавьте сюда запрос для решения задания 2*/

/*Напишите запрос, который покажет название бренда и среднюю цену его автомобилей 
в разбивке по всем годам с учётом скидки. Итоговый результат отсортируйте по 
названию бренда и году в восходящем порядке. Среднюю цену округлите до второго 
знака после запятой.*/

SELECT 
    b.auto_brand AS brand_name,
    EXTRACT(YEAR FROM s.date) AS year,
    ROUND(AVG(s.price * (1 - s.discount / 100)), 2) AS price_avg
FROM car_shop.auto_sale AS s
LEFT JOIN car_shop.auto_version AS csav ON s.auto_version_id = csav.id
LEFT JOIN car_shop.auto_model AS m ON csav.auto_model = m.auto_model
LEFT JOIN car_shop.auto_brand AS b ON m.auto_brand_id = b.id
GROUP BY b.auto_brand, year
ORDER BY b.auto_brand ASC, year ASC;
