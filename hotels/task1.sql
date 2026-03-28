with customer_bookings as ( select c.ID_customer,
                                   c.name,
                                   c.email,
                                   c.phone,
                                   count(b.ID_booking)                                        as total_bookings,
                                   count(distinct h.ID_hotel)                                 as unique_hotels,
                                   round(avg(b.check_out_date - b.check_in_date)::numeric, 4) as avg_stay,
                                   string_agg(distinct h.name, ', ' order by h.name)          as hotel_list
                            from Customer c
                                     join Booking b on c.ID_customer = b.ID_customer
                                     join Room r on b.ID_room = r.ID_room
                                     join Hotel h on r.ID_hotel = h.ID_hotel
                            group by c.ID_customer, c.name, c.email, c.phone )
select name, email, phone, total_bookings, hotel_list, avg_stay
from customer_bookings
where total_bookings > 2
  and unique_hotels > 1
order by total_bookings desc, name;
