with car_stats as ( select c.name          as car_name,
                           c.class         as car_class,
                           avg(r.position) as average_position,
                           count(r.race)   as race_count
                    from Cars c
                             join Results r on c.name = r.car
                    group by c.name, c.class ),
     class_stats as ( select car_class, avg(average_position) as class_avg_position, sum(race_count) as total_races
                      from car_stats
                      group by car_class ),
     min_class as ( select min(class_avg_position) as min_position from class_stats )
select cs.car_name, cs.car_class, cs.average_position, cs.race_count, cl.country as car_country, cls.total_races
from car_stats cs
         join class_stats cls on cs.car_class = cls.car_class
         join Classes cl on cs.car_class = cl.class
         join min_class mc on cls.class_avg_position = mc.min_position
order by cs.car_name;
