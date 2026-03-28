select c.ID_customer,
       c.name,
       count(b.ID_booking)        as total_bookings,
       sum(r.price)               as total_spent,
       count(distinct r.ID_hotel) as unique_hotels
from Customer c
         join Booking b on c.ID_customer = b.ID_customer
         join Room r on b.ID_room = r.ID_room
group by c.ID_customer, c.name
having count(b.ID_booking) > 2
   and count(distinct r.ID_hotel) > 1
   and sum(r.price) > 500
order by total_spent asc;
