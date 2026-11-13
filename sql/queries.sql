-- BrightSmile Dental: main queries from the Access database
-- Rewritten in standard SQL from the Access query designer, so they read the same in any SQL tool.

-- 1. Supplies at or below their reorder point (InventoryBelowReorderQ)
SELECT ItemID, ItemName, QuantityOnHand, ReorderPoint
FROM InventoryItem
WHERE QuantityOnHand <= ReorderPoint;

-- 2. Revenue and number of visits by procedure (RevenueByProcedureQ)
SELECT pc.ProcedureName,
       SUM(ap.FeeCharged) AS TotalRevenue,
       COUNT(*)           AS Visits
FROM ProcedureCatalog AS pc
INNER JOIN AppointmentProcedure AS ap ON ap.ProcedureID = pc.ProcedureID
GROUP BY pc.ProcedureName
ORDER BY SUM(ap.FeeCharged) DESC;

-- 3. Patient list behind the Patients screen (dashboardpa)
SELECT PatientID, FirstName, LastName, DateOfBirth, Gender, CellPhone,
       Address, ZipCode, City, State, Insurance, Email,
       EmergencyContact, EmergencyNumber, Notes
FROM PatientTable;

-- 4. Appointment list behind the Appointments screen (dashappt)
SELECT ApptID, PatientID, FirstName, LastName, Insurance, Gender, DOB,
       ApptDate, ApptTime, AppointmentStatus, AppointmentProcedure, Provider,
       Address, CellPhone, Email, EmergencyNumber, PaymentBalance, EmployeeID
FROM Appointment;

-- 5. Employee list behind the Employees screen (dashboardQ)
SELECT EmployeeID, FirstName, LastName, JobTitle, WorkDay, HourlyRate,
       Phone, Email, Address, City, State, ZipCode
FROM EmployeeTable;
