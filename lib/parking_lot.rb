class ParkingLot
  def initialize(capacity)
    @capacity = capacity
    @storage = []
  end

  def park(car)
    return false unless canPark
    @storage.push(car)
  end

  def pick
    @storage.pop
  end

  def canPark
    @capacity > @storage.size
  end
end
