use sakila;
select last_name, first_name, staff_id
from staff
where staff_id = (
    select max(staff_id)
    from staff
);
select last_name, first_name, count(fa.actor_id) as movies
from actor a,
     film_actor fa
where a.actor_id = fa.actor_id
group by last_name, first_name;

select staff_id, last_name, first_name
from staff
order by staff_id desc;
# **********************************************************
# Listing the actor who has the higher movie appearance.
select last_name, first_name, count(fa.actor_id) as movies
from actor a, film_actor fa
where a.actor_id = fa.actor_id
group by last_name, first_name
having movies = (
    select max(totalmovie)
    from (
             select count(fa.actor_id) as totalmovie
             from actor a,
                  film_actor fa
             where a.actor_id = fa.actor_id
             group by last_name, first_name) as core
);
# ............................................
select last_name, first_name, count(fa.actor_id) as Higher
from actor a,
     film_actor fa
where a.actor_id = fa.actor_id
group by last_name, first_name
having Higher = (
    select max(core.movies)
    from (
             select count(fa.actor_id) as movies
             from actor a,
                  film_actor fa
             where a.actor_id = fa.actor_id
             group by last_name, first_name
             order by movies desc
         ) core
);
# ********************************************


select name, l.language_id, count(f.language_id) as Higher
from language l,
     film f
where l.language_id = f.language_id
group by name, l.language_id
order by Higher desc
limit 1;

/*Select * From Employee E1 Where
        (N-1) = (Select Count(Distinct(E2.Salary))
        From Employee E2 Where
            E2.Salary > E1.Salary);*/
# List Nth Row
select last_name, first_name, actor_id
from actor a
where (10 - 1) = (
    select count(distinct b.actor_id)
    from actor b
    where b.actor_id < a.actor_id
);

select last_name, first_name, actor_id
from actor a
where not exists(
        select *
        from film_actor fa
        where fa.actor_id = a.actor_id
    );
select DISTINCT actor_id
from film_actor;
insert actor(first_name, last_name) VALUE ('Muller', 'Merkel');
insert into actor(first_name, last_name) VALUE ('Annalena', 'Boerboch');

use sakila;
# List actor with the higher actor_id
select actor_id,
       first_name,
       last_name,
       (
           select max(actor_id)
           from actor b
       ) as "Higher"
from actor a
having Higher = a.actor_id;

use hr_db;
# List Employees' details along with its average salary by department
select employee_id,
       first_name,
       last_name,
       salary,
       department_name,
       (
           select avg(b.salary)
           from employees b
           where b.department_id = e.department_id
       ) as Salary_avg
from employees e,
     departments d
where e.department_id = d.department_id
ORDER BY department_name,
         first_name,
         last_name;

# List employees whom the salary is above average of department
SELECT employee_id, first_name, last_name, salary, department_id
FROM employees e
WHERE salary > (SELECT AVG(salary)
                FROM employees
                WHERE department_id = e.department_id)
order by salary;
