require 'parking_boy'

class  Manager < ParkingBoy
  PARKING_BOY_TYPE = %w(parking_boy smart_parking_boy super_parking_boy)

  def initialize(resource)
    @parking_lots = resource[:parking_lots]
    @parking_boys = resource[:parking_boys]
    @smart_parking_boys = resource[:smart_parking_boys]
    @super_parking_boys = resource[:super_parking_boys]
  end

  def park_by(parking_boy, car)
    return false unless all_parking_boys.include? parking_boy
    parking_boy.park(car)
  end

  def pick_by(parking_boy, car)
    return false unless all_parking_boys.include? parking_boy
    parking_boy.pick(car)
  end

  PARKING_BOY_TYPE.each do |type|
    define_method("park_by_#{type}") do |car|
      eval("@#{type}s").each do |child_type|
        token = child_type.park(car)
        return token if token
      end
      false
    end

    define_method("pick_by_#{type}") do |token|
      eval("@#{type}s").each do |child_type|
        car = child_type.pick(token)
        return car if car
      end
      nil
    end
  end

  private
  def all_parking_boys
    Array(@parking_boys) + Array(@smart_parking_boys) + Array(@super_parking_boys)
  end
end
