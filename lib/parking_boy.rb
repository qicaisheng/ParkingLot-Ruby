class ParkingBoy
  def initialize(parking_lot)
    @parking_lot = parking_lot
  end

  def park(car)
    @parking_lot.park(car)
  end

  def pick(token)
    @parking_lot.pick(token)
  end
end
