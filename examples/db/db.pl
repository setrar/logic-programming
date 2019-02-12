% https://www3.cs.stonybrook.edu/~warren/xsbbook/node11.html
% Prolog as a Database Query Langauge

% ?- consult(db)
% |    .
% true.

% ?- well_paid_emp('John','Jones').
% false.

% ?- well_paid_emp('Betty','Doe').  
% true.

% ?- deli_manager('Betty','Doe'). 
% false.

% ?- deli_manager('John','Jones'). 
% true.

employee(193,'Jones','John','173 Elm St.','Hoboken','NJ', 12345,1,'25 Jun 93',25500).
employee(181,'Doe','Betty','11 Spring St.','Paterson','NJ', 12354,3,'12 May 91',28500).
employee(198,'Smith','Al','2 Ace Ave.','Paterson','NJ', 12354,3,'12 Sep 93',27000).
department(1,'Grocery',181).
department(3,'Deli',193).
department(5,'Produce',199).

well_paid_emp(First,Last) :-
    employee(_Num,Last,First,_Addr,_City,_St,_Zip,_Dept,_Date,Sal),
    Sal > 28000.

deli_manager(First,Last) :- 
    department(_Deptno,'Deli',MgrID),
    employee(MgrID,Last,First,_Addr,_City,_St,_Zip,_Dept,_Date,_Sal).
