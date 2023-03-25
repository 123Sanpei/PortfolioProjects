
/*
Covid 19 Data Exploration 

Skills used: Joins, Update Tables, Aggregate Functions, GROUP BY, Converting Data Types
*/

USE covid;

-- Showing the tables

SELECT * 
FROM Country_Info
ORDER BY location, date;

SELECT * 
FROM Covid_Info
ORDER BY location, date;

SELECT *
FROM Vaccine_Info
ORDER BY location, date;

-- Update total cases and total deaths to have null values instead of zeros 
UPDATE Covid_Info
SET total_cases = NULL
WHERE total_cases =  0;

UPDATE Covid_Info
SET total_deaths = NULL
WHERE total_deaths =  0;


-- Total Cases vs Population, Total Deaths vs Total Cases and Total Deaths vs Population in Italy

SELECT 
	coun.location, 
	coun.date, 
	coun.population,
	cov.total_cases,
	cov.total_deaths, 
	ROUND((CONVERT(FLOAT,cov.total_cases ) / coun.population)*100,4) AS pop_infected_percentage,
	ROUND((CONVERT(FLOAT,cov.total_deaths ) / cov.total_cases)*100,4) AS death_percentage,
	ROUND((CONVERT(FLOAT,cov.total_deaths ) / coun.population)*100,4) AS total_death_percentage
FROM Country_Info coun
JOIN Covid_Info cov
ON coun.location = cov.location AND coun.date = cov.date
WHERE coun.location = 'Italy' 
ORDER BY coun.date;

-- Covid tests and hospitalization in Italy

SELECT 
	coun.location, 
	coun.date, 
	cov.total_tests,
	cov.new_tests,
	cov.positive_rate, 
	cov.hosp_patients,
	cov.icu_patients
FROM Country_Info coun
JOIN Covid_Info cov
ON coun.location = cov.location AND coun.date = cov.date
WHERE coun.location = 'Italy' 
ORDER BY coun.date;

-- Vaccinations in Italy

SELECT 
	coun.location, 
	coun.date, 
	coun.population,
	vac.total_vaccinations,
	vac.new_vaccinations,
	vac.people_vaccinated,
	vac.people_fully_vaccinated, 
	ROUND((CONVERT(FLOAT,vac.people_fully_vaccinated) / coun.population)*100,4) AS people_fully_vaccinated_percentage,
	vac.total_boosters	
FROM Country_Info coun
JOIN Vaccine_Info vac
ON coun.location = vac.location AND coun.date = vac.date
WHERE coun.location = 'Italy' AND vac.total_vaccinations > 0
ORDER BY coun.date;

-- Countries with Highest Infection Rate compared to Population

SELECT 
	coun.location, 
	coun.population,
	MAX(cov.total_cases) AS highest_infection_count,
	ROUND(MAX((CONVERT(FLOAT,cov.total_cases ) / coun.population)*100),2) AS pop_infected_percentage
FROM Country_Info coun
JOIN Covid_Info cov
ON coun.location = cov.location AND coun.date = cov.date
WHERE coun.continent!=''
GROUP BY coun.location, coun.population
ORDER BY pop_infected_percentage DESC;

-- Countries with Highest Death Rate compared to Population

SELECT 
	coun.location, 
	coun.population,
	MAX(cov.total_deaths) AS total_deaths,
	ROUND(MAX((CONVERT(FLOAT,cov.total_deaths ) / coun.population)*100),2) AS total_death_percentage
FROM Country_Info coun
JOIN Covid_Info cov
ON coun.location = cov.location AND coun.date = cov.date
WHERE coun.continent!=''
GROUP BY coun.location, coun.population
ORDER BY total_death_percentage DESC;

-- Countries with Highest Vaccination rates

SELECT 
	coun.location, 
	coun.population,
	MAX(vac.people_vaccinated) AS people_vaccinated,
	MAX(vac.people_fully_vaccinated) AS people_fully_vaccinated,
	ROUND(MAX((CONVERT(FLOAT,vac.people_fully_vaccinated ) / coun.population)*100),2) AS people_fully_vaccinated_percentage
FROM Country_Info coun
JOIN Vaccine_Info vac
ON coun.location = vac.location AND coun.date = vac.date
WHERE coun.continent!=''
GROUP BY coun.location, coun.population
ORDER BY people_fully_vaccinated_percentage DESC;

-- median age of countries with the highest death rates

SELECT 
	coun.location,	
	coun.median_age, 
	MAX(cov.total_deaths) AS total_deaths,
	ROUND(MAX((CONVERT(FLOAT,cov.total_deaths ) / coun.population)*100),4) AS total_death_percentage
FROM Country_Info coun
JOIN Covid_Info cov
ON coun.location = cov.location AND coun.date = cov.date
WHERE coun.continent!=''
GROUP BY coun.location, coun.median_age
ORDER BY total_death_percentage DESC;


-- Showing contintents with the highest infection count and highest death count 

SELECT 
	coun.location, 
	MAX(coun.population) AS population,
	MAX(cov.total_cases) AS highest_infection_count, 
	ROUND(MAX((CONVERT(FLOAT,cov.total_cases) / population)*100),2) AS infection_percentage,
	MAX(cov.total_deaths) AS total_deaths,
	ROUND(MAX((CONVERT(FLOAT,cov.total_deaths) / population)*100),2) AS total_deaths_percentage
FROM Country_Info coun
JOIN Covid_Info cov
ON coun.location = cov.location AND coun.date = cov.date
WHERE coun.continent = ''
GROUP BY coun.location
HAVING coun.location !='High income' AND coun.location !='Upper middle income' AND coun.location !='Lower middle income' AND coun.location !='Low income'
ORDER BY infection_percentage DESC;

-- Showing contintents with the highest vaccination rates

SELECT 
	coun.location, 
	MAX(coun.population) AS population,
	MAX(vac.people_vaccinated) AS people_vaccinated, 
	MAX(vac.people_fully_vaccinated) AS people_fully_vaccinated,
	ROUND(MAX((CONVERT(FLOAT,vac.people_fully_vaccinated ) / population)*100),2) AS people_fully_vaccinated_percentage
FROM Country_Info coun
JOIN Vaccine_Info vac
ON coun.location = vac.location AND coun.date = vac.date
WHERE coun.continent = ''
GROUP BY coun.location
HAVING coun.location !='High income' AND coun.location !='Upper middle income' AND coun.location !='Lower middle income' AND coun.location !='Low income'
ORDER BY people_fully_vaccinated_percentage DESC;