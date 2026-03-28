select v.maker, m.model
from Motorcycle m
         join Vehicle v on m.model = v.model
where m.horsepower > 150
  and m.price < 20000
  and m.type = 'Sport'
order by m.horsepower desc;
