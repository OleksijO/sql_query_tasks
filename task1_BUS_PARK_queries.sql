-- All expenses for every line(bus route) for whole period
SELECT SUM(BUS_EXPENSE.AMOUNT) AS EXPENSES,
  ROUTE.LINE_NUMBER,
  ROUTE.PATH
FROM BUS_EXPENSE
INNER JOIN ROUTE_LOG
ON ROUTE_LOG.ID = BUS_EXPENSE.ROUTE_LOG_ID
INNER JOIN ROUTE
ON ROUTE.ID = ROUTE_LOG.ROUTE_ID
GROUP BY ROUTE.PATH, ROUTE.LINE_NUMBER
;

-- All incomes for every line(bus route) for whole period
SELECT SUM(BUS_INCOMES.AMOUNT) AS INCOMES,
  ROUTE.LINE_NUMBER,
  ROUTE.PATH
FROM BUS_INCOMES
INNER JOIN ROUTE_LOG
ON ROUTE_LOG.ID = BUS_INCOMES.ROUTE_LOG_ID
INNER JOIN ROUTE
ON ROUTE.ID = ROUTE_LOG.ROUTE_ID
GROUP BY ROUTE.PATH, ROUTE.LINE_NUMBER
;

-- All incomes and expences for every line(bus route) for whole period
SELECT INCOMES, EXPENSES,INCOMES-EXPENSES AS BALANCE, INCOMES_TABLE.LINE_NUMBER,INCOMES_TABLE.PATH 
FROM (
SELECT SUM(BUS_INCOMES.AMOUNT) AS INCOMES,
  ROUTE.LINE_NUMBER,
  ROUTE.PATH
FROM BUS_INCOMES
INNER JOIN ROUTE_LOG
ON ROUTE_LOG.ID = BUS_INCOMES.ROUTE_LOG_ID
INNER JOIN ROUTE
ON ROUTE.ID = ROUTE_LOG.ROUTE_ID
GROUP BY ROUTE.PATH, ROUTE.LINE_NUMBER
) INCOMES_TABLE 
JOIN 
(
SELECT SUM(BUS_EXPENSE.AMOUNT) AS EXPENSES,
  ROUTE.LINE_NUMBER,
  ROUTE.PATH
FROM BUS_EXPENSE
INNER JOIN ROUTE_LOG
ON ROUTE_LOG.ID = BUS_EXPENSE.ROUTE_LOG_ID
INNER JOIN ROUTE
ON ROUTE.ID = ROUTE_LOG.ROUTE_ID
GROUP BY ROUTE.PATH, ROUTE.LINE_NUMBER
) EXPENCES_TABLE
 ON EXPENCES_TABLE.LINE_NUMBER=INCOMES_TABLE.LINE_NUMBER;


-- Every driver earned salary for all time 
SELECT  first_name, last_name, Salary FROM
(
SELECT route_log.DRIVER_ID, SUM(amount) AS Salary FROM route_log
JOIN bus_expense ON route_log.id = bus_expense.ROUTE_LOG_ID
JOIN expense_type ON expense_type.id= bus_expense.EXPENCE_TYPE_ID
WHERE expense_type.EXPENSE_NAME = 'Driver salary'
GROUP BY DRIVER_ID
) t1
JOIN driver ON driver.id = t1.driver_id;





