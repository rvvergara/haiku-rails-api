# frozen_string_literal: true

json.booking do
  json.partial! 'v1/shared/booking', booking: booking
end
