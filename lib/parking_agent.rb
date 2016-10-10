require 'report_helper'

class ParkingAgent
  attr_reader :parking_lots

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

  def all_space
    @parking_lots.inject(0) { |sum, parking_lot| sum + parking_lot.capacity }
  end

  def all_available_space
    @parking_lots.inject(0) { |sum, parking_lot| sum + parking_lot.available_capacity }
  end

  def report(placeholder)
    ReportHelper.report_parking_boy_and_lots(self, placeholder)
  end

  def report_markdown(placeholder)
    ReportHelper.report_parking_boy_and_lots_with_markdown(self, placeholder)
  end

  private
  def find_parking_lot
  end
end
