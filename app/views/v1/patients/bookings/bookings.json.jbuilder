json.bookings do
  json.array! bookings do |booking|
    json.partial! 'v1/shared/booking', booking: booking
  end
end