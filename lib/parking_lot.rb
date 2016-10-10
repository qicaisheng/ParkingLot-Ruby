require 'uuid'
require 'report_helper'

class ParkingLot
  attr_reader :capacity

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
    available_capacity > 0
  end

  def available_capacity
    @capacity - @storage.size
  end

  def available_spaces_rate
    return @capacity unless @capacity
    available_capacity / @capacity
  end

  def report(placeholder)
    ReportHelper.report_parking_lot(self, placeholder)
  end
end
