IF NOT EXISTS (
        SELECT *
        FROM sys.databases
        WHERE name = 'laravel'
        )
BEGIN
    CREATE DATABASE laravel
END
GO

USE laravel
GO

IF NOT EXISTS (
        SELECT 1
        FROM sys.tables
        WHERE name = 'users'
            AND type = 'U'
        )
BEGIN
    CREATE TABLE users (
        id INT PRIMARY KEY IDENTITY(1, 1)
        ,name VARCHAR(100)
        )
END
GO
USE master
GO
