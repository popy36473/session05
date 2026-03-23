CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    order_date DATE,
    total_amount NUMERIC(10,2)
);

CREATE TABLE order_items (
    item_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    product_name VARCHAR(100),
    quantity INT,
    price NUMERIC(10,2)
);


-- Bảng customers
INSERT INTO customers (customer_name, city) VALUES
('Nguyen Van A', 'Ha Noi'),
('Tran Thi B', 'Hai Phong'),
('Le Van C', 'Da Nang'),
('Pham Thi D', 'Ha Noi'),
('Hoang Van E', 'Can Tho');

-- Bảng orders
INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(1, '2024-03-01', 5000.00),
(1, '2024-03-05', 7000.00),
(2, '2024-03-02', 3000.00),
(3, '2024-03-04', 12000.00),
(4, '2024-03-06', 8000.00),
(5, '2024-03-07', 1500.00);

-- Bảng order_items
INSERT INTO order_items (order_id, product_name, quantity, price) VALUES
(1, 'Laptop Dell', 1, 5000.00),
(2, 'iPhone 15', 1, 7000.00),
(3, 'Ban phim co', 2, 1500.00),
(4, 'Man hinh LG', 2, 6000.00),
(5, 'Chuot Logitech', 4, 2000.00),
(6, 'Tai nghe Sony', 1, 1500.00);

--1
SELECT 
    c.customer_name AS "Tên khách",
    o.order_date AS "Ngày đặt hàng",
    o.total_amount AS "Tổng tiền"
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id;

--2
SELECT 
    SUM(total_amount) AS "Tổng doanh thu",
    AVG(total_amount) AS "Trung bình đơn hàng",
    MAX(total_amount) AS "Đơn hàng lớn nhất",
    MIN(total_amount) AS "Đơn hàng nhỏ nhất",
    COUNT(order_id) AS "Số lượng đơn hàng"
FROM orders;
--3
SELECT 
    c.city AS "Thành phố",
    SUM(o.total_amount) AS "Tổng doanh thu"
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.city
HAVING SUM(o.total_amount) > 10000;
--4
SELECT 
    c.customer_name AS "Tên khách hàng",
    o.order_date AS "Ngày đặt hàng",
    oi.product_name AS "Tên sản phẩm",
    oi.quantity AS "Số lượng",
    oi.price AS "Giá"
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id;

--5
SELECT c.customer_name
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.total_amount) = (
    SELECT MAX(total_revenue)
    FROM (
        SELECT SUM(total_amount) AS total_revenue
        FROM orders
        GROUP BY customer_id
    ) AS revenue_table
);
--6

SELECT city
FROM customers

UNION

SELECT c.city
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id;