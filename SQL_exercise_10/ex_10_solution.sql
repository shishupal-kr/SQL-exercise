show databases;
use human;
show tables;

select * from address;
select * from people;

-- 10.1 Join table PEOPLE and ADDRESS, but keep only one address information for each person (we don't mind which record we take for each person).
-- i.e., the joined table should have the same number of rows as table PEOPLE
-- 10.2 Join table PEOPLE and ADDRESS, but ONLY keep the LATEST address information for each person.
    select *
    from people
    left join address
    on
     people.id = address.id
     AND address.updatedate =
         (SELECT MAX(updatedate)
          FROM ADDRESS
          WHERE id = people.id);
-- i.e., the joined table should have the same number of rows as table PEOPLE
