-- ================================================
-- NORTHWIND SATIS ANALIZI
-- Yusuf Emrecan BÜRÇÜN
-- MySQL Version
-- ================================================

USE Northwind;

-- 1. EN COK SIPARIS VEREN MUSTERILER
SELECT 
    c.CompanyName AS MusteriAdi,
    c.Country AS Ulke,
    COUNT(o.OrderID) AS ToplamSiparis
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CompanyName, c.Country
ORDER BY ToplamSiparis DESC;

-- 2. EN COK GELIR GETIREN MUSTERILER
SELECT 
    c.CompanyName AS MusteriAdi,
    c.Country AS Ulke,
    ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)), 2) AS ToplamGelir
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN `Order Details` od ON o.OrderID = od.OrderID
GROUP BY c.CompanyName, c.Country
ORDER BY ToplamGelir DESC
LIMIT 10;

-- 3. KATEGORI BAZINDA SATISLAR
SELECT 
    cat.CategoryName AS Kategori,
    COUNT(od.OrderID) AS ToplamSiparis,
    ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)), 2) AS ToplamGelir
FROM Categories cat
JOIN Products p ON cat.CategoryID = p.CategoryID
JOIN `Order Details` od ON p.ProductID = od.ProductID
GROUP BY cat.CategoryName
ORDER BY ToplamGelir DESC;

-- 4. AYLIK SATIS TRENDI
SELECT 
    YEAR(o.OrderDate) AS Yil,
    MONTH(o.OrderDate) AS Ay,
    COUNT(o.OrderID) AS ToplamSiparis,
    ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)), 2) AS ToplamGelir
FROM Orders o
JOIN `Order Details` od ON o.OrderID = od.OrderID
GROUP BY YEAR(o.OrderDate), MONTH(o.OrderDate)
ORDER BY Yil, Ay;

-- 5. EN COK SATAN URUNLER
SELECT 
    p.ProductName AS UrunAdi,
    cat.CategoryName AS Kategori,
    SUM(od.Quantity) AS ToplamSatisMiktari,
    ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)), 2) AS ToplamGelir
FROM Products p
JOIN `Order Details` od ON p.ProductID = od.ProductID
JOIN Categories cat ON p.CategoryID = cat.CategoryID
GROUP BY p.ProductName, cat.CategoryName
ORDER BY ToplamGelir DESC
LIMIT 10;
