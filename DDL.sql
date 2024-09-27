/*Добавьте в этот файл все запросы, для создания схемы данных автосалона и
 таблиц в ней в нужном порядке*/

 -- Создание схемы car_shop

CREATE SCHEMA IF NOT EXISTS car_shop;


CREATE SCHEMA IF NOT EXISTS car_shop;

CREATE TABLE IF NOT EXISTS car_shop.country (
    id SERIAL PRIMARY KEY,
    brand_country VARCHAR(100)   
);

CREATE TABLE IF NOT EXISTS car_shop.auto_brand (
    id SERIAL PRIMARY KEY,
    auto_brand VARCHAR(50),
    country_id INT REFERENCES car_shop.country(id)
);


CREATE TABLE IF NOT EXISTS car_shop.cars_color (
    id SERIAL PRIMARY KEY,
    auto_colors VARCHAR(60)
);


CREATE TABLE IF NOT EXISTS car_shop.auto_model (
    id SERIAL PRIMARY KEY,
    auto_model VARCHAR(50),
    cars_color_id INT REFERENCES car_shop.cars_color(id),
    auto_brand_id INT REFERENCES car_shop.auto_brand(id)
);


CREATE TABLE IF NOT EXISTS car_shop.person (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    phone VARCHAR(30)
);


CREATE TABLE IF NOT EXISTS car_shop.auto_version (
    id SERIAL PRIMARY KEY,
    auto_model VARCHAR(50),
    gasoline_consumption NUMERIC(3, 1) NULL,
    cars_color_id INT REFERENCES car_shop.cars_color(id)
);


CREATE TABLE IF NOT EXISTS car_shop.auto_sale (
    id SERIAL PRIMARY KEY,
    price NUMERIC(9, 2) NOT NULL,
    discount NUMERIC(4, 0),
    date DATE NOT NULL,
    country VARCHAR(50),
    auto_version_id INT REFERENCES car_shop.auto_version(id),
    person_id INT REFERENCES car_shop.person(id),
    UNIQUE (price, discount, date, country)
);
