require 'parking_boy'

class SmartParkingBoy < ParkingBoy
  private
  def find_parking_lot
    @parking_lots.max { |a, b| a.available_capacity <=> b.available_capacity }
  end
end
