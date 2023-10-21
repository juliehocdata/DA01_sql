select * from user_data;
-- cách 1: sử dung IQR/BOXPLOT tìm ra outlier
-- B1: Tính Q1,Q3,IQR
-- b2: xấc định min=Q1-1.5*IQR; MAX=Q3+1.5*IQR
with twt_min_max_value as(
SELECT Q1-1.5*IQR AS min_value,
Q3+1.5*IQR as max_value
from (
select 
percentile_cont(0.25) WITHIN GROUP (ORDER BY users) as Q1,
percentile_cont(0.75) WITHIN GROUP (ORDER BY users) as Q3,
percentile_cont(0.75) WITHIN GROUP (ORDER BY users) -percentile_cont(0.25) WITHIN GROUP (ORDER BY users) as IQR
from user_data) as a)
--b3: xác định outlier <min or >max
select * from user_data
where users< (select min_value from twt_min_max_value)
or users>(select max_value from twt_min_max_value)
-- cách 2: sử dụng Z-SCORE =(users-avg)/stddev
select avg(users),
stddev(users) 
from user_data

with cte as
(
select data_date,
users,
(select avg(users)
from user_data) as avg,
(select stddev(users)
from user_data) as stddev
from user_data)

select data_date,users, (users-avg)/stddev as z_score
from cte
where abs((users-avg)/stddev )>3


























