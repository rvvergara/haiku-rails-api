# frozen_string_literal: true

json.id availability.id
json.practitioner_id availability.practitioner_id
json.date availability.availability_date.strftime('%B %d, %Y')
json.start_time availability.start_time.strftime('%H:%M %P')
json.end_time availability.end_time.strftime('%H:%M %P')
json.booked availability.booked
json.booking_id availability.booking_id
