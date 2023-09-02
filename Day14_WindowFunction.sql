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

