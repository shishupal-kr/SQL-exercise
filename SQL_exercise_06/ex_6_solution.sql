-- https://en.wikibooks.org/wiki/SQL_Exercises/Scientists
    show databases;
    use NASA;
    show tables;
select * from Scientists;
select * from AssignedTo;
select * from Projects;

-- 6.1 List all the scientists' names, their projects' names,
-- and the hours worked by that scientist on each project,
-- in alphabetical order of project name, then scientist name.
    select a.name,c.name,c.hours
    from scientists a
    inner join AssignedTo b
    on a.SSN = b.scientist
    inner join projects c
    on b.project = c.code
    order by c.name asc,a.name asc;

-- 6.2 Select the project names which are not assigned yet
select a.name
from projects a
left join assignedto b
on a.code = b.project
where b.project is null;
