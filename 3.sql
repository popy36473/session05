

-- Tạo bảng customers
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(100)
);

-- Tạo bảng orders
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_price NUMERIC(10,2),
    CONSTRAINT fk_orders_customers
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

-- Tạo bảng order_items
CREATE TABLE order_items (
    item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price NUMERIC(10,2),
    CONSTRAINT fk_order_items_orders
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
);

-- Thêm dữ liệu vào customers
INSERT INTO customers (customer_id, customer_name, city) VALUES
(1, 'Nguyễn Văn A', 'Hà Nội'),
(2, 'Trần Thị B', 'Đà Nẵng'),
(3, 'Lê Văn C', 'Hồ Chí Minh'),
(4, 'Phạm Thị D', 'Hà Nội');

-- Thêm dữ liệu vào orders
INSERT INTO orders (order_id, customer_id, order_date, total_price) VALUES
(101, 1, '2024-12-20', 3000),
(102, 2, '2025-01-05', 1500),
(103, 1, '2025-02-10', 2500),
(104, 3, '2025-02-15', 4000),
(105, 4, '2025-03-01', 800);

-- Thêm dữ liệu vào order_items
INSERT INTO order_items (item_id, order_id, product_id, quantity, price) VALUES
(1, 101, 1, 2, 1500),
(2, 102, 2, 1, 1500),
(3, 103, 3, 5, 500),
(4, 104, 2, 4, 1000);

SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM order_items;


--Viết truy vấn hiển thị tổng doanh thu và tổng số đơn hàng của mỗi khách hàng:
--Chỉ hiển thị khách hàng có tổng doanh thu > 2000
--Dùng ALIAS: total_revenue và order_count

SELECT 
    c.customer_name,
    SUM(o.total_price) AS total_revenue,
    COUNT(o.order_id) AS order_count
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name
HAVING SUM(o.total_price) > 2000;

--Viết truy vấn con (Subquery) để tìm doanh thu trung bình của tất cả khách hàng
--Sau đó hiển thị những khách hàng có doanh thu lớn hơn mức trung bình đó

SELECT 
    c.customer_name,
    SUM(o.total_price) AS total_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.total_price) > (
    SELECT AVG(customer_revenue)
    FROM (
        SELECT SUM(total_price) AS customer_revenue
        FROM orders
        GROUP BY customer_id
    ) AS sub
);


--Dùng HAVING + GROUP BY để lọc ra thành phố có tổng doanh thu cao nhất
SELECT 
    c.city,
    SUM(o.total_price) AS total_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.city
HAVING SUM(o.total_price) = (
    SELECT MAX(city_revenue)
    FROM (
        SELECT SUM(o.total_price) AS city_revenue
        FROM customers c
        JOIN orders o ON c.customer_id = o.customer_id
        GROUP BY c.city
    ) AS sub
);
-- Mở Rộng	

SELECT 
    c.customer_name,
    c.city,
    SUM(oi.quantity) AS total_products,
    SUM(oi.quantity * oi.price) AS total_spending
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
INNER JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.customer_name, c.city;


