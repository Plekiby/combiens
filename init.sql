-- Initialize combiens database
CREATE DATABASE IF NOT EXISTS combiens;
USE combiens;

-- Create biens table for real estate properties
CREATE TABLE IF NOT EXISTS biens (
    id INT AUTO_INCREMENT PRIMARY KEY,
    reference VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    rent DECIMAL(10, 2),
    private_info TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create index on reference for faster lookups
CREATE INDEX idx_reference ON biens(reference);
