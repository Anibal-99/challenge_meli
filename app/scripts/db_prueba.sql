-- Crear la base de datos 'meli' si no existe
CREATE DATABASE IF NOT EXISTS db_challenge_test;

-- Cambiar a la base de datos 'meli'
USE db_challenge_test;

-- Crear la tabla 'users'
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    useremail VARCHAR(255) NOT NULL,
    credit_card_number VARCHAR(16) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Crear la tabla 'pedido'
CREATE TABLE IF NOT EXISTS pedido (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    producto VARCHAR(255) NOT NULL,
    cantidad INT NOT NULL,
    total DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);
