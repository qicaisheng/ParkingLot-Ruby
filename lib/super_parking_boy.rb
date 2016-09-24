require 'parking_boy'

class SuperParkingBoy < ParkingBoy
  def park(car)
    find_parking_lot = @parking_lots.max { |a, b| a.available_spaces_rate <=> b.available_spaces_rate }
    return nil unless find_parking_lot
    find_parking_lot.park(car)
  end
end
