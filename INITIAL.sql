/*сохраните в этом файле запросы для первоначальной загрузки данных - 
создание схемы raw_data и таблицы sales и наполнение их данными из csv файла*/

-- Создание схемы raw_data 
CREATE SCHEMA IF NOT EXISTS raw_data;


 -- Создание таблицы sales 
CREATE TABLE IF NOT EXISTS raw_data.sales (
    id SERIAL PRIMARY KEY,
    auto VARCHAR(100), 
    gasoline_consumption NUMERIC(3, 1) NULL,
    price NUMERIC(9, 2) NOT NULL,
    date DATE NOT NULL,
    person VARCHAR(100),
    phone VARCHAR(30),
    discount NUMERIC(4, 0),
    brand_origin VARCHAR(100)
);


-- Заполнение таблицы sales данными в DBeaver
INSERT INTO raw_data.sales (id, auto, gasoline_consumption, price, date, person, phone, discount, brand_origin)
VALUES 
(1, 'Lada Vesta, grey', 7.3, 11243.44, '2019-12-15', 'Michael Wu', '+1-587-114-0889x3149', 20, 'Russia'),
(2, 'BMW F80, red', 8.3, 63761.75, '2019-01-29', 'Carla Smith', '001-818-501-7528x0438', 0, 'Germany');
… и так далее до 1000 строк.

-- Заполнение таблицы sales данными в psql
\copy raw_data.sales (id, auto, gasoline_consumption, price, sale_date, person, phone, discount, brand_origin) FROM 'C:\Temp\cars.csv' WITH (FORMAT csv, HEADER, DELIMITER ',', NULL 'null');
