-- ==========================================
-- Скрипт создания таблиц
-- ==========================================

create table Vehicle
(
    maker VARCHAR(100) not null,
    model VARCHAR(100) not null,
    type  VARCHAR(20)  not null check (type in ('Car', 'Motorcycle', 'Bicycle')),
    primary key (model)
);

create table Car
(
    vin             VARCHAR(17)    not null,
    model           VARCHAR(100)   not null,
    engine_capacity DECIMAL(4, 2)  not null,
    horsepower      INT            not null,
    price           DECIMAL(10, 2) not null,
    transmission    VARCHAR(20)    not null check (transmission in ('Automatic', 'Manual')),
    primary key (vin),
    foreign key (model) references Vehicle (model)
);

create table Motorcycle
(
    vin             VARCHAR(17)    not null,
    model           VARCHAR(100)   not null,
    engine_capacity DECIMAL(4, 2)  not null,
    horsepower      INT            not null,
    price           DECIMAL(10, 2) not null,
    type            VARCHAR(20)    not null check (type in ('Sport', 'Cruiser', 'Touring')),
    primary key (vin),
    foreign key (model) references Vehicle (model)
);

create table Bicycle
(
    serial_number VARCHAR(20)    not null,
    model         VARCHAR(100)   not null,
    gear_count    INT            not null,
    price         DECIMAL(10, 2) not null,
    type          VARCHAR(20)    not null check (type in ('Mountain', 'Road', 'Hybrid')),
    primary key (serial_number),
    foreign key (model) references Vehicle (model)
);


-- ==========================================
-- Скрипт наполнения базы данными
-- ==========================================

insert into Vehicle (maker, model, type)
values ('Toyota', 'Camry', 'Car'),
       ('Honda', 'Civic', 'Car'),
       ('Ford', 'Mustang', 'Car'),
       ('Yamaha', 'YZF-R1', 'Motorcycle'),
       ('Harley-Davidson', 'Sportster', 'Motorcycle'),
       ('Kawasaki', 'Ninja', 'Motorcycle'),
       ('Trek', 'Domane', 'Bicycle'),
       ('Giant', 'Defy', 'Bicycle'),
       ('Specialized', 'Stumpjumper', 'Bicycle');

insert into Car (vin, model, engine_capacity, horsepower, price, transmission)
values ('1HGCM82633A123456', 'Camry', 2.5, 203, 24000.00, 'Automatic'),
       ('2HGFG3B53GH123456', 'Civic', 2.0, 158, 22000.00, 'Manual'),
       ('1FA6P8CF0J1234567', 'Mustang', 5.0, 450, 55000.00, 'Automatic');

insert into Motorcycle (vin, model, engine_capacity, horsepower, price, type)
values ('JYARN28E9FA123456', 'YZF-R1', 1.0, 200, 17000.00, 'Sport'),
       ('1HD1ZK3158K123456', 'Sportster', 1.2, 70, 12000.00, 'Cruiser'),
       ('JKBVNAF156A123456', 'Ninja', 0.9, 150, 14000.00, 'Sport');

insert into Bicycle (serial_number, model, gear_count, price, type)
values ('SN123456789', 'Domane', 22, 3500.00, 'Road'),
       ('SN987654321', 'Defy', 20, 3000.00, 'Road'),
       ('SN456789123', 'Stumpjumper', 30, 4000.00, 'Mountain');
