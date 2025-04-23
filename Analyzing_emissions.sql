SELECT DISTINCT Series
FROM C02_Emit;

SELECT MIN(Year), MAX(Year)
FROM C02_Emit;

SELECT MIN(Value), MAX(Value)
FROM C02_Emit
WHERE Series = 'Emissions (thousand metric tons of carbon dioxide)';

SELECT MIN(Value), MAX(Value)
FROM C02_Emit
WHERE Series = 'Emissions per capita (metric tons of carbon dioxide)';

-- 1. Total Emission by Country

SELECT Country, SUM(Value) AS Total_Emissions
FROM C02_Emit
WHERE Series = 'Emissions (thousand metric tons of carbon dioxide)'
GROUP BY Country
ORDER BY Total_Emissions DESC;

-- 2. Yearly Emissions
SELECT Year, SUM(Value) AS Total_Emissions
FROM C02_Emit
WHERE Series = 'Emissions (thousand metric tons of carbon dioxide)'
GROUP BY Year
ORDER BY Total_Emissions ASC;

-- 3. Top 10 countries with Highest Emissions
SELECT Country, SUM(Value) AS Total_Emissions
FROM C02_Emit
WHERE Series = 'Emissions (thousand metric tons of carbon dioxide)'
GROUP BY Country
ORDER BY Total_Emissions DESC
LIMIT 10;

-- 4. Comparison Between Countries

SELECT Country, SUM(Value) AS Total_Emissions
FROM C02_Emit
WHERE Country IN ('gabon', 'nigeria') AND Series = 'Emissions (thousand metric tons of carbon dioxide)'
GROUP BY Country
ORDER BY Country;

-- 5. Year-on-Year Growth in Emissions

SELECT Year, Value AS Emissions,
       LAG(Value) OVER (ORDER BY Year) AS Previous_Year_Emissions,
       (Value - LAG(Value) OVER (ORDER BY Year)) / LAG(Value) OVER (ORDER BY Year) * 100 AS Growth_Percentage
FROM C02_Emit
WHERE Country = 'Algeria' AND Series = 'Emissions (thousand metric tons of carbon dioxide)'
ORDER BY Year;