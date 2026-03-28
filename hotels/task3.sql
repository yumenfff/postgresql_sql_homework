with hotel_category as ( select h.ID_hotel,
                                h.name,
                                avg(r.price)            as avg_price,
                                case when avg(r.price) < 175 then 'Дешевый'
                                     when avg(r.price) <= 300 then 'Средний'
                                     else 'Дорогой' end as category
                         from Hotel h
                                  join Room r on h.ID_hotel = r.ID_hotel
                         group by h.ID_hotel, h.name ),
     customer_hotels as ( select c.ID_customer, c.name, hc.category, hc.name as hotel_name
                          from Customer c
                                   join Booking b on c.ID_customer = b.ID_customer
                                   join Room r on b.ID_room = r.ID_room
                                   join hotel_category hc on r.ID_hotel = hc.ID_hotel ),
     customer_preference as ( select ID_customer,
                                     name,
                                     case when sum(case when category = 'Дорогой' then 1 else 0 end) > 0 then 'Дорогой'
                                          when sum(case when category = 'Средний' then 1 else 0 end) > 0 then 'Средний'
                                          else 'Дешевый' end                                   as preferred_hotel_type,
                                     string_agg(distinct hotel_name, ',' order by hotel_name) as visited_hotels
                              from customer_hotels
                              group by ID_customer, name )
select ID_customer, name, preferred_hotel_type, visited_hotels
from customer_preference
order by case preferred_hotel_type when 'Дешевый' then 1 when 'Средний' then 2 when 'Дорогой' then 3 end, ID_customer;
