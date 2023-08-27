-- 1) LOWER(), UPPER(), LENGTH()
SELECT 
email,
LOWER(email) AS lower_email, -- ký tự thường
UPPER(email) AS upper_email,-- ký tự hoa
LENGTH(email) AS length_email-- số lượng ký tự
FROM customer
-- challenge: Liệt kê các KH có họ hoặc tên nhiều hơn 10 ký tự, kết qủa trả ra chữ thường
SELECT
LOWER(first_name) AS TEN_KH,
LOWER(last_name) AS HO_KH
FROM customer
WHERE length(first_name)<10
OR ength(last_name)<10
-- 2) LEFT(), RIGHT()
SELECT
  LEFT(first_name,3)  -- hiển thị 3 kỹ tự đầu tiên của first_name
  RIGHT(first_name,3)  -- hiển thị 3 kỹ tự cuối cùng của first_name
FROM customer 
/*challenge: Trích xuất 5 ký tự cuối cùng của địa chỉ email.
Làm thế nào để chỉ trích xuất dấu "." ở địa chỉ email*/
SELECT
RIGHT(LEFT((email)) AS TEN_KH,
FROM customer
-- 3) CONCATNATE (NỐI CHUỖI)
SELECT customer_id,
first_name ,
last_name,
first_name|| last_name AS full_name -- || dùng để nối chuỗi
FROM customer
/*Giả sử bạn chỉ có địa chỉ email và họ của khách hàng.
Bạn cần trích xuất tên từ địa chỉ email và nối nó với họ. 
Kết quả phải ở dạng: "Họ, Tên"*/
SELECT email,
LEFT(email,3) ||'***'||RIGHT(email,20) as new_email
FROM customer
--4) REPLACE(): thay đổi ký tự thành ký tự mới
SELECT email,
REPLACE(email,'.org','.com') -- thay ký .org thành .com
FROM customer
--5) POSITION(): Tìm vị trí của ký tự trong chuỗi
SELECT
email,
POSITION ('@' IN email) -- tìm vị trí của @ trong email
FROM customer 
-- 6) SUBSTRING()
-- lấy ra ký tự từ 2 đến 4 của first_name trong bảng customer
SELECT first_name,
SUBSTRING(first_name FROM 2 FOR 3)
FROM customer
-- lấy thông tin họ KH từ email
 SELECT email,
 SUBSTRING(email FROM POSITION ( '.' IN email) +1 FOR POSITION ( '@' IN email)-POSITION ( . IN email)-1) as HO_KH
FROM customer 
-- 7) EXTRACT() dùng để trích xuất thông tin Năm, tháng, ngày, giờ.. của 1 date/datetime kết quả trả ra dưới dạng number
SELECT * FROM rental
WHERE EXTRACT( 'year' FROM rental_date) =2020
-- 8) TO_CHAR () lấy thông tin datetime theo định dạng momg muốn(forrmat) 
SELECT TO_CHAR(payment_date, 'year') 
FROM payment
-- 9) Intervals & Timestamp
SELECT current_date,--ngày hiện tại
current_timestamp, -- ngày giờ hiện tại
returndate-rental_date AS rental_time -- là 1 interval
  
  


  
