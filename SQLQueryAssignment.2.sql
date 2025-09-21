-- 1. Create Students table
CREATE TABLE Students (
    StudentID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Age INT CHECK (Age >= 18),
    Course VARCHAR(50) DEFAULT 'General',
    AdmissionDate DATE NOT NULL
)

-- 2. Insert minimum 7 records
INSERT INTO Students (FirstName, LastName, Email, Age, Course, AdmissionDate)
VALUES
('Ravi', 'Kumar', 'ravi.kumar@example.com', 20, 'Computer Science', '2023-06-15'),
('Priya', 'Sharma', 'priya.sharma@example.com', 22, 'Mathematics', '2023-07-01'),
('Amit', 'Verma', 'amit.verma@example.com', 19, DEFAULT, '2023-06-20'),
('Neha', 'Singh', 'neha.singh@example.com', 21, 'Physics', '2023-06-25'),
('Karan', 'Patel', 'karan.patel@example.com', 23, 'Chemistry', '2023-06-30'),
('Anjali', 'Reddy', 'anjali.reddy@example.com', 20, DEFAULT, '2023-07-05'),
('Suresh', 'Naidu', 'suresh.naidu@example.com', 24, 'Biology', '2023-07-10')

select * from Students

-- 3a. ALTER the table to add new column PhoneNumber
ALTER TABLE Students
ADD PhoneNumber VARCHAR(15)

-- 3b. UPDATE age of one student (example: Ravi Kumar�s age to 21)
UPDATE Students
SET Age = 21
WHERE StudentID = 1

-- 3c. CREATE BACKUP of the table into Students_Backup
SELECT * 
INTO Students_Backup
FROM Students

-- 3d. Retrieve all updated data from the backup table
SELECT * FROM Students_Backup