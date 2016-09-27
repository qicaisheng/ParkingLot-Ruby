require 'parking_agent'

class SmartParkingBoy < ParkingAgent
  private
  def find_parking_lot
    @parking_lots.max { |a, b| a.available_capacity <=> b.available_capacity }
  end
end
