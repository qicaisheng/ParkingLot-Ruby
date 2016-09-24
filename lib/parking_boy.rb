class ParkingBoy
  def initialize(*parking_lots)
    @parking_lots = parking_lots
  end

  def park(car)
    @parking_lots.each do |parking_lot|
      token = parking_lot.park(car)
      return token if token
    end
    false
  end

  def pick(token)
    @parking_lots.each do |parking_lot|
      car = parking_lot.pick(token)
      return car if car
    end
    nil
  end
end
