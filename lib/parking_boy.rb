require 'parking_agent'

class ParkingBoy < ParkingAgent
  def report(placeholder)
    self_report = "#{placeholder}B #{all_available_space} #{all_space}\n"
    self_report + parking_lots_report(placeholder)
  end

  private
  def find_parking_lot
    @parking_lots.find { |parking_lot| parking_lot.canPark }
  end
end
