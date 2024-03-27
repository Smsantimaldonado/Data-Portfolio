-- Step 1: Create the database
CREATE DATABASE weatherAUS;
USE weatherAUS;

-- Step 2: Create the table
IF OBJECT_ID('weather_AUS') IS NOT NULL DROP TABLE weather_AUS;

CREATE TABLE weather_AUS
([Date] DATE,
[Location] NVARCHAR(200),
MinTemp FLOAT,
MaxTemp FLOAT,
Rainfall FLOAT,
Evaporation FLOAT,
Sunshine FLOAT,
WindGustDir NVARCHAR(5),
WindGustSpeed FLOAT,
WindDir9am NVARCHAR(5),
WindDir3pm NVARCHAR(5),
WindSpeed9am FLOAT,
WindSpeed3pm FLOAT,
Humidity9am FLOAT,
Humidity3pm FLOAT,
Pressure9am FLOAT,
Pressure3pm FLOAT,
Cloud9am FLOAT,
Cloud3pm FLOAT,
Temp9am FLOAT,
Temp3pm FLOAT,
RainToday NVARCHAR(5),
RainTomorrow NVARCHAR(5)
);

SELECT * FROM weather_AUS

-- Step 3: Import the Data

BULK INSERT weather_AUS
FROM 'C:\Users\User\Desktop\weatherAUS_modified.csv'
WITH (FORMAT='CSV');

SELECT * FROM weather_AUS;