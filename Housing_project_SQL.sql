CREATE DATABASE IF NOT EXISTS housing_affordability;

USE housing_affordability;

CREATE TABLE IF NOT EXISTS analysis_universe (
    municipality_code VARCHAR(10) NOT NULL,
    municipality VARCHAR(100),
    population INT,
    municipality_code_idescat VARCHAR(10),
    municipality_code_habitatge VARCHAR(10),
    PRIMARY KEY (municipality_code)
);


CREATE TABLE IF NOT EXISTS population_analysis (
    municipality_code VARCHAR(10) NOT NULL,
    municipality VARCHAR(100),
    year SMALLINT NOT NULL,
    population INT,
    PRIMARY KEY (municipality_code, year),
    FOREIGN KEY (municipality_code)
        REFERENCES analysis_universe(municipality_code)
);


CREATE TABLE IF NOT EXISTS sales_analysis (
    municipality_code VARCHAR(10) NOT NULL,
    sales_new_free INT,
    sales_new_protected INT,
    sales_used INT,
    sales_total INT,
    surface_new_free DOUBLE,
    surface_new_protected DOUBLE,
    surface_used DOUBLE,
    surface_total DOUBLE,
    price_new DOUBLE,
    price_used DOUBLE,
    price_total DOUBLE,
    price_m2_new DOUBLE,
    price_m2_used DOUBLE,
    price_m2_total DOUBLE,
    municipality_code_source VARCHAR(20),
    year SMALLINT NOT NULL,
    municipality VARCHAR(100),
    PRIMARY KEY (municipality_code, year),
    FOREIGN KEY (municipality_code)
        REFERENCES analysis_universe(municipality_code)
);

CREATE TABLE IF NOT EXISTS rent_analysis (
    municipality_code VARCHAR(10) NOT NULL,
    municipality VARCHAR(100),
    comarca VARCHAR(100),
    rent_mean DECIMAL(12,2),
    municipality_code_source VARCHAR(20),
    year SMALLINT NOT NULL,
    PRIMARY KEY (municipality_code, year),
    FOREIGN KEY (municipality_code)
        REFERENCES analysis_universe(municipality_code)
);

CREATE TABLE IF NOT EXISTS income_analysis (
    municipality_code VARCHAR(10) NOT NULL,
    municipality VARCHAR(100),
    year SMALLINT NOT NULL,
    income_thousand_eur DECIMAL(12,3),
    income_per_capita_eur DECIMAL(12,2),
    income_index_catalonia DECIMAL(8,2),
    PRIMARY KEY (municipality_code, year),
    FOREIGN KEY (municipality_code)
        REFERENCES analysis_universe(municipality_code)
);

CREATE TABLE IF NOT EXISTS activity_analysis (
    municipality_code VARCHAR(10) NOT NULL,
    municipality VARCHAR(100),
    year SMALLINT NOT NULL,
    PO_EMP INT,
    PO_UNE INT,
    PO_ACTT INT,
    PRIMARY KEY (municipality_code, year),
    FOREIGN KEY (municipality_code)
        REFERENCES analysis_universe(municipality_code)
);

CREATE TABLE IF NOT EXISTS demographic_analysis (
    municipality_code VARCHAR(10) NOT NULL,
    municipality VARCHAR(100),
    year SMALLINT NOT NULL,
    AGE_MEAN DECIMAL(5,2),
    AGE_MED DECIMAL(5,2),
    PP_YO_15 DECIMAL(5,2),
    OPP_Y16_64 DECIMAL(5,2),
    PP_Y_GE65 DECIMAL(5,2),
    PRIMARY KEY (municipality_code, year),
    FOREIGN KEY (municipality_code)
        REFERENCES analysis_universe(municipality_code)
);


CREATE TABLE IF NOT EXISTS distance_analysis (
    municipality_code VARCHAR(10) NOT NULL,
    municipality VARCHAR(100),
    distance_to_barcelona_km DECIMAL(10,6),
    distance_to_girona_km DECIMAL(10,6),
    distance_to_tarragona_km DECIMAL(10,6),
    distance_to_lleida_km DECIMAL(10,6),
    PRIMARY KEY (municipality_code),
    FOREIGN KEY (municipality_code)
        REFERENCES analysis_universe(municipality_code)
);

-- General tables

CREATE TABLE IF NOT EXISTS contracts_by_year (
    year SMALLINT NOT NULL PRIMARY KEY,
    contracts INT,
    quarters_reported TINYINT,
    year_complete BOOLEAN
);


CREATE TABLE IF NOT EXISTS mortgages_by_year (
    year SMALLINT NOT NULL PRIMARY KEY,
    mortgages_thousands DECIMAL(10,2),
    provisional BOOLEAN,
    capital_billion_eur DECIMAL(12,3),
    mortgages_estimated INT
);

-- Metrics table
CREATE TABLE metricas_municipales_completo (
    municipality_code VARCHAR(10) NOT NULL,
    municipality VARCHAR(100),
    year SMALLINT NOT NULL,
    price_m2_total DECIMAL(12,2),
    income_per_capita_eur DECIMAL(12,2),
    rent_mean DECIMAL(12,6),
    estimated_dwelling_price_90m2_eur DECIMAL(14,2),
    PER DECIMAL(12,6),
    income_monthly_per_capita_eur DECIMAL(12,6),
    effort_rent_pct DECIMAL(8,2),
    interest_rate_pct DECIMAL(6,3),
    estimated_purchase_mortgage_eur DECIMAL(14,2),
    estimated_monthly_purchase_payment_eur DECIMAL(12,2),
    effort_purchase_pct DECIMAL(8,2),
    PRIMARY KEY (municipality_code, year)
);


-- Insert data to the tables. 
LOAD DATA LOCAL INFILE 'C:/Users/jejoc/Desktop/Ironhack/Final Project/Clean_data/analysis_universe.csv'
INTO TABLE analysis_universe
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
    municipality_code,
    municipality,
    population,
    municipality_code_idescat,
    municipality_code_habitatge
);

LOAD DATA LOCAL INFILE 'C:/Users/jejoc/Desktop/Ironhack/Final Project/Clean_data/population_analysis.csv'
INTO TABLE population_analysis
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
    municipality_code,
    municipality,
    year,
    population
);

LOAD DATA LOCAL INFILE 'C:/Users/jejoc/Desktop/Ironhack/Final Project/Clean_data/sales_analysis.csv'
INTO TABLE sales_analysis
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
    municipality_code,
    sales_new_free,
    sales_new_protected,
    sales_used,
    sales_total,
    surface_new_free,
    surface_new_protected,
    surface_used,
    surface_total,
    price_new,
    price_used,
    price_total,
    price_m2_new,
    price_m2_used,
    price_m2_total,
    municipality_code_source,
    year,
    municipality
);

LOAD DATA LOCAL INFILE 'C:/Users/jejoc/Desktop/Ironhack/Final Project/Clean_data/rent_analysis.csv'
INTO TABLE rent_analysis
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
    municipality_code,
    municipality,
    comarca,
    rent_mean,
    municipality_code_source,
    year
);
LOAD DATA LOCAL INFILE 'C:/Users/jejoc/Desktop/Ironhack/Final Project/Clean_data/income_analysis.csv'
INTO TABLE income_analysis
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
    municipality_code,
    municipality,
    year,
    income_thousand_eur,
    income_per_capita_eur,
    income_index_catalonia
);

LOAD DATA LOCAL INFILE 'C:/Users/jejoc/Desktop/Ironhack/Final Project/Clean_data/activity_analysis.csv'
INTO TABLE activity_analysis
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
    municipality_code,
    municipality,
    year,
    PO_EMP,
    PO_UNE,
    PO_ACTT
);

LOAD DATA LOCAL INFILE 'C:/Users/jejoc/Desktop/Ironhack/Final Project/Clean_data/demographic_analysis.csv'
INTO TABLE demographic_analysis
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
    municipality_code,
    municipality,
    year,
    AGE_MEAN,
    AGE_MED,
    PP_YO_15,
    OPP_Y16_64,
    PP_Y_GE65
);

TRUNCATE TABLE contracts_by_year;

LOAD DATA LOCAL INFILE 'C:/Users/jejoc/Desktop/Ironhack/Final Project/Clean_data/distance_analysis.csv'
INTO TABLE distance_analysis
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
    municipality_code,
    municipality,
    distance_to_barcelona_km,
    distance_to_girona_km,
    distance_to_tarragona_km,
    distance_to_lleida_km
);

LOAD DATA LOCAL INFILE 'C:/Users/jejoc/Desktop/Ironhack/Final Project/Clean_data/contracts_by_year.csv'
INTO TABLE contracts_by_year
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
    year,
    contracts,
    quarters_reported,
    @year_complete
)
SET year_complete = CASE
    WHEN @year_complete = 'True' THEN 1
    WHEN @year_complete = 'False' THEN 0
    ELSE NULL
END;

TRUNCATE TABLE mortgages_by_year;

LOAD DATA LOCAL INFILE 'C:/Users/jejoc/Desktop/Ironhack/Final Project/Clean_data/mortgages_by_year.csv'
INTO TABLE mortgages_by_year
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
    year,
    mortgages_thousands,
    @provisional,
    capital_billion_eur,
    mortgages_estimated
)
SET provisional = CASE
    WHEN @provisional = 'True' THEN 1
    WHEN @provisional = 'False' THEN 0
    ELSE NULL
END;

ALTER TABLE metricas_municipales_completo
    MODIFY COLUMN effort_rent_pct DECIMAL(12,6),
    MODIFY COLUMN estimated_monthly_purchase_payment_eur DECIMAL(14,6),
    MODIFY COLUMN effort_purchase_pct DECIMAL(12,6);

TRUNCATE TABLE metricas_municipales_completo;

LOAD DATA LOCAL INFILE 'C:/Users/jejoc/Desktop/Ironhack/Final Project/Clean_data/metricas_affordability_csv/metricas_municipales_completo.csv'
INTO TABLE metricas_municipales_completo
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
    municipality_code,
    municipality,
    year,
    price_m2_total,
    income_per_capita_eur,
    rent_mean,
    estimated_dwelling_price_90m2_eur,
    PER,
    income_monthly_per_capita_eur,
    effort_rent_pct,
    interest_rate_pct,
    estimated_purchase_mortgage_eur,
    estimated_monthly_purchase_payment_eur,
    effort_purchase_pct
);

SHOW TABLES;