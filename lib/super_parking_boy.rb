require 'parking_boy'

class SuperParkingBoy < ParkingBoy
  private
  def find_parking_lot
    @parking_lots.max { |a, b| a.available_spaces_rate <=> b.available_spaces_rate }
  end
end
