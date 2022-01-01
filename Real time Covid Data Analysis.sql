SELECT * 
FROM coviddeaths
WHERE continent is not null
ORDER BY 3,4;

-- SELECT * 
-- FROM covidvaccinations
-- ORDER BY 3,4;

-- selecting data that you want to use

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM coviddeaths
ORDER BY 1,2;

-- Let's look at Total Cases vs Total Deaths
-- shows likelihood of dying if you contract covid in your country

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage 
FROM coviddeaths
-- WHERE location LIKE '%india%'
ORDER BY 1,2;

-- Looking at Total cases vs Population
-- shows what percentage of population got Covid

SELECT location, date, total_cases, population, (total_cases/population)*100 as PercentPopulationInfected
FROM coviddeaths
WHERE location LIKE '%india%'
ORDER BY 1,2;

-- Look at countries with Highest Infecion rate compared to population

SELECT location, population, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases/population))*100 as PercentPopulationInfected
FROM coviddeaths
-- WHERE location LIKE '%india%'
GROUP BY location, population
ORDER BY PercentPopulationInfected DESC;

-- Let's Look at Countries with Highest Death Count per population

SELECT location, MAX(CAST(total_deaths AS SIGNED)) AS TotalDeathCount
FROM coviddeaths
-- WHERE location LIKE '%india%'
WHERE continent is not null
GROUP BY location
ORDER BY TotalDeathCount DESC;

-- upto now we used location, 
-- let's use continent to find continent with highest death count per population

SELECT continent, MAX(CAST(total_deaths AS SIGNED)) AS TotalDeathCount
FROM coviddeaths
-- WHERE location LIKE '%india%'
WHERE continent is not null
GROUP BY continent
ORDER BY TotalDeathCount DESC;

-- Global Numbers

SELECT date, SUM(new_cases) AS total_cases, SUM(CAST(new_deaths AS SIGNED)) AS total_deaths, SUM(CAST(new_deaths AS SIGNED))/SUM(new_cases)*100 as DeathPercentage 
FROM coviddeaths
-- WHERE location LIKE '%india%'
WHERE continent is not null
GROUP BY date
ORDER BY 1,2;

-- Global Number of across the World

SELECT SUM(new_cases) AS total_cases, SUM(CAST(new_deaths AS SIGNED)) AS total_deaths, SUM(CAST(new_deaths AS SIGNED))/SUM(new_cases)*100 as DeathPercentage 
FROM coviddeaths
-- WHERE location LIKE '%india%'
WHERE continent is not null
-- GROUP BY date
ORDER BY 1,2;


-- Total Population vs Vaccination

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CAST(vac.new_vaccinations AS SIGNED)) OVER (PARTITION by dea.location ORDER BY dea.location,    -- SUM(CONVERT(int, vac.new_vaccinations)) another method to convert into int
dea.date) as RollingPeopleVaccinated                       
FROM coviddeaths dea
JOIN covidvaccinations vac
   ON dea.location = vac.location
   AND dea.date = vac.date
WHERE dea.continent is not null
order by 2,3

-- use CTE


With PopvsVac (continent, location, date, population, new_vaccinations, RollingPeopleVaccinated)
as
(
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CAST(vac.new_vaccinations AS SIGNED)) OVER (PARTITION by dea.location ORDER BY dea.location,    -- SUM(CONVERT(int, vac.new_vaccinations)) another method to convert into int
dea.date) as RollingPeopleVaccinated                       
FROM coviddeaths dea
JOIN covidvaccinations vac
   ON dea.location = vac.location
   AND dea.date = vac.date
WHERE dea.continent is not null
-- order by 2,3
)
SELECT *, (RollingPeopleVaccinated/population)*100 
FROM PopvsVAac


-- TEMP TABLE
DROP TABLE PercentPopulationVccinated
CREATE TABLE PercentPopulationVccinated
(
continent VARCHAR(50),
location VARCHAR(50), 
date date,
population BIGINT,
new_vaccination BIGINT,
RollingPeopleVaccinated BIGINT
)


INSERT INTO PercentPopulationVccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CAST(vac.new_vaccinations AS SIGNED)) OVER (PARTITION by dea.location ORDER BY dea.location,    -- SUM(CONVERT(int, vac.new_vaccinations)) another method to convert into int
dea.date) as RollingPeopleVaccinated                       
FROM coviddeaths dea
JOIN covidvaccinations vac
   ON dea.location = vac.location
   AND dea.date = vac.date
WHERE dea.continent is not null
order by 2,3

SELECT *, (RollingPeopleVaccinated/population)*100 
FROM PercentPopulationVccinated


-- Create View to store data for later vizualization

CREATE VIEW PopulationVccinatedPERCENT AS 
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CAST(vac.new_vaccinations AS SIGNED)) OVER (PARTITION by dea.location ORDER BY dea.location,    -- SUM(CONVERT(int, vac.new_vaccinations)) another method to convert into int
dea.date) as RollingPeopleVaccinated                       
FROM coviddeaths dea
JOIN covidvaccinations vac
   ON dea.location = vac.location
   AND dea.date = vac.date
WHERE dea.continent is not null
-- order by 2,3



