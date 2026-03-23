select * from products
select * from orders

--Viết truy vấn con (Subquery) để tìm sản phẩm có doanh thu cao nhất trong bảng orders
--Hiển thị: product_name, total_revenue

select p.product_name,sum(o.total_price)
from orders o
join products p on o.product_id = p.product_id
group by p.product_name
having sum(o.total_price) = (
	select max(gia_san_pham)
	from (
		select sum(total_price) as gia_san_pham
		from orders
		group by product_id
	)
)


--Viết truy vấn hiển thị tổng doanh thu theo từng nhóm category (dùng JOIN + GROUP BY)
select p.category,sum(o.total_price)
from products p
join orders o ON p.product_id=o.product_id
group by category


--Dùng INTERSECT để tìm ra nhóm category có sản phẩm bán chạy nhất (ở câu 1) 
--cũng nằm trong danh sách nhóm có tổng doanh thu lớn hơn 3000

select p.category
from products p
JOIN orders o ON p.product_id=o.product_id
group by p.category,p.product_id
having sum(o.quantity) = (
	select max(tong_san_pham)
	from(
		select sum(o.quantity) as tong_san_pham
		from orders o
		group by product_id
	) t
)

INTERSECT

select p.category
from products p
join orders o ON p.product_id = o.product_id
group by p.category
having sum(o.total_price) > 3000





