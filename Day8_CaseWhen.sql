-- 1) CASE WHEN
-- cú pháp
SELECT 
CASE
 WHEN codition1 THEN result1
 WHEN codition2 THEN result2
 ..
 ELSE resultn
FROM table_nm
-- challenge 1
/*Bạn cần tìm hiểu xem công ty đã bán bao nhiêu vé trong các danh mục sau
•  Low price ticket: total_amount < 20,000
•  Mid price ticket: total_amount between 20,000 and 150,000
•  High price ticket: total_amount >= 150,000*/

SELECT 
CASE
 WHEN amount <20000 THEN 'Low price ticket'
 WHEN amount BETWEEN 20000 AND 150000 THEN 'Mid price ticket'
 ELSE 'High price ticket'
END AS category,
COUNT(*) AS SO_LUONG
FROM bookings.ticket_flights
GROUP BY category
-- challenge 2
/*Bạn cần biết có bao nhiêu chuyến bay đã khởi hành vào các mùa sau:

Mùa xuân: Tháng 2,3,4
Mùa hè: Tháng 5,6,7
Mùa thu: Tháng 8,9,10
Mùa đông: 11,12,1
*/
SELECT 

CASE
   WHEN EXTRACT(MONTH FROM scheduled_departure) IN (2,3,4) THEN 'Mùa xuân'
   WHEN EXTRACT(MONTH FROM scheduled_departure) IN (5,6,7) THEN 'Mùa hè'
   WHEN EXTRACT(MONTH FROM scheduled_departure) IN (8,9,10) THEN 'Mùa thu'
   ELSE 'Mùa Đông'
END AS season,
count(*)
FROM bookings.flights
GROUP BY season
--challenge 3
/*Bạn muốn tạo danh sách phim phân cấp độ theo cách sau:
1. Xếp hạng là 'PG' hoặc 'PG-13' hoặc thời lượng hơn 210 phút: 'Great rating or long (tier 1)
2. Mô tả chứa 'Drama' và thời lượng hơn 90 phút: 
Long drama (tier 2)'
3. Mô tả có chứa 'Drama' và thời lượng không quá 90 phút: 
'Shcity drama (tier 3)
4. Giá thuê thấp hơn $1: 'Very cheap (tier 4)'

Nếu một bộ phim có thể thuộc nhiều danh mục, nó sẽ được chỉ định ở cấp cao hơn. Làm cách nào để bạn có thể chỉ lọc những phim xuất hiện ở một trong 4 cấp độ này?
*/
SELECT 
film_id,
CASE
  WHEN rating IN ('PG','PG-13') or length >210 THEN 'Great rating or long (tier 1)'
  WHEN description LIKE '%Drama%' AND length >90 THEN 'Long drama (tier 2)'
  WHEN description LIKE '%Drama%' AND length <=90 THEN 'Shcity drama (tier 3)'
  WHEN rental_rate <1 THEN 'Very cheap (tier 4)'
END AS category

FROM film
WHERE CASE
  WHEN rating IN ('PG','PG-13') or length >210 THEN 'Great rating or long (tier 1)'
  WHEN description LIKE '%Drama%' AND length >90 THEN 'Long drama (tier 2)'
  WHEN description LIKE '%Drama%' AND length <=90 THEN 'Shcity drama (tier 3)'
  WHEN rental_rate <1 THEN 'Very cheap (tier 4)'
END IS NOT NULL

--2) PIVOT BY CASE-WHEN
/*Tính tổng số tiền theo từng loại hoá đơn high-medium-low
- high: amount>10
- medium : 5<=amount<=10
- low: amount<5*/
SELECT customer_id,
SUM( CASE
  WHEN amount>10 THEN amount ELSE 0 END) AS high,
SUM( CASE
  WHEN amount BETWEEN 5 AND 10 THEN amount ELSE 0 END) AS medium,
SUM( CASE
  WHEN amount <5  THEN amount ELSE 0 END) AS low
FROM payment
GROUP BY customer_id
ORDER BY customer_id
--3) COALESCE dùng để thay thế giá trị NULL ở 1 trường nào đó
SELECT scheduled_arrival,
actual_arrival,
COALESCE(actual_arrival, '2020-01-01'),
COALESCE(actual_arrival, scheduled_arrival),
COALESCE(actual_arrival-scheduled_arrival, '00:00')
FROM bookings.flights
--4) CAST
-- string => number ( string phải chứa các chữ số, ko được chứa ký tự a,b,c..)
SELECT 
CAST(ticket_no AS bigint) 
FROM bookings.flights
-- number=> string 
SELECT 
CAST(amount AS VARCHAR) 
FROM bookings.flights
-- datetime=> string 
SELECT 
CAST(scheduled_departure AS VARCHAR) 
FROM bookings.flights

