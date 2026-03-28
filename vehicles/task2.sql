select v.maker, c.model, c.horsepower, c.engine_capacity, 'Car' as vehicle_type
from Car c
         join Vehicle v on c.model = v.model
where c.horsepower > 150
  and c.engine_capacity < 3
  and c.price < 35000

union all

select v.maker, m.model, m.horsepower, m.engine_capacity, 'Motorcycle' as vehicle_type
from Motorcycle m
         join Vehicle v on m.model = v.model
where m.horsepower > 150
  and m.engine_capacity < 1.5
  and m.price < 20000

union all

select v.maker, b.model, null as horsepower, null as engine_capacity, 'Bicycle' as vehicle_type
from Bicycle b
         join Vehicle v on b.model = v.model
where b.gear_count > 18
  and b.price < 4000

order by horsepower desc nulls last, model desc;
