/*Добавьте в этот файл запросы, которые наполняют данными таблицы в схеме автосалона*/


INSERT INTO car_shop.country (brand_country)
SELECT DISTINCT COALESCE(brand_origin, 'Not Info')
FROM raw_data.sales
ORDER BY COALESCE(brand_origin, 'Not Info');


INSERT INTO car_shop.auto_brand (auto_brand, country_id)
SELECT DISTINCT
    SPLIT_PART(rds.auto, ' ', 1) AS brand,
    csc.id AS country_id
FROM raw_data.sales rds
JOIN car_shop.country csc
    ON COALESCE(rds.brand_origin, 'Not Info') = csc.brand_country
ORDER BY brand;


INSERT INTO car_shop.cars_color (auto_colors)
SELECT DISTINCT 
    TRIM(SPLIT_PART(auto, ',', 2)) AS auto_colors
FROM raw_data.sales
ORDER BY auto_colors;


INSERT INTO car_shop.auto_model (auto_model, cars_color_id, auto_brand_id)
SELECT 
    TRIM(SPLIT_PART(SPLIT_PART(rds.auto, ',', 1), ' ', 2)) || 
    CASE WHEN LENGTH(SPLIT_PART(SPLIT_PART(rds.auto, ',', 1), ' ', 3)) > 0 
         THEN ' ' || SPLIT_PART(SPLIT_PART(rds.auto, ',', 1), ' ', 3)
         ELSE ''
    END AS auto_model,
    cscc.id AS cars_color_id,
    csab.id AS auto_brand_id
FROM raw_data.sales rds
JOIN car_shop.auto_brand csab 
    ON SPLIT_PART(rds.auto, ' ', 1) = csab.auto_brand
JOIN car_shop.cars_color cscc
    ON TRIM(SPLIT_PART(rds.auto, ',', 2)) = cscc.auto_colors
GROUP BY auto_model, cars_color_id, auto_brand_id
ORDER BY auto_model;


INSERT INTO car_shop.person (first_name, last_name, phone)
SELECT DISTINCT ON (TRIM(BOTH ' ' FROM SPLIT_PART(rds.person, ' ', 1)), 
                    INITCAP(TRIM(BOTH ' ' FROM SPLIT_PART(rds.person, ' ', 2))), 
                    rds.phone)
    TRIM(BOTH ' ' FROM SPLIT_PART(rds.person, ' ', 1)) AS first_name,
    INITCAP(TRIM(BOTH ' ' FROM SPLIT_PART(rds.person, ' ', 2))) AS last_name,
    rds.phone
FROM raw_data.sales rds
JOIN car_shop.auto_brand csab 
    ON SPLIT_PART(rds.auto, ' ', 1) = csab.auto_brand
ORDER BY first_name, last_name, phone;


INSERT INTO car_shop.auto_version (auto_model, gasoline_consumption, cars_color_id)
SELECT DISTINCT
    csam.auto_model AS auto_model,
    rds.gasoline_consumption,
    cscc.id
FROM raw_data.sales rds
JOIN car_shop.auto_model csam ON TRIM(SPLIT_PART(SPLIT_PART(rds.auto, ',', 1), ' ', 2)) || 
    CASE WHEN LENGTH(TRIM(SPLIT_PART(SPLIT_PART(rds.auto, ',', 1), ' ', 3))) > 0 
         THEN ' ' || TRIM(SPLIT_PART(SPLIT_PART(rds.auto, ',', 1), ' ', 3))
         ELSE ''
    END = csam.auto_model
JOIN car_shop.cars_color cscc ON TRIM(BOTH ' ' FROM SPLIT_PART(rds.auto, ',', 2)) = cscc.auto_colors
ORDER BY csam.auto_model;


INSERT INTO car_shop.auto_sale (price, discount, date, country, auto_version_id, person_id)
SELECT DISTINCT
    rds.price,
    rds.discount,
    rds.date,
    rds.brand_origin,
    csav.id AS auto_version_id,
    csp.id AS person_id
FROM raw_data.sales rds
RIGHT JOIN car_shop.auto_version csav
    ON TRIM(SPLIT_PART(SPLIT_PART(rds.auto, ',', 1), ' ', 2)) || 
    CASE WHEN LENGTH(TRIM(SPLIT_PART(SPLIT_PART(rds.auto, ',', 1), ' ', 3))) > 0 
         THEN ' ' || TRIM(SPLIT_PART(SPLIT_PART(rds.auto, ',', 1), ' ', 3))
         ELSE ''
    END = csav.auto_model
RIGHT JOIN car_shop.person csp 
    ON rds.phone = csp.phone
ON CONFLICT (price, discount, date, country)
DO NOTHING;
