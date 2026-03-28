-- ==========================================
-- Скрипт создания таблиц
-- ==========================================

create table Classes
(
    class      VARCHAR(100)  not null,
    type       VARCHAR(20)   not null check (type in ('Racing', 'Street')),
    country    VARCHAR(100)  not null,
    numDoors   INT           not null,
    engineSize DECIMAL(3, 1) not null,
    weight     INT           not null,
    primary key (class)
);

create table Cars
(
    name  VARCHAR(100) not null,
    class VARCHAR(100) not null,
    year  INT          not null,
    primary key (name),
    foreign key (class) references Classes (class)
);

create table Races
(
    name VARCHAR(100) not null,
    date DATE         not null,
    primary key (name)
);

create table Results
(
    car      VARCHAR(100) not null,
    race     VARCHAR(100) not null,
    position INT          not null,
    primary key (car, race),
    foreign key (car) references Cars (name),
    foreign key (race) references Races (name)
);


-- ==========================================
-- Скрипт наполнения базы данными
-- ==========================================

insert into Classes (class, type, country, numDoors, engineSize, weight)
values ('SportsCar', 'Racing', 'USA', 2, 3.5, 1500),
       ('Sedan', 'Street', 'Germany', 4, 2.0, 1200),
       ('SUV', 'Street', 'Japan', 4, 2.5, 1800),
       ('Hatchback', 'Street', 'France', 5, 1.6, 1100),
       ('Convertible', 'Racing', 'Italy', 2, 3.0, 1300),
       ('Coupe', 'Street', 'USA', 2, 2.5, 1400),
       ('Luxury Sedan', 'Street', 'Germany', 4, 3.0, 1600),
       ('Pickup', 'Street', 'USA', 2, 2.8, 2000);


insert into Cars (name, class, year)
values ('Ford Mustang', 'SportsCar', 2020),
       ('BMW 3 Series', 'Sedan', 2019),
       ('Toyota RAV4', 'SUV', 2021),
       ('Renault Clio', 'Hatchback', 2020),
       ('Ferrari 488', 'Convertible', 2019),
       ('Chevrolet Camaro', 'Coupe', 2021),
       ('Mercedes-Benz S-Class', 'Luxury Sedan', 2022),
       ('Ford F-150', 'Pickup', 2021),
       ('Audi A4', 'Sedan', 2018),
       ('Nissan Rogue', 'SUV', 2020);


insert into Races (name, date)
values ('Indy 500', '2023-05-28'),
       ('Le Mans', '2023-06-10'),
       ('Monaco Grand Prix', '2023-05-28'),
       ('Daytona 500', '2023-02-19'),
       ('Spa 24 Hours', '2023-07-29'),
       ('Bathurst 1000', '2023-10-08'),
       ('Nürburgring 24 Hours', '2023-06-17'),
       ('Pikes Peak International Hill Climb', '2023-06-25');


insert into Results (car, race, position)
values ('Ford Mustang', 'Indy 500', 1),
       ('BMW 3 Series', 'Le Mans', 3),
       ('Toyota RAV4', 'Monaco Grand Prix', 2),
       ('Renault Clio', 'Daytona 500', 5),
       ('Ferrari 488', 'Le Mans', 1),
       ('Chevrolet Camaro', 'Monaco Grand Prix', 4),
       ('Mercedes-Benz S-Class', 'Spa 24 Hours', 2),
       ('Ford F-150', 'Bathurst 1000', 6),
       ('Audi A4', 'Nürburgring 24 Hours', 8),
       ('Nissan Rogue', 'Pikes Peak International Hill Climb', 3);
