CREATE DATABASE IF NOT EXISTS starline_service_db;
CREATE DATABASE IF NOT EXISTS starline_stock_db;
GRANT ALL PRIVILEGES ON starline_service_db.* TO 'root'@'%';
GRANT ALL PRIVILEGES ON starline_stock_db.* TO 'root'@'%';
FLUSH PRIVILEGES;

USE starline_service_db;
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    product_name VARCHAR(255) NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Insert sample data into users
INSERT INTO users (name, email) VALUES
('John Doe', 'john.doe@example.com'),
('Jane Smith', 'jane.smith@example.com');

-- Insert sample data into orders
INSERT INTO orders (user_id, product_name) VALUES
(1, 'Satellite A'),
(2, 'Satellite B');

USE starline_stock_db;
CREATE TABLE IF NOT EXISTS products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS transactions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Insert sample data into products
INSERT INTO products (name, price, stock) VALUES
('Satellite A', 1000.00, 50),
('Satellite B', 1500.00, 30);

-- Insert sample data into transactions
INSERT INTO transactions (product_id, quantity) VALUES
(1, 5),
(2, 3);
