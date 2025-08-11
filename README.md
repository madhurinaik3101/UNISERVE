# UNISERVE
UNISERVE is an Internal University Ticketing Database Management System

---

## Table of Contents

- [Overview](#overview)
- [How It Works](#how-it-works)    
- [Technologies Used](#technologies-used)  

---

## Overview

# Business Context:  
We observed that managing communication with various departments in a university is a common 
challenge for college students, especially for newly admitted students. The most common medium 
of communication used across departments is email. There are diverse topics, like doubts in a 
particular lecture, technical issues with the grading tools, etc., for which the students reach out to 
the faculty. It is hard for the faculty to keep track of queries coming from over 100 students 
by email. Similar problems arise in various other departments of the University. The email 
communication method can lead to issues like spam and long, tedious email threads that get buried 
over time.  This can lead to missing important deadlines, as well as a buildup of frustration on both 
sides. Currently, based on the challenge above, students often hesitate to follow up on questions 
they may have, as the process to do so is time-consuming.  

# Solution:  
To solve this problem, our team decided to take on this project to create a database that will act 
as a uniform system that streamlines the communication process between students and any 
participating entity in the university. When it comes to their classes, students will be able to create 
a “ticket” that contains all the data of their query and that will be assigned to the intended 
department member, allowing both parties to have easy access and visibility to the ticket. This also 
includes that each department member has information about how many tickets they have assigned 
to them, and the students will have knowledge of the status of their tickets. One such use case of 
our ticketing database is that if a student has a question regarding financial aid, they can open a ticket 
with the Office of Financial Aid through our system. The ticket gets assigned to an employee 
of the Office of Financial Aid, and the employee would respond to it online. Another use case is if 
a student has doubts regarding a specific lecture in a course, the ticket created by the student will 
contain all the data required by the instructor to work on the issue faced. Multiple things can be done; for instance, a student can reopen a ticket if they have not understood the 
resolution. This saves time on both ends as the student does not have to go in person or be restricted 
by the operation hours. The above-mentioned are some of the many solutions that our database 
system provides. 


---

## How It Works

# Business Rules
1. Within the system, only Students can create Tickets. 
2. One ticket should be linked to only one student. 
3. One ticket should be linked to only one department at a time. 
4. Students can create one or many tickets for a department.  
5. A Department can have zero or many tickets.  
6. A Department can be either Academic or Nonacademic but cannot be both 
simultaneously.  
7. Faculty belongs to the Academic Departments. 
8. Staff can belong to Non-Academic Departments. 
9. Employees are either Faculty or Staff but cannot be both at the same time. 
10. Each course must have at least one professor assigned to it. 
11. An instructor can teach one or more courses.  
12. A student can only receive one grade for a course.  
13. The ticket status will be open, in progress, or resolved to track the development. 
14. The students can choose the priority level for their tickets (low, medium, or high). 
15. A student cannot raise a ticket for a course in which they are not registered.  
16. A student should be registered for at least one course only belonging to the term enrolled. 
17. A student can have one or multiple registrations. 


## Technologies Used

1. Lucidchart
2. MySQL
3. Microsoft Power BI













18. A Department has one or many Employees. 
19. An Employee should be associated with only one Department.
