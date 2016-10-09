class ParkingAgent
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

  def parking_lots_report(placeholder)
    @parking_lots.map{ |parking_lot| parking_lot.report("#{placeholder}") }.join
  end

  def self_report(placeholder)
    "#{placeholder}B #{all_available_space} #{all_space}\n"
  end

  def report(placeholder)
    self_report(placeholder) + parking_lots_report(placeholder + "\t")
  end

  def report_markdown(placeholder)
    self_report(placeholder) + parking_lots_report(placeholder + '#')
  end

  private
  def find_parking_lot
  end
end
