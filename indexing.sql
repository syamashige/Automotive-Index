-- ***** SETTING UP ***** --

-- Create a new postgres user named 'indexed_cars_user'
CREATE ROLE indexed_cars_user;

-- Create a new database named 'indexed_cars' owned by 'indexed_cars_user'
CREATE DATABASE indexed_cars WITH OWNER indexed_cars_user;

-- Run the provided 'scripts/cars_models.sql' scripts on the 'indexed_cars' database
-- Run the provided 'scripts/car_model_data.sql' script on the 'indexed_cars' database 10 times (there should be 223380 rows in 'car_models')

-- ***** TIMING SELECT STATEMENTS ***** --

-- Run a query to get a list of all 'make_title' values from the 'car_models' table where the 'make_code' is 'LAM', without any duplicate rows, and note the time somewhere. (should have 1 result)
SELECT DISTINCT make_title   
    FROM car_models 
    WHERE make_code = 'LAM';
    -- TIME: 22ms


-- Run a query to list all 'model_title' values where the 'make_code' is 'NISSAN' and the 'model_code' is 'GT-R' without any duplicate rows, and note the time somewhere. (should have 1 result)
SELECT DISTINCT model_title 
    FROM car_models
    WHERE make_code = 'NISSAN' AND model_code = 'GT-R';
    -- TIME: 24ms

-- Run a query to list all 'make_code', 'model_code', 'model_title', and year from 'car_models' where the 'make_code' is 'LAM'
SELECT make_code, model_code, model_title, year 
    FROM car_models
    WHERE make_code = 'LAM';
    -- TIME: 32ms

-- Run a query to list all fields from all 'car_models' in years between '2010' and '2015' and note the time somewhere (should have 78840 rows)
SELECT * 
    FROM car_models
    WHERE year BETWEEN 2010 AND 2015;
    -- TIME: 321ms

-- Run a query to list all fields from all 'car_models' in the year of '2010', and note the time somewhere(should have 13140 rows)
SELECT * 
    FROM car_models
    WHERE year = '2010';
    -- TIME: 68ms

-- ***** INDEXING ***** -- 

-- Create a query to get a list of all 'make_title' values from the 'car_models' table where the 'make_code' is 'LAM', without any duplicate rows
CREATE INDEX make_title_only ON car_models(make_title) WHERE make_code = 'LAM';
-- TIME: 2ms

-- Create a query to list all 'model_title' values where the 'make_code' is 'NISSAN' and the 'model_code' is 'GT-R' without any duplicate rows
CREATE INDEX nissan_model_title ON car_models(model_title) WHERE make_code = 'NISSAN';
-- TIME: 2ms

-- Create a query to list 'make_code', 'model_code', 'model_stitle', and year from 'car_models' where the 'make_code' is 'LAM'
CREATE INDEX lam_index ON car_models(make_code, model_code, model_title, year) WHERE make_code = 'LAM';
-- TIME: 8ms

-- Create a query to list all fields from all 'car_models' in years between '2010' and '2015'
CREATE INDEX everything_index ON car_models(id, make_code, make_title, model_code, model_title, year) WHERE year BETWEEN '2010' AND '2015';
-- TIME: 288ms

-- Create a query to list all fields from all 'car_models' in the year of '2010'
CREATE INDEX everything_models ON car_models(id, make_code, make_title, model_code, model_title, year) WHERE year = '2010';
-- TIME: 58ms


