challenge 2

/*Tìm hiểu ghế nào nào được chọn thường xuyên nhất.
Đảm bảo tất cả các ghế đều được liệt kê ngay cả khi chúng chưa bao giờ được đặt.
Có chỗ ngồi nào chưa bao giờ được đặt không?
Chỉ ra hàng ghế nào được đặt thường xuyên nhất (A,B,C...)*/
SELECT a.seat_no, 
COUNT(flight_id) as so_luong
FROM bookings.seats AS a
LEFT JOIN bookings.boarding_passes AS b
ON a.seat_no=b.seat_no
GROUP BY a.seat_no
ORDER BY COUNT(flight_id)  desc;

SELECT a.seat_no
FROM bookings.seats AS a
LEFT JOIN bookings.boarding_passes AS b
ON a.seat_no=b.seat_no
WHERE b.seat_no IS NULL;

SELECT RIGHT(a.seat_no,1) AS line, 
COUNT(flight_id) as so_luong
FROM bookings.seats AS a
LEFT JOIN bookings.boarding_passes AS b
ON a.seat_no=b.seat_no
GROUP BY RIGHT(a.seat_no,1)
ORDER BY COUNT(flight_id) desc;

chall

/*
Những khách hàng nào đến từ Brazil?
Viết truy vấn để lấy first_name, Last_name, email 
và quốc gia từ tất cả khách hàng từ Brazil.*/
select a.first_name,a.Last_name, a.email,
d.country
from customer AS a
JOIN public.address  AS b ON a.address_id=b.address_id
JOIN public.city AS c ON c.city_id=b.city_id
JOIN public.country AS d ON d.country_id=c.country_id
WHERE d.country='Brazil'









