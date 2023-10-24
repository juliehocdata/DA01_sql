with online_retail_covert as(
select 
invoiceno,
description,
stockcode,
cast(quantity as int) as quantity,
cast(invoicedate as timestamp) invoicedate,
cast(unitprice as numeric) as unitprice,
customerid,
country
from public.online_retail
where customerid <>''
and cast(quantity as int) >0 and cast(unitprice as numeric) >0)

,online_retail_main as
(select * from 
(select t.* ,
row_number() over(partition by invoiceno, stockcode, quantity order by invoicedate) as dup_flag
from online_retail_covert t ) x
where dup_flag =1 )
 --- begin analyst 
--select * from online_retail_main
,online_retail_index as(
SELECT 
customerid,
	amount,
	TO_CHAR(first_purchase_date, 'yyyy-mm') as cohort_date,
	invoicedate,
	(extract('year' from invoicedate)-extract('year' from first_purchase_date))*12
	+(extract('month' from invoicedate)-extract('month' from first_purchase_date))+1 as index
FROM(
	SELECT customerid,
	quantity*unitprice AS amount,
MIN(invoicedate) over(PARTITION BY customerid) as first_purchase_date ,
invoicedate
from online_retail_main t
) a)

SELECT 
cohort_date,
index,
count(distinct customerid) as cnt,
sum(amount) as revenue
from online_retail_index
group by cohort_date, index



,xxx as(
SELECT 
cohort_date,
index,
count(distinct customerid) as cnt,
sum(amount) as revenue
from online_retail_index
group by cohort_date, index)

--- customer_cohort
,customer_cohort as (
select 
cohort_date,
sum(case when index=1 then cnt else 0 end ) as m1,
sum(case when index=2 then cnt else 0 end ) as m2,
sum(case when index=3 then cnt else 0 end ) as m3,
sum(case when index=4 then cnt else 0 end ) as m4,
sum(case when index=5 then cnt else 0 end ) as m5,
sum(case when index=6 then cnt else 0 end ) as m6,
sum(case when index=7then cnt else 0 end ) as m7,
sum(case when index=8 then cnt else 0 end ) as m8,
sum(case when index=9then cnt else 0 end ) as m9,
sum(case when index=10 then cnt else 0 end ) as m10,
sum(case when index=11 then cnt else 0 end ) as m11,
sum(case when index=12 then cnt else 0 end ) as m12,
sum(case when index=13 then cnt else 0 end ) as m13
from xxx
group by cohort_date
order by cohort_date)
-- retention cohort
select
cohort_date,
(100-round(100.00* m1/m1,2))||'%' as m1,
(100-round(100.00* m2/m1,2))|| '%' as m2,
(100-round(100.00* m3/m1,2)) || '%' as m3,
round(100.00* m4/m1,2) || '%' as m4,
round(100.00* m5/m1,2) || '%' as m5,
round(100.00* m6/m1,2) || '%' as m6,
round(100.00* m7/m1,2) || '%' as m7,
round(100.00* m8/m1,2) || '%' as m8,
round(100.00* m9/m1,2) || '%' as m9,
round(100.00* m10/m1,2) || '%' as m10,
round(100.00* m11/m1,2) || '%' as m11,
round(100.00* m12/m1,2) || '%' as m12,
round(100.00* m13/m1,2) || '%' as m13
from customer_cohort
-- churn cohort


