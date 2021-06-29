

USE covid;

CREATE TABLE allcountries_death AS
SELECT*
FROM china_deaths 
UNION
SELECT*
FROM india_deaths
UNION 
SELECT*
FROM russia_deaths
UNION 
SELECT*
FROM northamerica_deaths
UNION
SELECT*
FROM syria_deaths
UNION
SELECT*
FROM uk_deaths
UNION SELECT*
FROM italy_deaths
UNION 
SELECT*
FROM france_deaths
UNION
SELECT*
FROM australia_deaths



-- selecting significant attributes

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM allcountries_death 

-- looking at total cases vs total deaths
-- shows likelihood of dying if someone contact covid in your country

SELECT location, date, total_cases, new_cases, total_deaths, (total_deaths/ total_cases) * 100 as DeathPercentage
FROM allcountries_death

/*there was meagre deline in death percentage ( not symbolising something good) because total cases
 were increasing at a higher rate compared to total deaths. It meant that we would we would encounter increase in death percentage
 in the near future and the same thing was physically seen.*/

-- looking at Total cases vs Population for India

SELECT location, date, total_cases, population, (total_cases/ population) * 100 as InfectionPercentage
FROM allcountries_death
WHERE location = 'India'

/* India reached the largest number of cases after August as compared to data analyzed before it*/

-- looking at countries with highest infection rate

SELECT location, MAX(total_cases) AS
HighestInfectionCount, population, MAX((total_cases/ population)) * 100 as InfectionPercentage
FROM allcountries_death
GROUP BY location
ORDER BY InfectionPercentage DESC

-- showing the countries with (their) highest death count during and after August
USE covid;

SELECT location, total_deaths  
 FROM allcountries_death
 WHERE date > '8-1-2020'
 GROUP BY location

--  comparison of the progression of deaths in India and North America 
 SELECT
 nd.location, nd.total_deaths, id.location, id.total_deaths
FROM northamerica_deaths nd
JOIN india_deaths id ON nd.date = id.date

/* initia rise in in toal deaths in India was slow compared to North America due to stricter restrictions in the beginning*/


-- analysing how cases smoothed after the first time covid was contacted(just due to natural immune response)
-- post February, 2020

SELECT
location, date, new_cases_smoothed
FROM allcountries_death
WHERE date > '28-02-2020'


-- because greater infection initially in China(being the source of disease), some people developed immunity early
-- ignoring the naturally greater population of China, this is one of the probable causes
-- In other countries, the cases smoothed gradually becasue of the fact that covid had started spreading

/* analysing medical care offered to patients as the disease progressed ( contrbution of natural immune response 
ignored while making this analogy)*/

SELECT location, total_deaths, new_cases_smoothed
FROM allcountries_death

/* Medical care across countries was better ostly because patient load was less although
it increased exponentially as the disease progressed*/ 



 
 



