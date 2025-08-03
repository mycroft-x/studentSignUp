-- Create database
CREATE DATABASE IF NOT EXISTS students_db;

-- Use created database
USE students_db;

-- Create table
CREATE TABLE IF NOT EXISTS tbl_user (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    faculty VARCHAR(100) NOT NULL,
    department VARCHAR(100) NOT NULL,
    level TINYINT UNSIGNED NOT NULL CHECK (level BETWEEN 1 AND 4),
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
);
