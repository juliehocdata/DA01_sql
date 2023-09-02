/*Viết truy vấn trả về danh sách phim bao gồm
- film_id,
- title,
- length,
- category,
- thời lượng trung bình của phim trong category đó.
Sắp xếp kết quả theo film_id.*/
SELECT a.film_id,a.title,a.length, c.name as category,
AVG(a.length) OVER(PARTITION BY c.name ORDER BY a.film_id)
FROM film a
JOIN public.film_category b on a.film_id=b.film_id
join public.category c on c.category_id=b.category_id

/*Viết truy vấn trả về tất cả chi tiết các thanh toán bao gồm
-số lần thanh toán được thực hiện bởi khách hàng này và số tiền đó
Sắp xếp kết quả theo Payment_id.*/
SELECT *,
COUNT(*) OVER(PARTITION BY customer_id,amount) as sd
FROM payment
order by payment_id

-- WINDOW FUNCTION with RANK FUNCTION 
-- xếp hạng độ dài phim trong từng thể loại 
-- output: film_id, category, length, xếp hạng độ dài phim trong từng category
SELECT A.film_id, C.name as category, a.length,
RANK() OVER(PARTITION BY C.name ORDER BY a.length DESC) AS rank1,
DENSE_RANK() OVER(PARTITION BY C.name ORDER BY a.length DESC) as rank2,
ROW_NUMBER() OVER(PARTITION BY C.name ORDER BY a.length DESC, a.film_id) as rank3
FROM film a 
JOIN film_category B ON A.film_id=B.film_id
JOIN category C ON C.category_id =b.category_id 

-- WINDOW FUNCTION with FIRST_VALUE
-- số tiền thanh toán cho đơn hàng đầu tiên và gần đây nhất của từng khách hàng
SELECT * FROM
(SELECT 
customer_id,payment_date,amount,
ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY payment_date DESC) AS stt
FROM payment) AS a
WHERE stt=1;

SELECT 
customer_id,payment_date,amount,
FIRST_VALUE(amount) OVER(PARTITION BY customer_id ORDER BY payment_date) AS first_amount
,FIRST_VALUE(amount) OVER(PARTITION BY customer_id ORDER BY payment_date DESC) AS last_amount
FROM payment
-- WINDOW FUNCTION with LEAD(), LAG()
-- tìm chênh lệch số tiền giữa các lần thanh toán của từng khách hàng
select 
customer_id,
payment_date,
amount,
LEAD (amount) OVER(PARTITION BY customer_id ORDER BY payment_date) as next_amount,
LEAD(payment_date) OVER(PARTITION BY customer_id ORDER BY payment_date) as next_payment_date,
amount-LEAD(amount) OVER(PARTITION BY customer_id ORDER BY payment_date) as diff
from payment;
select 
customer_id,
payment_date,
amount,
LAG (amount) OVER(PARTITION BY customer_id ORDER BY payment_date) as previous_amount,
LAG(payment_date) OVER(PARTITION BY customer_id ORDER BY payment_date) as previous_payment_date,
amount-LAG(amount) OVER(PARTITION BY customer_id ORDER BY payment_date) as diff
from payment

