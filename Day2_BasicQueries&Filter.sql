-- 1)  SELECT
 -- hiển thị toàn bộ các trường trong bảng actor
SELECT * FROM actor;
--hiển thị trường first_name, last_name trong bảng actor
SELECT first_name, last_name FROM actor ;
-- đặt bí danh cho trường 
SELECT first_name AS TEN_DV, 
       last_name AS HO_DV
FROM actor ;
-- challenge: list ra các khách hàng với thông tin họ, tên và email
SELECT
first_name AS TEN_KH, 
last_name AS TEN_KH,
email
FROM customer 
-- 2) ORDER BY
-- hiển thị thông tin diễn viên, kết quả trả ra sắp xếp thứ tự A-Z của first_name, giam dần theo actor_id
SELECT * FROM actor
ORDER BY first_name ASC, actor_id DESC
-- 3) LIMIT
-- Top 100 hoá đon cao nhất
SELECT * FROM payment
ORDER BY amount
LIMIT 100
-- 4) DISTINCT
-- hiển thị các tên khác nhau trong bảng actor
SELECT DISTINCT  first_name FROM actor
-- challengeL sản phẩm đang cho thuê ở các mức giá khác nhau nào? sắp xếp theo chiều cao - thâp
SELECT DISTINCT amount FROM payment
ORDER BY amount
-- 5) WHERE
SELECT * FROM payment
WHERE amount>10.99 -- > < >= <= <>/!=
-- hiển thị các khách hàng ko có địa chỉ email
SELECT * FROM customer
WHERE email IS NULL
-- hiển thị các khách hàng có địa chỉ email
SELECT * FROM customer
WHERE email IS NOT NULL
-- 6) AND/OR
-- các đơn hàng có giá trị lớn hơn 4$ và nhỏ hơn 9$
SELECT * FROM payment
WHERE amount >4 AND amount<9
--- các đơn hàng có giá trị lớn hơn 9$ hoặc nhỏ hơn 4$
SELECT * FROM payment
WHERE amount >9 OR amount<4
/*challenge: Các khoan thanh toán của KH 322, 346, 354 có số tiền lớn hơn 2 và nhỏ hơn 9
sắp xếp theo thứ tự tăng dần mã kH
*/
SELECT * FROM payment 
WHERE (customer_id =322 OR customer_id =346 OR ustomer_id =354)
AND (amount >2 AND amount<9)
-- 10) BETWEEN
 -- các đơn hàng có giá trị lớn hơn 2$ và nhỏ hơn 9$
SELECT * FROM payment 
WHERE amount BETWEEN 2 AND 9 
-- 11) IN
-- các hoá đơn có id 16055, 16061, 16065, 16068
SELECT * FROM payment
WHERE payment_id IN (16055, 16061, 16065, 16068)
-- 12) LIKE
SELECT * FROM customer
WHERE first_name LIKE 'N%' -- bắt đầu bằng N
OR first_name LIKE '%N'-- kết thúc bằng N
OR first_name LIKE '%N%'-- chứa N
OR first_name LIKE '__N%'-- ký tự thứ 3 là N



