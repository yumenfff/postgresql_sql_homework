with car_stats as ( select c.name          as car_name,
                           c.class         as car_class,
                           c.year          as car_year,
                           avg(r.position) as average_position,
                           count(r.race)   as race_count
                    from Cars c
                             join Results r on c.name = r.car
                    group by c.name, c.class, c.year ),
     min_per_class as ( select car_class, min(average_position) as min_position from car_stats group by car_class )
select cs.car_name, cs.car_class, cs.average_position, cs.race_count
from car_stats cs
         join min_per_class mpc on cs.car_class = mpc.car_class and cs.average_position = mpc.min_position
order by cs.average_position, cs.car_year;
