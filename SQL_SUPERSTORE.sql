--1)uploaded superstore data 1)order 2)return
select * from dbo.Orders$
select * from dbo.Returns$
------------------------------------------------------------------x
--2) top 10 rows from the table
select top 10 * from dbo.Orders$
------------------------------------------------------------------x
--3)list of all customer names present in the data
select distinct [Customer Name] from dbo.Orders$
------------------------------------------------------------------x
--4)a list records where sales order is greater than or equal to 500 units for California state
select * FROM dbo.Orders$ WHERE Sales>=500 AND State= 'CALIFORNIA'
-------------------------------------------------------------------x
--5)different sub-categories
SELECT DISTINCT [Sub-Category] FROM dbo.Orders$
-------------------------------------------------------------------x
--6)a list of records where State is Alabama or orders for Phones with price greater than 100 in the state of California

SELECT * from dbo.Orders$ where State='alabama' OR (State='CAIIFORNIA' AND [Sub-Category]='PHONE'AND Sales>100)
----------------------------------------------------------------------x
--7)latest 10 most valued orders
SELECT TOP 10 * FROM dbo.Orders$ ORDER BY Sales DESC, [Order Date] DESC
---------------------------------------------------------------------x
--8)customers starting with the letter ‘a’
select distinct [customer name] from dbo.Orders$ where [Customer Name] like 'a%'
--9)its not case sensitive
--10)customers starting with a but has at least 3 characters
select distinct [Customer Name] from dbo.Orders$ where [Customer Name] like 'a__%'
-------------------------------------------------------------------x
--11)customers that have ‘r’ in the 2nd position
select [Customer Name] from dbo.Orders$ where [Customer Name] like '_r%'
-------------------------------------------------------------------x
--12 )where last name starts from ‘a’
select  [customer name] from dbo.Orders$ where [Customer Name] like '% a%'
-------------------------------------------------------------------x
--13) Average profit per order for every customer
select [Customer Name], AVG(profit) as profit_per_order from dbo.Orders$ group by [Customer Name]
-----------------------------------------------------------------x
--14)	Average profit per order for every sub-category
select distinct [Sub-Category], AVG(profit) as profit_per_order from dbo.Orders$ group by [Sub-Category]
------------------------------------------------------------------x
--15)temp tables

select * into #1 from dbo.Orders$ where State = 'california'
select * into #2 from dbo.Orders$ where State = 'alabama'
--a)
select * FROM #1 UNION 
select * from #2
--b)
select *  from dbo.Orders$ where state ='california' or state = 'alabama'
--c)so where clause is same result as  of union #1 and #2.
--d)
select * FROM #1 
UNION ALL
select * from #2
-- union and union all will work same in this scenario.
-------------------------------------------------------------------------x
--16) customers who have returned orders at least once
select distinct dbo.Orders$.[Customer Name], count(returned) as no_of_times_order_returned  from dbo.Orders$ inner join 
dbo.Returns$ on dbo.Orders$.[Order ID]=dbo.Returns$.[Order ID]
group by [Customer Name]
--------------------------------------------------------------------------x
--17)	Added a column to the table ‘orders’ as ‘returned’
select dbo.Orders$.* ,returned from dbo.Orders$  left join
 dbo.Returns$ on dbo.Orders$.[Order ID]=dbo.Returns$.[Order ID]
 -----------------------------------------------------------------------x
--18) sub-categories have the orders been returned most in the year 2017

 select top 1 count(returned) as no_of_order_returned, [Sub-Category], years from
(select dbo.Returns$.Returned, dbo.Orders$.[Sub-Category],year(dbo.Orders$.[order date]) as years from dbo.Orders$ 
inner join dbo.Returns$ on dbo.Orders$.[Order ID]=dbo.Returns$.[Order ID]) as fi where years= '2017'
group by [Sub-Category], years
order by no_of_order_returned desc
----------------------------------------------------------------------x
--19) net profit for the orders that have been returned. 
select sum(dbo.Orders$.Profit) as net_profit , count(dbo.Returns$.Returned) from dbo.Orders$ 
inner join dbo.Returns$ on dbo.Orders$.[Order ID]=dbo.Returns$.[Order ID]
group by Returned
-----------------------------------------------------------------------x
--20) customers who have changed their address at least once

select distinct([Customer Name]),[Postal Code]  from dbo.Orders$
select count(*) as [No of Address from which order placed],[Customer Name] from dbo.Orders$
group by [Customer Name] having count(*)>1 order by [Customer Name]

------------------------------------------------------------------------x
--21) created the table 'customer_info'.
select [Customer Name],[postal code],[Customer ID] from (select ROW_NUMBER() over (partition by [Customer Name] order by
[Order date] desc) As [Number],
[Order Date],[postal code],[Customer ID],[Customer Name] from dbo.Orders$) as customer where [Number]=1
-----------------------------------------------------------------------x