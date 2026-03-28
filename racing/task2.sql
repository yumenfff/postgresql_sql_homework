with car_stats as ( select c.name          as car_name,
                           c.class         as car_class,
                           avg(r.position) as average_position,
                           count(r.race)   as race_count
                    from Cars c
                             join Results r on c.name = r.car
                    group by c.name, c.class )
select cs.car_name, cs.car_class, cs.average_position, cs.race_count, cl.country as car_country
from car_stats cs
         join Classes cl on cs.car_class = cl.class
where cs.average_position = ( select min(average_position) from car_stats )
order by cs.car_name
limit 1;
