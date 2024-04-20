DROP TABLE EMP;
DROP TABLE DPT;
DROP TABLE GRADES;
DROP TABLE REGISTRATION;
DROP TABLE COURSE;
DROP TABLE EMPLOYEE;
DROP TABLE TICKET;
DROP TABLE DEPARTMENT;
DROP TABLE STUDENT;

/* TABLE CREATION QUERIES */

CREATE TABLE STUDENT ( 
StudentID NUMBER GENERATED ALWAYS AS IDENTITY (START WITH 5000 INCREMENT BY 1)
    , FirstName VARCHAR2(100) NOT NULL
    , LastName VARCHAR2(100) NOT NULL
    , PhoneNumber INT UNIQUE NOT NULL CHECK (LENGTH(PhoneNumber) = 10)
    , City CHAR(50) NOT NULL
    , USState CHAR(2) NOT NULL /* It can be NY etc */
    , ZipCode INT DEFAULT 5 /* e.g 14214 */
    , Email VARCHAR2(100) UNIQUE NOT NULL
    , DateOfBirth DATE NOT NULL
    , CONSTRAINT STUDENT_PK PRIMARY KEY (StudentID) 
);


CREATE TABLE DEPARTMENT (
  DepartmentID NUMBER GENERATED ALWAYS AS IDENTITY (START WITH 3000 INCREMENT BY 1)
    , DepartmentName VARCHAR(255) UNIQUE NOT NULL
    , DepartmentType INT NOT NULL /* 0 Academic 1 Non-Academic */
    , CONSTRAINT DepartmentTypeCheck CHECK (DepartmentType IN (0, 1)) 
    , CONSTRAINT Department_PK PRIMARY KEY (DepartmentID)
);

    
CREATE TABLE TICKET (
  TicketID INT GENERATED ALWAYS AS IDENTITY (START WITH 1000 INCREMENT BY 1)
    , CreationDate DATE DEFAULT SYSDATE NOT NULL
    , TicketSubject VARCHAR2(255) NOT NULL
    , Status CHAR(20) NOT NULL
    , Priority CHAR(20) NOT NULL
    , TimeElapsed NUMBER(10, 2) NOT NULL
    , ReferenceTicket INT /* It can be a previous Ticket ID number for reference not compulsory */
    , StudentID NUMBER
    , DepartmentID INT NOT NULL
    , CONSTRAINT PriorityCheck CHECK (Priority IN ('High', 'Moderate', 'Low'))
    , CONSTRAINT StatusCheck CHECK (Status IN ('InProgress', 'Closed', 'Open'))
    , CONSTRAINT Ticket_PK PRIMARY KEY (TicketID)
    , CONSTRAINT Ticket_Student_FK FOREIGN KEY (StudentID) REFERENCES STUDENT(StudentID)
    , CONSTRAINT Ticket_Department_FK FOREIGN KEY (DepartmentID) REFERENCES DEPARTMENT(DepartmentID)
);


CREATE TABLE EMPLOYEE(
  EmployeeID INT GENERATED ALWAYS AS IDENTITY (START WITH 2000 INCREMENT BY 1)
  , EmpFirstName VARCHAR2(100) NOT NULL
  , EmpLastName VARCHAR2(100) NOT NULL
  , EmpEmail VARCHAR2(100) NOT NULL
  , EmployeeType INT NOT NULL
  , DepartmentID INT NOT NULL
  , CONSTRAINT EmployeeTypeCheck CHECK (EmployeeType IN (0, 1)) /* 0 Faculty 1 Staff */
  , CONSTRAINT Employee_PK PRIMARY KEY (EmployeeID)
  , CONSTRAINT Employee_FK FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
    
);


CREATE TABLE COURSE (
  CourseID INT GENERATED ALWAYS AS IDENTITY (START WITH 4000 INCREMENT BY 1)
  , CourseName VARCHAR2(100) UNIQUE NOT NULL
  , EmployeeID INT NOT NULL
  , EmployeeType INT NOT NULL
  , Semester CHAR(20) NOT NULL
  , SemYear INT NOT NULL
  , CONSTRAINT EmployeeTypeCheck_Course CHECK (EmployeeType IN (0)) /* Checks that if the Employee is a Faculty */
  , CONSTRAINT SemesterCheck CHECK (Semester IN ('Fall', 'Spring', 'Winter', 'Summer'))
  , CONSTRAINT Course_PK PRIMARY KEY (CourseID)
  , CONSTRAINT Course_FK_Employee FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);


CREATE TABLE REGISTRATION (
    RegistrationID INT GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1)
  , StudentID NUMBER NOT NULL
  , CourseID INT NOT NULL
  , CONSTRAINT Registration_PK PRIMARY KEY (RegistrationID)
  , CONSTRAINT Registration_FK_Student FOREIGN KEY (StudentID) REFERENCES STUDENT(StudentID)
  , CONSTRAINT Registration_FK_Course FOREIGN KEY (CourseID) REFERENCES COURSE(CourseID)
  , CONSTRAINT Registration_Course_Student_UK UNIQUE (CourseID, StudentID) /* Required for Grades Table */
);


CREATE TABLE GRADES (
    CourseGrade VARCHAR(2)
    , CourseID INT NOT NULL
    , StudentID NUMBER NOT NULL
    , CONSTRAINT CourseGradeCheck CHECK (
        CourseGrade IN ('A', 'A-', 'B+', 'B-', 'C+', 'C-', 'D+', 'D-', 'F')
    )
    , CONSTRAINT Grades_CourseID_StudentID_FK FOREIGN KEY (CourseID, StudentID) REFERENCES REGISTRATION(CourseID, StudentID) /* This Ensures that Grades can only be provided for the Registered Entries */
);

/* DPT WILL CONTAIN ONLY TWO ENTRIES: 0 FOR ACADEMIC AND 1 FOR NON-ACADEMIC */

CREATE TABLE DPT (
  DPTTYPE INT
  , DPTKIND VARCHAR(20) UNIQUE
  , CONSTRAINT DPTTYPE_PK PRIMARY KEY (DPTTYPE)
);

/* EMP WILL CONTAIN ONLY TWO ENTRIES: 0 FOR FACULTY AND 1 FOR STAFF */

CREATE TABLE EMP (
	EMPTYPE INT UNIQUE
	, EMPKIND CHAR(20) UNIQUE
    );


/* DATA ENTRY FOR STUDENT TABLE */

INSERT INTO STUDENT (FirstName, LastName, PhoneNumber, City, USState, ZipCode, Email, DateOfBirth)
VALUES ('John', 'Doe', 7234567890, 'New York', 'NY', 10001, 'john.doe@email.com', DATE '1995-05-10');

INSERT INTO STUDENT (FirstName, LastName, PhoneNumber, City, USState, ZipCode, Email, DateOfBirth)
VALUES ('Jane', 'Smith', 9876543210, 'Los Angeles', 'CA', 90001, 'jane.smith@email.com', DATE '1994-08-15');

INSERT INTO STUDENT (FirstName, LastName, PhoneNumber, City, USState, ZipCode, Email, DateOfBirth)
VALUES  ('Michael', 'Johnson', 5551234567, 'Chicago', 'IL', 60601, 'michael.j@email.com', DATE '1996-02-22');

INSERT INTO STUDENT (FirstName, LastName, PhoneNumber, City, USState, ZipCode, Email, DateOfBirth)
VALUES  ('Emily', 'Davis', 4447890123, 'Houston', 'TX', 77001, 'emily.d@email.com', DATE '1993-11-07');

INSERT INTO STUDENT (FirstName, LastName, PhoneNumber, City, USState, ZipCode, Email, DateOfBirth)
VALUES  ('Christopher', 'Brown', 7772345678, 'Phoenix', 'AZ', 85001, 'chris.b@email.com', DATE '1998-04-30');

INSERT INTO STUDENT (FirstName, LastName, PhoneNumber, City, USState, ZipCode, Email, DateOfBirth)
VALUES  ('Emma', 'Wilson', 6668901234, 'Philadelphia', 'PA', 19101, 'emma.w@email.com', DATE '1992-07-18');
  
INSERT INTO STUDENT (FirstName, LastName, PhoneNumber, City, USState, ZipCode, Email, DateOfBirth)
VALUES  ('Daniel', 'Miller', 3334567890, 'San Antonio', 'TX', 78201, 'daniel.m@email.com', DATE '1997-09-25');

INSERT INTO STUDENT (FirstName, LastName, PhoneNumber, City, USState, ZipCode, Email, DateOfBirth)
VALUES  ('Olivia', 'Moore', 2226543210, 'San Diego', 'CA', 92101, 'olivia.m@email.com', DATE '1991-12-12');

INSERT INTO STUDENT (FirstName, LastName, PhoneNumber, City, USState, ZipCode, Email, DateOfBirth)
VALUES  ('William', 'Taylor', 8881234567, 'Dallas', 'TX', 75201, 'william.t@email.com', DATE '1994-03-05');

INSERT INTO STUDENT (FirstName, LastName, PhoneNumber, City, USState, ZipCode, Email, DateOfBirth)
VALUES  ('Sophia', 'Anderson', 9997890123, 'San Francisco', 'CA', 94101, 'sophia.a@email.com', DATE '1990-06-20');

INSERT INTO STUDENT (FirstName, LastName, PhoneNumber, City, USState, ZipCode, Email, DateOfBirth)
VALUES  ('Matthew', 'White', 1112345678, 'Austin', 'TX', 73301, 'matthew.w@email.com', DATE '1996-01-03');

INSERT INTO STUDENT (FirstName, LastName, PhoneNumber, City, USState, ZipCode, Email, DateOfBirth)
VALUES  ('Ava', 'Harris', 2228901234, 'Seattle', 'WA', 98101, 'ava.h@email.com', DATE '1993-10-16');

INSERT INTO STUDENT (FirstName, LastName, PhoneNumber, City, USState, ZipCode, Email, DateOfBirth)
VALUES  ('Ethan', 'Martin', 7334567890, 'Denver', 'CO', 80201, 'ethan.m@email.com', DATE '1998-05-29');

INSERT INTO STUDENT (FirstName, LastName, PhoneNumber, City, USState, ZipCode, Email, DateOfBirth)
VALUES  ('Isabella', 'Jackson', 4446523210, 'Portland', 'OR', 97201, 'isabella.j@email.com', DATE '1992-08-23');

INSERT INTO STUDENT (FirstName, LastName, PhoneNumber, City, USState, ZipCode, Email, DateOfBirth)
VALUES  ('Mason', 'Johnson', 5557890123, 'Miami', 'FL', 33101, 'mason.j@email.com', DATE '1997-11-10');

INSERT INTO STUDENT (FirstName, LastName, PhoneNumber, City, USState, ZipCode, Email, DateOfBirth)
VALUES  ('Sophie', 'Roberts', 6662345678, 'Atlanta', 'GA', 30301, 'sophie.r@email.com', DATE '1991-02-14');

INSERT INTO STUDENT (FirstName, LastName, PhoneNumber, City, USState, ZipCode, Email, DateOfBirth)
VALUES  ('Jacob', 'Brown', 7778901234, 'Minneapolis', 'MN', 55401, 'jacob.b@email.com', DATE '1994-07-08');

INSERT INTO STUDENT (FirstName, LastName, PhoneNumber, City, USState, ZipCode, Email, DateOfBirth)
VALUES  ('Mia', 'Garcia', 8884567890, 'Detroit', 'MI', 48201, 'mia.g@email.com', DATE '1990-10-31');

INSERT INTO STUDENT (FirstName, LastName, PhoneNumber, City, USState, ZipCode, Email, DateOfBirth)
VALUES  ('Liam', 'Smith', 9996543210, 'New Orleans', 'LA', 70112, 'liam.s@email.com', DATE '1995-04-02');

INSERT INTO STUDENT (FirstName, LastName, PhoneNumber, City, USState, ZipCode, Email, DateOfBirth)
VALUES  ('Avery', 'King', 9876543270, 'Las Vegas', 'NV', 89101, 'avery.k@email.com', DATE '1993-09-19');

/* DATA ENTRY FOR DEPARTMENT TABLE */

INSERT INTO DEPARTMENT (DepartmentName, DepartmentType)
VALUES ('Computer Science', 0);

INSERT INTO DEPARTMENT (DepartmentName, DepartmentType)
VALUES  ('Chemical Engineering', 0);

INSERT INTO DEPARTMENT (DepartmentName, DepartmentType)
VALUES  ('Financial AID', 1);
    
INSERT INTO DEPARTMENT (DepartmentName, DepartmentType)
VALUES  ('Information Technology', 0);

INSERT INTO DEPARTMENT (DepartmentName, DepartmentType)
VALUES  ('Operations', 1);

INSERT INTO DEPARTMENT (DepartmentName, DepartmentType)
VALUES  ('Sales', 1);

INSERT INTO DEPARTMENT (DepartmentName, DepartmentType)
VALUES ('Customer Service', 1);

INSERT INTO DEPARTMENT (DepartmentName, DepartmentType)
VALUES  ('Research and Development', 0);

INSERT INTO DEPARTMENT (DepartmentName, DepartmentType)
VALUES  ('Legal', 1);

INSERT INTO DEPARTMENT (DepartmentName, DepartmentType)
VALUES  ('Hostel', 1);

INSERT INTO DEPARTMENT (DepartmentName, DepartmentType)
VALUES ('Data Science', 0);

INSERT INTO DEPARTMENT (DepartmentName, DepartmentType)
VALUES  ('Supply Chain', 1);

INSERT INTO DEPARTMENT (DepartmentName, DepartmentType)
VALUES  ('Public Relations', 1);

INSERT INTO DEPARTMENT (DepartmentName, DepartmentType)
VALUES  ('Engineering', 0);

INSERT INTO DEPARTMENT (DepartmentName, DepartmentType)
VALUES  ('Management Courses', 1);

INSERT INTO DEPARTMENT (DepartmentName, DepartmentType)
VALUES  ('Health and Safety', 1);

INSERT INTO DEPARTMENT (DepartmentName, DepartmentType)
VALUES  ('Facilities', 1);

INSERT INTO DEPARTMENT (DepartmentName, DepartmentType)
VALUES  ('Training and Development', 1);

INSERT INTO DEPARTMENT (DepartmentName, DepartmentType)
VALUES  ('Internal Audit', 1);

INSERT INTO DEPARTMENT (DepartmentName, DepartmentType)
VALUES  ('Communication', 0);

/* DATA ENTRY FOR TICKET TABLE */

/* NOTE: The TimeElapsed will be negative/positive depending on when the SQL script is ran since it takes SYSDATE. We have given random dates in the TO_DATE*/

INSERT INTO TICKET (CreationDate, TicketSubject, Status, Priority, TimeElapsed, StudentID, DepartmentID)
VALUES (CURRENT_TIMESTAMP, 'Network Outage', 'Open', 'High', ROUND((SYSDATE - TO_DATE('2023-11-21', 'YYYY-MM-DD')) * 24, 2), 5000, 3001);

INSERT INTO TICKET (CreationDate, TicketSubject, Status, Priority, TimeElapsed, StudentID, DepartmentID)
VALUES (CURRENT_TIMESTAMP, 'Software Bug', 'InProgress', 'Moderate', ROUND((SYSDATE - TO_DATE('2023-11-22', 'YYYY-MM-DD')) * 24, 2), 5001, 3002);

INSERT INTO TICKET (CreationDate, TicketSubject, Status, Priority, TimeElapsed, StudentID, DepartmentID)
VALUES (CURRENT_TIMESTAMP, 'Exam Scheduling Issue', 'Open', 'Low', ROUND((SYSDATE - TO_DATE('2023-11-23', 'YYYY-MM-DD')) * 24, 2), 5002, 3003);

INSERT INTO TICKET (CreationDate, TicketSubject, Status, Priority, TimeElapsed, StudentID, DepartmentID)
VALUES (CURRENT_TIMESTAMP, 'Library Access Problem', 'Closed', 'High', ROUND((SYSDATE - TO_DATE('2023-11-24', 'YYYY-MM-DD')) * 24, 2), 5003, 3001);

INSERT INTO TICKET (CreationDate, TicketSubject, Status, Priority, TimeElapsed, StudentID, DepartmentID)
VALUES (CURRENT_TIMESTAMP, 'Classroom Equipment Malfunction', 'Open', 'Low', ROUND((SYSDATE - TO_DATE('2023-11-25', 'YYYY-MM-DD')) * 24, 2), 5004, 3002);

INSERT INTO TICKET (CreationDate, TicketSubject, Status, Priority, TimeElapsed, StudentID, DepartmentID)
VALUES (CURRENT_TIMESTAMP, 'Exam Result Query', 'InProgress', 'Moderate', ROUND((SYSDATE - TO_DATE('2023-11-26', 'YYYY-MM-DD')) * 24, 2), 5005, 3003);

INSERT INTO TICKET (CreationDate, TicketSubject, Status, Priority, TimeElapsed, StudentID, DepartmentID)
VALUES (CURRENT_TIMESTAMP, 'Library Book Return', 'Open', 'Low', ROUND((SYSDATE - TO_DATE('2023-11-27', 'YYYY-MM-DD')) * 24, 2), 5006, 3001);

INSERT INTO TICKET (CreationDate, TicketSubject, Status, Priority, TimeElapsed, StudentID, DepartmentID)
VALUES (CURRENT_TIMESTAMP, 'Academic Transcript Issue', 'Closed', 'High', ROUND((SYSDATE - TO_DATE('2023-11-28', 'YYYY-MM-DD')) * 24, 2), 5007, 3002);

INSERT INTO TICKET (CreationDate, TicketSubject, Status, Priority, TimeElapsed, StudentID, DepartmentID)
VALUES (CURRENT_TIMESTAMP, 'Network Configuration Issue', 'InProgress', 'Moderate', ROUND((SYSDATE - TO_DATE('2023-11-29', 'YYYY-MM-DD')) * 24, 2), 5008, 3003);

INSERT INTO TICKET (CreationDate, TicketSubject, Status, Priority, TimeElapsed, StudentID, DepartmentID)
VALUES (CURRENT_TIMESTAMP, 'Software License Issue', 'Open', 'Low', ROUND((SYSDATE - TO_DATE('2023-11-30', 'YYYY-MM-DD')) * 24, 2), 5009, 3001);

INSERT INTO TICKET (CreationDate, TicketSubject, Status, Priority, TimeElapsed, StudentID, DepartmentID)
VALUES (CURRENT_TIMESTAMP, 'Computer Hardware Fault', 'Closed', 'High', ROUND((SYSDATE - TO_DATE('2023-12-01', 'YYYY-MM-DD')) * 24, 2), 5010, 3002);

INSERT INTO TICKET (CreationDate, TicketSubject, Status, Priority, TimeElapsed, StudentID, DepartmentID)
VALUES (CURRENT_TIMESTAMP, 'Software Installation Issue', 'InProgress', 'Moderate', ROUND((SYSDATE - TO_DATE('2023-12-02', 'YYYY-MM-DD')) * 24, 2), 5011, 3003);

INSERT INTO TICKET (CreationDate, TicketSubject, Status, Priority, TimeElapsed, StudentID, DepartmentID)
VALUES (CURRENT_TIMESTAMP, 'Email Account Setup', 'Open', 'Low', ROUND((SYSDATE - TO_DATE('2023-12-03', 'YYYY-MM-DD')) * 24, 2), 5012, 3001);

INSERT INTO TICKET (CreationDate, TicketSubject, Status, Priority, TimeElapsed, StudentID, DepartmentID)
VALUES (CURRENT_TIMESTAMP, 'Printer Configuration Issue', 'Closed', 'High', ROUND((SYSDATE - TO_DATE('2023-12-04', 'YYYY-MM-DD')) * 24, 2), 5013, 3002);

INSERT INTO TICKET (CreationDate, TicketSubject, Status, Priority, TimeElapsed, StudentID, DepartmentID)
VALUES (CURRENT_TIMESTAMP, 'Internet Connectivity Problem', 'InProgress', 'Moderate', ROUND((SYSDATE - TO_DATE('2023-12-05', 'YYYY-MM-DD')) * 24, 2), 5014, 3003);

INSERT INTO TICKET (CreationDate, TicketSubject, Status, Priority, TimeElapsed, StudentID, DepartmentID)
VALUES (CURRENT_TIMESTAMP, 'Software Upgrade Request', 'Open', 'Low', ROUND((SYSDATE - TO_DATE('2023-12-06', 'YYYY-MM-DD')) * 24, 2), 5015, 3001);

INSERT INTO TICKET (CreationDate, TicketSubject, Status, Priority, TimeElapsed, StudentID, DepartmentID)
VALUES (CURRENT_TIMESTAMP, 'Network Security Concern', 'Closed', 'High', ROUND((SYSDATE - TO_DATE('2023-12-07', 'YYYY-MM-DD')) * 24, 2), 5016, 3002);

INSERT INTO TICKET (CreationDate, TicketSubject, Status, Priority, TimeElapsed, StudentID, DepartmentID)
VALUES (CURRENT_TIMESTAMP, 'System Performance Issue', 'InProgress', 'Moderate', ROUND((SYSDATE - TO_DATE('2023-12-08', 'YYYY-MM-DD')) * 24, 2), 5017, 3003);

INSERT INTO TICKET (CreationDate, TicketSubject, Status, Priority, TimeElapsed, StudentID, DepartmentID)
VALUES (CURRENT_TIMESTAMP, 'Database Access Problem', 'Open', 'Low', ROUND((SYSDATE - TO_DATE('2023-12-09', 'YYYY-MM-DD')) * 24, 2), 5018, 3001);

INSERT INTO TICKET (CreationDate, TicketSubject, Status, Priority, TimeElapsed, StudentID, DepartmentID)
VALUES (CURRENT_TIMESTAMP, 'Hardware Replacement Request', 'Closed', 'High', ROUND((SYSDATE - TO_DATE('2023-12-10', 'YYYY-MM-DD')) * 24, 2), 5019, 3002);

/* DATA ENTRY FOR EMPLOYEE TABLE */

INSERT INTO EMPLOYEE (EmpFirstName, EmpLastName, EmpEmail, EmployeeType, DepartmentID) VALUES
  ('John', 'Smith', 'john.s@email.com', 1, 3001);

INSERT INTO EMPLOYEE (EmpFirstName, EmpLastName, EmpEmail, EmployeeType, DepartmentID) VALUES
  ('Emily', 'Jones', 'emily.j@email.com', 0, 3002);

INSERT INTO EMPLOYEE (EmpFirstName, EmpLastName, EmpEmail, EmployeeType, DepartmentID) VALUES
  ('Michael', 'Williams', 'michael.w@email.com', 1, 3003);

INSERT INTO EMPLOYEE (EmpFirstName, EmpLastName, EmpEmail, EmployeeType, DepartmentID) VALUES
  ('Jessica', 'Johnson', 'jessica.j@email.com', 0, 3001);

INSERT INTO EMPLOYEE (EmpFirstName, EmpLastName, EmpEmail, EmployeeType, DepartmentID) VALUES
  ('Christopher', 'Brown', 'chris.b@email.com', 1, 3002);

INSERT INTO EMPLOYEE (EmpFirstName, EmpLastName, EmpEmail, EmployeeType, DepartmentID) VALUES
  ('Ashley', 'Martin', 'ashley.m@email.com', 0, 3003);

INSERT INTO EMPLOYEE (EmpFirstName, EmpLastName, EmpEmail, EmployeeType, DepartmentID) VALUES
  ('David', 'Davis', 'david.d@email.com', 1, 3001);

INSERT INTO EMPLOYEE (EmpFirstName, EmpLastName, EmpEmail, EmployeeType, DepartmentID) VALUES
  ('Olivia', 'Thompson', 'olivia.t@email.com', 0, 3002);

INSERT INTO EMPLOYEE (EmpFirstName, EmpLastName, EmpEmail, EmployeeType, DepartmentID) VALUES
  ('William', 'Anderson', 'william.a@email.com', 1, 3003);

INSERT INTO EMPLOYEE (EmpFirstName, EmpLastName, EmpEmail, EmployeeType, DepartmentID) VALUES
  ('Sophia', 'Robinson', 'sophia.r@email.com', 0, 3001);

INSERT INTO EMPLOYEE (EmpFirstName, EmpLastName, EmpEmail, EmployeeType, DepartmentID) VALUES
  ('Daniel', 'Hill', 'daniel.h@email.com', 1, 3002);

INSERT INTO EMPLOYEE (EmpFirstName, EmpLastName, EmpEmail, EmployeeType, DepartmentID) VALUES
  ('Alex', 'Perry', 'alex.p@email.com', 0, 3003);

INSERT INTO EMPLOYEE (EmpFirstName, EmpLastName, EmpEmail, EmployeeType, DepartmentID) VALUES
  ('Hannah', 'White', 'hannah.w@email.com', 1, 3001);

INSERT INTO EMPLOYEE (EmpFirstName, EmpLastName, EmpEmail, EmployeeType, DepartmentID) VALUES
  ('Ethan', 'Taylor', 'ethan.t@email.com', 0, 3002);

INSERT INTO EMPLOYEE (EmpFirstName, EmpLastName, EmpEmail, EmployeeType, DepartmentID) VALUES
  ('Olivia', 'Moore', 'olivia.m@email.com', 1, 3003);

INSERT INTO EMPLOYEE (EmpFirstName, EmpLastName, EmpEmail, EmployeeType, DepartmentID) VALUES
  ('Mia', 'Garcia', 'mia.g@email.com', 0, 3001);

INSERT INTO EMPLOYEE (EmpFirstName, EmpLastName, EmpEmail, EmployeeType, DepartmentID) VALUES
  ('Liam', 'Johnson', 'liam.j@email.com', 1, 3002);

INSERT INTO EMPLOYEE (EmpFirstName, EmpLastName, EmpEmail, EmployeeType, DepartmentID) VALUES
  ('Avery', 'King', 'avery.k@email.com', 0, 3003);

INSERT INTO EMPLOYEE (EmpFirstName, EmpLastName, EmpEmail, EmployeeType, DepartmentID) VALUES
  ('Emma', 'Brown', 'emma.b@email.com', 1, 3001);

INSERT INTO EMPLOYEE (EmpFirstName, EmpLastName, EmpEmail, EmployeeType, DepartmentID) VALUES
  ('Mason', 'Clark', 'mason.c@email.com', 0, 3002);

/* DATA ENTRY FOR COURSE TABLE */

INSERT INTO COURSE (CourseName, EmployeeID, EmployeeType, Semester, SemYear)
VALUES  ('Software Engineering', 2004, 0, 'Spring', 2023);

INSERT INTO COURSE ( CourseName, EmployeeID, EmployeeType, Semester, SemYear)
VALUES  ('Network Security', 2005, 0, 'Fall', 2023);

INSERT INTO COURSE ( CourseName, EmployeeID, EmployeeType, Semester, SemYear)
VALUES('Mobile App Development', 2006, 0, 'Spring', 2023);

INSERT INTO COURSE ( CourseName, EmployeeID, EmployeeType, Semester, SemYear)
VALUES('Database Design', 2007, 0, 'Fall', 2023);

INSERT INTO COURSE ( CourseName, EmployeeID, EmployeeType, Semester, SemYear)
VALUES('Web Design', 2008, 0, 'Winter', 2023);

INSERT INTO COURSE ( CourseName, EmployeeID, EmployeeType, Semester, SemYear)
VALUES('Artificial Intelligence', 2009, 0, 'Winter', 2023);

INSERT INTO COURSE ( CourseName, EmployeeID, EmployeeType, Semester, SemYear)
VALUES('Computer Graphics', 2010, 0, 'Winter', 2023);

INSERT INTO COURSE ( CourseName, EmployeeID, EmployeeType, Semester, SemYear)
VALUES('Operating Systems', 2011, 0, 'Fall', 2023);

INSERT INTO COURSE ( CourseName, EmployeeID, EmployeeType, Semester, SemYear)
VALUES('Software Testing', 2012, 0, 'Summer', 2023);

INSERT INTO COURSE ( CourseName, EmployeeID, EmployeeType, Semester, SemYear)
VALUES('Computer Networks', 2013, 0, 'Summer', 2023);

INSERT INTO COURSE ( CourseName, EmployeeID, EmployeeType, Semester, SemYear)
VALUES('Machine Learning', 2014, 0, 'Spring', 2023);

INSERT INTO COURSE ( CourseName, EmployeeID, EmployeeType, Semester, SemYear)
VALUES('Algorithm Analysis', 2015, 0, 'Fall', 2023);

INSERT INTO COURSE ( CourseName, EmployeeID, EmployeeType, Semester, SemYear)
VALUES('Human-Computer Interaction', 2016, 0, 'Summer', 2023);

INSERT INTO COURSE ( CourseName, EmployeeID, EmployeeType, Semester, SemYear)
VALUES('Data Mining', 2017, 0, 'Fall', 2023);

INSERT INTO COURSE ( CourseName, EmployeeID, EmployeeType, Semester, SemYear)
VALUES('Cloud Computing', 2018, 0, 'Spring', 2023);

INSERT INTO COURSE ( CourseName, EmployeeID, EmployeeType, Semester, SemYear)
VALUES ('Computer Architecture', 2019, 0, 'Fall', 2023);

INSERT INTO COURSE ( CourseName, EmployeeID, EmployeeType, Semester, SemYear)
VALUES('Cybersecurity', 2012, 0, 'Spring', 2023);

INSERT INTO COURSE ( CourseName, EmployeeID, EmployeeType, Semester, SemYear)
VALUES('Python Programming Language', 2013, 0, 'Fall', 2023);

INSERT INTO COURSE ( CourseName, EmployeeID, EmployeeType, Semester, SemYear)
VALUES('Web Security', 2014, 0, 'Summer', 2023);
  
INSERT INTO COURSE ( CourseName, EmployeeID, EmployeeType, Semester, SemYear)
VALUES('Information Retrieval', 2015, 0, 'Winter', 2023);

INSERT INTO COURSE ( CourseName, EmployeeID, EmployeeType, Semester, SemYear)
VALUES('Distributed Systems', 2016, 0, 'Spring', 2023);

INSERT INTO COURSE ( CourseName, EmployeeID, EmployeeType, Semester, SemYear)
VALUES('Data Science', 2017, 0, 'Fall', 2023);

INSERT INTO COURSE ( CourseName, EmployeeID, EmployeeType, Semester, SemYear)
VALUES('E-commerce Technologies', 2018, 0, 'Spring', 2023);

INSERT INTO COURSE ( CourseName, EmployeeID, EmployeeType, Semester, SemYear)
VALUES('Computer Ethics', 2019, 0, 'Fall', 2023);  

/* DATA ENTRY FOR REGISTRATION TABLE */

INSERT INTO REGISTRATION (CourseID, StudentID)
VALUES (4000,5000);

INSERT INTO REGISTRATION (CourseID, StudentID)
VALUES(4001, 5001);

INSERT INTO REGISTRATION (CourseID, StudentID)
VALUES(4002, 5002);

INSERT INTO REGISTRATION (CourseID, StudentID)
VALUES(4003, 5003);

INSERT INTO REGISTRATION (CourseID, StudentID)
VALUES(4004, 5004);

INSERT INTO REGISTRATION (CourseID, StudentID)
VALUES(4005,5005);

INSERT INTO REGISTRATION (CourseID, StudentID)
VALUES(4006, 5006);

INSERT INTO REGISTRATION (CourseID, StudentID)
VALUES(4007, 5007);

INSERT INTO REGISTRATION (CourseID, StudentID)
VALUES(4008, 5008);

INSERT INTO REGISTRATION (CourseID, StudentID)
VALUES(4009, 5009);

INSERT INTO REGISTRATION (CourseID, StudentID)
VALUES(4010, 5010);

INSERT INTO REGISTRATION (CourseID, StudentID)
VALUES(4011, 5011);

INSERT INTO REGISTRATION (CourseID, StudentID)
VALUES(4012, 5012);

INSERT INTO REGISTRATION (CourseID, StudentID)
VALUES(4013, 5013);

INSERT INTO REGISTRATION (CourseID, StudentID)
VALUES(4014, 5014);

INSERT INTO REGISTRATION (CourseID, StudentID)
VALUES(4015, 5015);

INSERT INTO REGISTRATION (CourseID, StudentID)
VALUES(4016, 5016);

INSERT INTO REGISTRATION (CourseID, StudentID)
VALUES(4017, 5017);

INSERT INTO REGISTRATION (CourseID, StudentID)
VALUES(4018, 5018);

INSERT INTO REGISTRATION (CourseID, StudentID)
VALUES(4019, 5019);

INSERT INTO REGISTRATION (CourseID, StudentID)
VALUES(4012, 5001);

INSERT INTO REGISTRATION (CourseID, StudentID)
VALUES(4009, 5001);


/* DATA ENTRY FOR GRADES TABLE */

INSERT INTO GRADES (CourseGrade, CourseID, StudentID) 
VALUES('A-', 4001, 5001);

INSERT INTO GRADES (CourseGrade, CourseID, StudentID) 
VALUES('B+', 4002, 5002);

INSERT INTO GRADES (CourseGrade, CourseID, StudentID) 
VALUES('A-', 4003, 5003);

INSERT INTO GRADES (CourseGrade, CourseID, StudentID) 
VALUES('B-', 4004, 5004);

INSERT INTO GRADES (CourseGrade, CourseID, StudentID) 
VALUES('C+', 4005, 5005);

INSERT INTO GRADES (CourseGrade, CourseID, StudentID) 
VALUES('A-', 4006, 5006);

INSERT INTO GRADES (CourseGrade, CourseID, StudentID) 
VALUES('B-', 4007, 5007);

INSERT INTO GRADES (CourseGrade, CourseID, StudentID) 
VALUES('A-', 4008, 5008);

INSERT INTO GRADES (CourseGrade, CourseID, StudentID) 
VALUES('C+', 4009, 5009);

INSERT INTO GRADES (CourseGrade, CourseID, StudentID) 
VALUES('B+', 4010, 5010);

INSERT INTO GRADES (CourseGrade, CourseID, StudentID) 
VALUES('A-', 4011, 5011);

INSERT INTO GRADES (CourseGrade, CourseID, StudentID) 
VALUES('B-', 4012, 5012);

INSERT INTO GRADES (CourseGrade, CourseID, StudentID) 
VALUES('C-', 4013, 5013);

INSERT INTO GRADES (CourseGrade, CourseID, StudentID) 
VALUES('A-', 4014, 5014);

INSERT INTO GRADES (CourseGrade, CourseID, StudentID) 
VALUES('B+', 4015, 5015);

INSERT INTO GRADES (CourseGrade, CourseID, StudentID) 
VALUES('A-', 4016, 5016);

INSERT INTO GRADES (CourseGrade, CourseID, StudentID) 
VALUES('B-', 4017, 5017);

INSERT INTO GRADES (CourseGrade, CourseID, StudentID) 
VALUES('C+', 4018, 5018);

INSERT INTO GRADES (CourseGrade, CourseID, StudentID) 
VALUES('A-', 4019, 5019);

INSERT INTO GRADES (CourseGrade, CourseID, StudentID) 
VALUES('A-', 4012, 5001);

INSERT INTO GRADES (CourseGrade, CourseID, StudentID) 
VALUES('A-', 4009, 5001);

/* DATA ENTRY FOR DPT TABLE */

INSERT INTO DPT (DPTTYPE, DPTKIND)
VALUES (0, 'Academic');

INSERT INTO DPT (DPTTYPE, DPTKIND)
VALUES (1, 'Non-Academic');

/* DATA ENTRY FOR EMP TABLE */

INSERT INTO EMP (EMPTYPE, EMPKIND)
VALUES (0, 'Faculty');

INSERT INTO EMP (EMPTYPE, EMPKIND)
VALUES (1, 'Staff');

/* SELECT QUERY TO DISPLAY DATA IN THE TABLES */

SELECT * FROM STUDENT;
SELECT * FROM DEPARTMENT;
SELECT * FROM TICKET;
SELECT * FROM EMPLOYEE;
SELECT * FROM COURSE;
SELECT * FROM REGISTRATION;
SELECT * FROM GRADES;
SELECT * FROM DPT;
SELECT * FROM EMP;
