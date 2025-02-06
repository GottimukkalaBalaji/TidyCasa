-- Migration: 001_initial_schema
-- Description: Initial database schema setup

-- Create schema_versions table to track migrations
CREATE TABLE IF NOT EXISTS schema_versions (
    version INT PRIMARY KEY,
    applied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    description VARCHAR(255)
);

-- Create users table
CREATE TABLE IF NOT EXISTS users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE,
    password VARCHAR(255) NOT NULL,
    phone_number BIGINT UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create spaces table
CREATE TABLE IF NOT EXISTS spaces (
    space_id INT PRIMARY KEY AUTO_INCREMENT,
    space_name VARCHAR(255) NOT NULL,
    description TEXT,
    space_image VARCHAR(255),
    owner_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (owner_id) REFERENCES users(user_id)
);

-- Record this migration
INSERT INTO schema_versions (version, description) VALUES (1, 'Initial schema setup');
