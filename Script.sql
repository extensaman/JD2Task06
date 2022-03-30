/* Part 1 */
create database classwork;

use classwork;

create table persons
(
    id int auto_increment primary key,
    surname varchar(40),
    name varchar(40),
    patronymic varchar(40)
);

create table projects
(
    id int auto_increment primary key,
    project_name varchar(30),
    project_perform_time int,
    project_hardness varchar(30),
    project_coordinator_id int,
    constraint projects_persons_fk
        foreign key (project_coordinator_id) references persons(id)
);

create table tasks
(
    id int auto_increment primary key,
    task_name varchar(30),
    task_perform_time int,
    task_price int,
    task_performer_id int,
    project_id int,
    constraint tasks_persons_fk
    foreign key (task_performer_id) references persons(id),
    constraint tasks_projects_fk
    foreign key (project_id) references projects(id)
);

insert into persons (surname, name, patronymic) VALUES
('Петров','Петя','Сергеевич'),
('Смирнов','Сергей','Сергеевич'),
('Федоров','Сергей','Юрьевич');

insert into projects (project_name, project_perform_time,
                      project_hardness, project_coordinator_id) VALUES
('Проект 1',2,'Сложный',2),
('Проект 2',1,'Легкий',3);

insert into tasks (task_name, task_perform_time, task_price, task_performer_id, project_id) VALUES
('Задача 1',4,2000,1,1),
('Задача 2',8,2500,2,1),
('Задача 3',4,1000,2,1),
('Задача 4',5,3000,3,2),
('Задача 5',3,500,1,2);

select task_name,project_name,task_perform_time,project_perform_time,
    concat(task_price,' ', p2.surname, ' ', p2.name, ' ', p2.patronymic),
    concat(p1.project_hardness, ' ', p3.surname, ' ', p3.name, ' ', p3.patronymic) from tasks
join projects p1 on tasks.project_id = p1.id
join persons p2 on tasks.task_performer_id = p2.id
join persons p3 on p1.project_coordinator_id = p3.id
order by task_name;

/* Part 2 */
select task_name, project_name, project_hardness from tasks
join projects p on tasks.project_id = p.id
where p.project_hardness LIKE 'Сложный';

/* Part 3 */
select project_name, SUM(task_price) from tasks
join projects p on tasks.project_id = p.id
group by project_name;

/* Part 4 */
select project_name, SUM(task_price) from tasks
join projects p on tasks.project_id = p.id
group by project_name
having SUM(task_price) > 4000;

/* Part 5 */
update projects set project_name='Проект 25' where project_name='Проект 1';