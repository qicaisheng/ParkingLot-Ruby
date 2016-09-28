require 'parking_agent'

class ParkingBoy < ParkingAgent
  private
  def find_parking_lot
    @parking_lots.find { |parking_lot| parking_lot.canPark }
  end
end
