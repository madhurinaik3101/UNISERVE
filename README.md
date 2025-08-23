# UNISERVE
---

## Table of Contents

- [Overview](#overview)
- [Situation](#situation)
- [Task](#task)
- [Action](#action)
- [Result](#results)    
- [Technologies Used](#technologies-used)
- [Demo](#demo) 

---

## Overview

UNISERVE RDBMS is a centralized platform that streamlines communication between students and university departments. Instead of relying on scattered email threads, students create tickets that are assigned to the correct department member, ensuring transparency, accountability, and faster resolution.
Unlike email-based communication, this system prevents lost queries, avoids long email chains, and gives both students and faculty/staff real-time visibility into issue status and workload.

##  Situation:  

At universities, students often face challenges when reaching out to faculty or administrative departments. The email-based communication system leads to:
1. Overflowing inboxes with 100+ student queries.
2. Long, unorganized email threads.
3. Important queries and deadlines are being missed.
4. Frustration on both the student and faculty sides.

Students hesitate to follow up on their questions because of these inefficiencies, while faculty/staff struggle to track and respond to multiple issues simultaneously.

##  Task:  

The goal was to design and implement a ticketing database system that would:
1. Allow students to create tickets containing their queries.
2. Automatically assign tickets to the appropriate department or faculty/staff.
3. Provide visibility into ticket status and ownership.
4. Ensure that communication is streamlined, traceable, and efficient.

## Action

1. Defined Business Rules & Requirements: Established constraints (e.g., one student per ticket, departments as academic/non-academic, faculty teach ≥1 course, staff linked to one department).
2. ERD & Data Modeling: Designed a normalized Entity-Relationship Diagram (ERD) in Lucidchart, mapping relationships between students, departments, employees, courses, and tickets.
3. Database Implementation in MySQL: Built relational tables with integrity constraints and ticket workflows (status, priority, reopening of tickets).
4. Analytics & Dashboards: Developed Power BI reports showing:
Number of open vs resolved tickets.
Average resolution time by department.
Ticket distribution by priority.
Faculty/staff workload metrics.
5. Use Case Testing: Example – a student raises a Financial Aid ticket → routed to the correct staff member → response logged in the system → student tracks status until resolution.

# Business Rules
1. Within the system, only Students can create Tickets. 
2. One ticket should be linked to only one student. 
3. One ticket should be linked to only one department at a time. 
4. Students can create one or many tickets for a department.  
5. A Department can have zero or many tickets.  
6. A Department can be either Academic or Nonacademic, but cannot be both simultaneously.  
7. Faculty belongs to the Academic Departments. 
8. Staff can belong to Non-Academic Departments. 
9. Employees are either Faculty or Staff, but cannot be both at the same time. 
10. Each course must have at least one professor assigned to it. 
11. An instructor can teach one or more courses.  
12. A student can only receive one grade for a course.  
13. The ticket status will be open, in progress, or resolved to track the development. 
14. The students can choose the priority level for their tickets (low, medium, or high). 
15. A student cannot raise a ticket for a course in which they are not registered.  
16. A student should be registered for at least one course only belongs to the term enrolled. 
17. A student can have one or multiple registrations.
18. A Department has one or many Employees. 
19. An Employee should be associated with only one Department.

## Results

1. Improved student experience with real-time ticket tracking instead of lost email chains.
2. Increased accountability by assigning tickets directly to the right department/employee.
3. Reduced delays by prioritizing and routing queries automatically.
4. Better workload management for staff/faculty with clear visibility into ticket assignments.
5. Scalable solution that supports both academic and non-academic university departments.

## Technologies Used

1. Data Modeling: Lucidchart (ERD)
2. Database: MySQL
3. Analytics & Reporting: Microsoft Power BI
4. Version Control & Collaboration: Git & GitHub

## Demo

![UNISERVE-Demo](https://github.com/user-attachments/assets/5e1019a8-c715-4463-9947-48c348b29905)

LINK: https://drive.google.com/file/d/15KbwaO97ZRzVcO9ZFHp84MOsjYQoqes5/view?usp=drive_link















