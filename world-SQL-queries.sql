
-- Query 1
SELECT c.Name AS CountryName, g.BUDGET AS GovernmentBudget,  
c.GNP AS GrossNationalProduct  
FROM Country c  
JOIN Government g ON c.Code = g.CountryCode;

-- Query 2
SELECT c.Name AS CountryName, c.Population AS CountryPopulation,  
ci.Name AS CityName, ci.Population AS CityPopulation  
FROM Country c  
JOIN City ci ON c.Code = ci.CountryCode; 

-- Query 3
SELECT c.Name AS CountryName, cl.Language, cl.IsOfficial, cl.Percentage  
FROM Country c  
JOIN CountryLanguage cl ON c.Code = cl.CountryCode  
WHERE  
cl.Percentage = (  
SELECT MAX(cl2.Percentage)  
FROM CountryLanguage cl2  
WHERE cl2.CountryCode = c.Code  
); 

-- Query 4
SELECT c.Name AS CountryName, cu.ExchangeRateToUSD, c.Population  
FROM Country c  
JOIN Currency cu ON c.Code = cu.CountryCode; 

-- Query 5
SELECT c.Name AS CountryName, g.BUDGET, g.ActiveMilitary  
FROM Country c  
JOIN Government g ON c.Code = g.CountryCode; 

-- Query 6
SELECT c.Name AS CountryName, c.LifeExpectancy, c.GNP  
FROM Country c  
WHERE c.LifeExpectancy > 70;

-- Query 7
SELECT c.Name AS CountryName, g.ActiveMilitary, r.ReligionName, r.PercentFollowing  
FROM Country c  
JOIN Government g ON c.Code = g.CountryCode  
JOIN Religion r ON c.Code = r.CountryCode; 

-- Query 8
SELECT c.Name AS CountryName, COUNT(DISTINCT ci.ID) AS NumCities, COUNT(DISTINCT cl.Language) AS NumLanguages  
FROM Country c  
LEFT JOIN City ci ON c.Code = ci.CountryCode  
LEFT JOIN CountryLanguage cl ON c.Code = cl.CountryCode  
GROUP BY c.Name; 

-- Query 9
SELECT c.Name AS CountryName, g.ActiveMilitary, c.Population  
FROM Country c  
JOIN Government g ON c.Code = g.CountryCode;

-- Query 10
SELECT c.Name AS CountryName, r.ReligionName, r.PercentFollowing AS ReligionPercent,  
cl.Language, cl.Percentage AS LanguagePercent  
FROM Country c  
JOIN Religion r ON c.Code = r.CountryCode  
JOIN CountryLanguage cl ON c.Code = cl.CountryCode; 

-- Query 11
SELECT Name, Population  
FROM   Country  
WHERE  Code IN (SELECT Code  
                FROM   (SELECT Code  
                        FROM   Country  
                        ORDER  BY Population DESC  
                        LIMIT 5) AS top5);

-- Query 12
SELECT Name, Continent, GNP  
FROM   Country c  
WHERE  GNP > (SELECT AVG(GNP)  
              FROM   Country  
              WHERE  Continent = c.Continent);

-- Query 13
SELECT Name AS Country  
FROM Country  
WHERE (SELECT Population  
       FROM City  
       WHERE ID = Country.Capital) > Country.Population * 0.25;

-- Query 14
SELECT Name  
FROM   Country  
WHERE  90 < (SELECT MAX(PercentFollowing)  
             FROM   Religion  
             WHERE  CountryCode = Country.Code);

-- Query 15
SELECT Name AS Currency, ExchangeRateToUSD  
FROM   Currency  
WHERE  ExchangeRateToUSD < (SELECT AVG(ExchangeRateToUSD) FROM Currency);

-- Query 16
SELECT DISTINCT cl.Language  
FROM CountryLanguage cl  
WHERE cl.IsOfficial = 'T'  
  AND (SELECT SUM(Population)  
        FROM Country  
        WHERE Code IN (SELECT CountryCode  
                        FROM CountryLanguage  
                        WHERE Language = cl.Language AND IsOfficial='T'))  
      > (SELECT AVG(Population) FROM Country);

-- Query 17
SELECT DISTINCT Continent  
FROM   Country c1  
WHERE  (SELECT AVG(LifeExpectancy)  
        FROM   Country  
        WHERE  Continent = c1.Continent)  
      < (SELECT AVG(LifeExpectancy) FROM Country);

-- Query 18
SELECT Name, Region  
FROM   Country  
WHERE  (SELECT BUDGET  
        FROM   Government  
        WHERE  CountryCode = Country.Code)  
      < (SELECT AVG(g2.BUDGET)  
         FROM   Country    c2  
         JOIN   Government g2 ON g2.CountryCode = c2.Code  
         WHERE  c2.Region = Country.Region);

-- Query 19
SELECT Name  
FROM   Country  
WHERE  3 < (SELECT COUNT(*)  
            FROM   Religion  
            WHERE  CountryCode = Country.Code);

-- Query 20
SELECT CurrencyCode, Name, CountriesUsedCount  
FROM   Currency  
WHERE  CurrencyCode IN (SELECT CurrencyCode  
                        FROM   (SELECT CurrencyCode  
                                FROM   Currency  
                                ORDER  BY CountriesUsedCount DESC  
                                LIMIT 3) AS top3);

