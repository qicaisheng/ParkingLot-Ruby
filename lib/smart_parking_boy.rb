require 'parking_boy'

class SmartParkingBoy < ParkingBoy
  def park(car)
    find_parking_lot = @parking_lots.max { |a, b| a.available_capacity <=> b.available_capacity }
    return nil unless find_parking_lot
    find_parking_lot.park(car)
  end
end
