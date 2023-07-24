--TOTAL MUSEUMS
SELECT COUNT([Museum Name]) AS [TOTAL MUSEUMS] 
FROM museums$

--TOP 10 STATES WITH MOST MUSEUMS
SELECT TOP 10 [State (Administrative Location)] ,COUNT([State (Administrative Location)]) AS [TOTAL MUSEUMS]
FROM museums$
GROUP BY [State (Administrative Location)]
ORDER BY [TOTAL MUSEUMS] DESC

--MUSEUMS BELONGS TO UNIVERSITY ONLY
SELECT [Museum Name],[Institution Name] 
FROM museums$
WHERE [Institution Name] LIKE 'U%NIVERSITY%'

SELECT COUNT([Museum Name]) AS [TOTAL UNIVERSITIES MUSEUMS]
FROM museums$
WHERE [Institution Name] LIKE 'U%NIVERSITY%'

--CATEGORY WITH MOST MUSEUMS
SELECT [Museum Type], COUNT ([Museum Type]) AS [TOTAL MUSEUMS] 
FROM museums$
GROUP BY [Museum Type]
ORDER BY [TOTAL MUSEUMS] 

--MUSEUM WITH HIGHEST REVENUE
SELECT TOP 10 [Museum Name],[Museum Type],[Institution Name],Revenue 
FROM museums$
ORDER BY Revenue DESC

--MUSEUM WITH LOWEST REVENUE
SELECT TOP 10 [Museum Name],[Museum Type],[Institution Name],Revenue 
FROM museums$
WHERE Revenue IS NOT NULL AND [Institution Name] IS NOT NULL
ORDER BY Revenue

--MUSEUMS AVERAGE REVENUE
SELECT  [Museum Name],[Museum Type],[Institution Name],(SELECT AVG(Revenue) FROM museums$) AS [AVERAGE REVENUE] 
FROM museums$
WHERE Revenue IS NOT NULL AND [Institution Name] IS NOT NULL
GROUP BY  [Museum Name],[Museum Type],[Institution Name],Revenue


