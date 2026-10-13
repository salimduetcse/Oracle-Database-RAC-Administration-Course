----- view create 
CREATE VIEW View_EmployeeSales AS
SELECT e.FirstName, e.LastName, SUM(i.Total) AS TotalSales
FROM Employee as e 
JOIN Customer as  c ON e.EmployeeId = c.SupportRepId
JOIN Invoice as i ON c.CustomerId = i.CustomerId
GROUP BY e.FirstName, e.LastName;

