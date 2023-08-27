-- 1) AGGREGATE FUNCTIONS
SELECT 
MAX(amount) AS max_amount, -- giá trị lớn nhất
MIN(amount) AS min_amount,-- giá trị nhỏ nhất
SUM(amount) AS total_amount,-- tính tổng
AVG(amount) AS avg_amount,-- tính trung bình
COUNT(*) AS count_record,-- Đếm số lượng dòng
COUNT(customer_id) AS count_record_customer_id,-- đếm số lượng dòng ko null trong cột customer_id bị
COUNT(DISTINCT customer_id)  AS count_distinct_customer_id-- đếm số bản ghi khác nhau trong cột customer_id
FROM payment
WHERE payment_date BETWEEN '2020-01-01' AND '2020-02-01'
 -- 2) GROUP BY : dùng để tổng hợp dữ liệu theo nhóm
SELECT customer_id, staff_id
MAX(amount) AS max_amount, 
MIN(amount) AS min_amount,
SUM(amount) AS total_amount,
AVG(amount) AS avg_amount,
COUNT(*) AS count_record,
COUNT(customer_id) AS count_record_customer_id,
COUNT(DISTINCT customer_id) AS count_distinct_customer_id
FROM payment
GROUP BY customer_id, staff_id
ORDER BY customer_id
--- 3) HAVING: Dùng để lọc dữ liệu dựa vào các cột thông tin sau khi đã tổng hợp; luôn đứng sau GROUP BY
  -- ví dụ: tìm các khách hàng có tổng số tiền thanh toán >100$ trong tháng 1/2020
SELECT customer_id
SUM(amount) AS total_amount
FROM payment
WHERE payment_date BETWEEN '2020-01-01' AND '2020-02-01'
GROUP BY customer_id
HAVING SUM(amount) >100
  /*challenge:Năm 2020, các ngày 28, 29, 30/4 là những ngày có doanh thu rất cao. Đó là lý do sếp muốn muốn xem dữ liệu vào những ngày đó.
Hãy tìm số tiền thanh toán trung bình được nhóm theo khách hàng và ngày thanh toán – chỉ xem xét những ngày mà khách hàng có nhiều hơn 1 khoản thanh toán 
Sắp xếp theo số tiền trung bình theo thứ tự giảm dần.*/
SELECT customer_id, DATE(payment_date),
AVG(amount) AS avg_amount
FROM payment
WHERE DATE(payment_date) IN ('2020-04-28','2020-04-29','2020-04-30')
GROUP BY customer_id,DATE(payment_date)
HAVING COUNT(payment_id) >1
ORDER BY AVG(amount) DESC
-- 4) MATHEMATIC OPERATORS & FUNCTIONS 
-- Cộng: +, Trừ: -, Nhân: *, Chia: /, Số dư: %, luỹ thừa ^
-- giá trị tuyệt đối: ABS(), làm tròn: ROUND(), số nguyên cận dưới:FLOOR(), số nguyên cận trên:CEILING()
SELECT film_id,
rental_rate,
ROUND(rental_rate*1.1, 2) AS new_rental_rate,
FLOOR(rental_rate*1.1, 2) AS new_rental_rate
FROM film
-- challenge: danh sáhc các bộ phim có giá thuê nhỏ hơn 4% chi phí thay thế
SELECT film_id,
rental_rate,
replacement_cost,
ROUND((rental_rate/replacement_cost)*100,2) AS percentage,
FROM film
where ROUND((rental_rate/replacement_cost)*100,2)<4





