SELECT TOP 10 * FROM sales_superstore_2

SELECT [customer name] from sales_superstore_2

select * FROM sales_superstore_2 WHERE Sales>=500 AND State= 'CALIFORNIA'

SELECT DISTINCT [Sub-Category] FROM sales_superstore_2

SELECT * from sales_superstore_2 where State='alabama' OR (State='CAIIFORNIA' AND [Sub-Category]='PHONE'AND Sales>100)

SELECT TOP 10 * FROM sales_superstore_2 ORDER BY Sales DESC, [Order Date] DESC

select distinct [customer name] from sales_superstore_2 where [Customer ID] like 'a%'

select distinct [customer name] from sales_superstore_2 where [Customer Name] like 'a___%'

select distinct [customer name] from sales_superstore_2 where [Customer Name] like '_r%'

select distinct [customer name] from sales_superstore_2 where [Customer ID] like '_a%'

select [customer name] from sales_superstore_2 where AVG= 'profit'

select [customer name], AVG(profit) as profit_per_order from sales_superstore_2 group by [Customer Name]

SELECT [SUB-CATEGORY], AVG(PROFIT) AS PROFIT_PER_ORDER FROM sales_superstore_2 GROUP BY [Sub-Category]





