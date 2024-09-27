/*добавьте сюда запрос для решения задания 4*/

/*Используя функцию STRING_AGG, напишите запрос, который выведет 
список купленных машин у каждого пользователя через запятую. 
Пользователь может купить две одинаковые машины — это нормально. 
Название машины покажите полное, с названием бренда — например: 
Tesla Model 3. Отсортируйте по имени пользователя в восходящем 
порядке. Сортировка внутри самой строки с машинами не нужна.*/

SELECT 
    p.first_name || ' ' || p.last_name AS person,
    STRING_AGG(TRIM(SPLIT_PART(s.auto, ',', 1)), ', ') AS cars
FROM raw_data.sales AS s
JOIN car_shop.person AS p USING(phone)
GROUP BY p.first_name, p.last_name
ORDER BY person ASC;
