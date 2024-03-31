CREATE DATABASE library;

Use library;

CREATE TABLE Branch (
    Branch_no INT PRIMARY KEY,
    Manager_Id INT,
    Branch_address VARCHAR(255),
    Contact_no VARCHAR(15)
);

CREATE TABLE Employee (
    Emp_Id INT PRIMARY KEY,
    Emp_name VARCHAR(255),
    Position VARCHAR(50),
    Salary DECIMAL(10, 2),
    Branch_no INT,
    FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no)
);

CREATE TABLE Books (
    ISBN INT PRIMARY KEY,
    Book_title VARCHAR(255),
    Category VARCHAR(100),
    Rental_Price DECIMAL(10, 2),
    Status ENUM('yes', 'no'),
    Author VARCHAR(255),
    Publisher VARCHAR(255)
);

CREATE TABLE Customer (
    Customer_Id INT PRIMARY KEY,
    Customer_name VARCHAR(255),
    Customer_address VARCHAR(255),
    Reg_date DATE
);

CREATE TABLE IssueStatus (
    Issue_Id INT PRIMARY KEY,
    Issued_cust INT,
    Issued_book_name VARCHAR(255),
    Issue_date DATE,
    Isbn_book INT,
    FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);

CREATE TABLE ReturnStatus (
    Return_Id INT PRIMARY KEY,
    Return_cust INT,
    Return_book_name VARCHAR(255),
    Return_date DATE,
    Isbn_book2 INT,
    FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);

-- Inserting data into Branch table
INSERT INTO Branch (Branch_no, Manager_Id, Branch_address, Contact_no)
VALUES
(1, 101, '123 Main St', '123-456-7890'),
(2, 102, '456 Elm St', '987-654-3210'),
(3, 103, '789 Oak St', '456-789-0123'),
(4, 104, '321 Pine St', '321-654-0987'),
(5, 105, '987 Maple St', '789-012-3456');

-- Inserting data into Employee table
INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary, Branch_no)
VALUES
(1, 'John Doe', 'Manager', 60000, 1),
(2, 'Jane Smith', 'Assistant Manager', 45000, 1),
(3, 'Alice Johnson', 'Clerk', 35000, 2),
(4, 'Bob Williams', 'Clerk', 35000, 3),
(5, 'Charlie Brown', 'Clerk', 30000, 3);

-- Inserting data into Books table
INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher)
VALUES
(1, 'Book1', 'Fiction', 10.99, 'yes', 'Author1', 'Publisher1'),
(2, 'Book2', 'Non-fiction', 12.99, 'yes', 'Author2', 'Publisher2'),
(3, 'Book3', 'Science', 15.99, 'yes', 'Author3', 'Publisher3'),
(4, 'Book4', 'History', 9.99, 'no', 'Author4', 'Publisher4'),
(5, 'Book5', 'Biography', 14.99, 'yes', 'Author5', 'Publisher5');

-- Inserting data into Customer table
INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date)
VALUES
(1, 'Michael Johnson', '123 Apple St', '2021-05-15'),
(2, 'Emily Davis', '456 Banana St', '2021-07-20'),
(3, 'David Martinez', '789 Orange St', '2021-09-10'),
(4, 'Sarah Wilson', '321 Grape St', '2022-01-05'),
(5, 'Andrew Taylor', '987 Peach St', '2022-03-15');

-- Inserting data into IssueStatus table
INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book)
VALUES
(1, 1, 'Book1', '2022-02-01', 1),
(2, 2, 'Book2', '2022-02-05', 2),
(3, 3, 'Book3', '2022-02-10', 3),
(4, 4, 'Book4', '2022-02-15', 4),
(5, 5, 'Book5', '2022-02-20', 5);

-- Inserting data into ReturnStatus table
INSERT INTO ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2)
VALUES
(1, 1, 'Book1', '2022-03-01', 1),
(2, 2, 'Book2', '2022-03-05', 2),
(3, 3, 'Book3', '2022-03-10', 3),
(4, 4, 'Book4', '2022-03-15', 4),
(5, 5, 'Book5', '2022-03-20', 5);


-- Retrieve the book title, category, and rental price of all available books.

SELECT Book_title, Category, Rental_Price
FROM Books
WHERE Status = 'yes';

SELECT Emp_name, Salary
FROM Employee
ORDER BY Salary DESC;

SELECT b.Book_title, c.Customer_name
FROM Books b
INNER JOIN IssueStatus i ON b.ISBN = i.Isbn_book
INNER JOIN Customer c ON i.Issued_cust = c.Customer_Id;

SELECT Category, COUNT(*) AS Total_Count
FROM Books
GROUP BY Category;

SELECT Emp_name, Position
FROM Employee
WHERE Salary > 50000;

SELECT Customer_name
FROM Customer
WHERE Reg_date < '2022-01-01'
AND Customer_Id NOT IN (SELECT Issued_cust FROM IssueStatus);

SELECT Branch_no, COUNT(*) AS Total_Employees
FROM Employee
GROUP BY Branch_no;

SELECT DISTINCT c.Customer_name
FROM Customer c
JOIN IssueStatus i ON c.Customer_Id = i.Issued_cust
WHERE YEAR(i.Issue_date) = 2023 AND MONTH(i.Issue_date) = 6;

SELECT Book_title
FROM Books
WHERE Category = 'History';

SELECT Branch_no, COUNT(*) AS Total_Employees
FROM Employee
GROUP BY Branch_no
HAVING COUNT(*) > 5;













