with car_stats as ( select c.name          as car_name,
                           c.class         as car_class,
                           avg(r.position) as average_position,
                           count(r.race)   as race_count
                    from Cars c
                             join Results r on c.name = r.car
                    group by c.name, c.class ),
     class_stats as ( select car_class,
                             sum(race_count)                                          as total_races,
                             sum(case when average_position >= 3.0 then 1 else 0 end) as low_position_count
                      from car_stats
                      group by car_class )
select cs.car_name,
       cs.car_class,
       cs.average_position,
       cs.race_count,
       cl.country as car_country,
       cls.total_races,
       cls.low_position_count
from car_stats cs
         join class_stats cls on cs.car_class = cls.car_class
         join Classes cl on cs.car_class = cl.class
where cs.average_position > 3.0
order by cls.low_position_count desc, cs.average_position, cs.car_name;
