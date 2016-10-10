require 'report_helper'

class  Manager
  attr_reader :parking_lots

  PARKING_BOY_TYPE = %w(parking_boy smart_parking_boy super_parking_boy)

  def initialize(resource)
    @parking_lots = resource[:parking_lots] || []
    @parking_boys = resource[:parking_boys] || []
    @smart_parking_boys = resource[:smart_parking_boys] || []
    @super_parking_boys = resource[:super_parking_boys] || []
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

  def report
    ReportHelper.report_manager_and_resources(self)
  end

  def report_markdown
    ReportHelper.report_manager_and_resources_with_markdown(self)
  end

  def all_space
    all_space_of_managed_parking_lots = \
      @parking_lots.inject(0) { |sum, parking_lot| sum + parking_lot.capacity }
    all_space_of_managed_parking_boys = \
      all_parking_boys.inject(0) { |sum, parking_boy| sum + parking_boy.all_space }
    all_space_of_managed_parking_lots + all_space_of_managed_parking_boys
  end

  def all_available_space
    all_available_space_of_managed_parking_lots = \
      @parking_lots.inject(0) { |sum, parking_lot| sum + parking_lot.available_capacity }
    all_available_space_of_managed_parking_boys = \
      all_parking_boys.inject(0) { |sum, parking_boy| sum + parking_boy.all_available_space }
    all_available_space_of_managed_parking_lots + all_available_space_of_managed_parking_boys
  end

  def all_parking_boys
    @parking_boys + @smart_parking_boys + @super_parking_boys
  end
end
