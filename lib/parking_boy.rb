class ParkingBoy
  def initialize(*parking_lots)
    @parking_lots = parking_lots
  end

  def park(car)
    return false unless find_parking_lot
    find_parking_lot.park(car)
  end

  def pick(token)
    @parking_lots.each do |parking_lot|
      car = parking_lot.pick(token)
      return car if car
    end
    nil
  end

  private
  def find_parking_lot
    @parking_lots.find { |parking_lot| parking_lot.canPark }
  end
end
