-- WINDOW FUNCTION with RANK FUNCTION 
-- xếp hạng độ dài phim trong từng thể loại 
-- output: film_id, category, length, xếp hạng độ dài phim trong từng category
SELECT A.film_id,C.name as category, a.length,
RANK() OVER(PARTITION BY C.name ORDER BY a.length DESC) AS rank1,
DENSE_RANK() OVER(PARTITION BY C.name ORDER BY a.length DESC) as rank2,
ROW_NUMBER() OVER(PARTITION BY C.name ORDER BY a.length DESC, a.film_id) as rank3
FROM film a 
JOIN film_category B ON A.film_id=B.film_id
JOIN category C ON C.category_id =b.category_id 
--ORDER BY C.name
