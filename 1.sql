-- Tạo bảng products
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50)
);

-- Tạo bảng orders
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    product_id INT,
    quantity INT,
    total_price NUMERIC(10,2),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Chèn dữ liệu vào bảng products
INSERT INTO products (product_id, product_name, category)
VALUES
(1, 'Laptop Dell', 'Electronics'),
(2, 'IPhone 15', 'Electronics'),
(3, 'Bàn học gỗ', 'Furniture'),
(4, 'Ghế xoay', 'Furniture');

-- Chèn dữ liệu vào bảng orders
INSERT INTO orders (order_id, product_id, quantity, total_price)
VALUES
(101, 1, 2, 2200),
(102, 2, 3, 3300),
(103, 3, 5, 2500),
(104, 4, 4, 1600),
(105, 1, 1, 1100);

-- Hiển thị dữ liệu
SELECT * FROM products;
SELECT * FROM orders;


--Viết truy vấn hiển thị tổng doanh thu (SUM(total_price)) và số lượng sản phẩm bán được 
--(SUM(quantity)) cho từng nhóm danh mục (category)
--Đặt bí danh cột như sau:
--total_sales cho tổng doanh thu
--total_quantity cho tổng số lượng

select p.category as "Danh mục", sum(o.total_price) as "Tổng doanh thu",sum(o.quantity) as "Tổng số lượng"
from orders o join products p on o.product_id = p.product_id
group by p.category

--Chỉ hiển thị những nhóm có tổng doanh thu lớn hơn 2000

select p.category,sum(o.total_price)
from  products p join orders o on o.product_id = p.product_id
group by p.category
having sum(o.total_price) > 2000

----Sắp xếp kết quả theo tổng doanh thu giảm dần
SELECT 
    p.category,
    SUM(o.total_price) AS total_sales,
    SUM(o.quantity) AS total_quantity
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.category
ORDER BY total_sales DESC;