require 'uuid'

class ParkingLot
  def initialize(capacity)
    @capacity = capacity
    @storage = {}
  end

  def park(car)
    return false unless canPark
    token = UUID.generate
    @storage[token] = car
    token
  end

  def pick(token)
    @storage.delete(token)
  end

  def canPark
    @capacity > @storage.size
  end

  def available_capacity
    @capacity - @storage.size
  end
end
