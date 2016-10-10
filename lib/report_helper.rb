module ReportHelper
  class << self
    def report_parking_lot(parking_lot, placeholder)
      "#{placeholder}P #{parking_lot.available_capacity} #{parking_lot.capacity}\n"
    end

    def report_parking_boy(parking_boy, placeholder)
      "#{placeholder}B #{parking_boy.all_available_space} #{parking_boy.all_space}\n"
    end

    def report_manager(manager, placeholder)
      "#{placeholder}M #{manager.all_available_space} #{manager.all_space}\n"
    end

    def report_parking_lots(parking_lots, placeholder)
      parking_lots.map{ |parking_lot| parking_lot.report(placeholder) }.join
    end

    def report_parking_boys(parking_boys, placeholder)
      parking_boys.map{ |parking_boy| parking_boy.report(placeholder) }.join
    end

    def report_parking_boy_and_lots(parking_boy, placeholder)
      report_parking_boy(parking_boy, placeholder) + \
        report_parking_lots(parking_boy.parking_lots, placeholder + "\t")
    end

    def report_manager_and_resources(manager)
      report_manager(manager, '') + \
        report_parking_lots(manager.parking_lots, "\t") + \
          report_parking_boys(manager.all_parking_boys, "\t")
    end

    def report_manager_and_resources_with_markdown(manager)
      report_manager(manager, '#') + \
        report_parking_lots(manager.parking_lots, '##') + \
          report_parking_boys_with_markdown(manager.all_parking_boys, '##')
    end

    def report_parking_boys_with_markdown(parking_boys, placeholder)
      parking_boys.map{ |parking_boy| parking_boy.report_markdown(placeholder) }.join
    end

    def report_parking_boy_and_lots_with_markdown(parking_boy, placeholder)
      report_parking_boy(parking_boy, placeholder) + \
        report_parking_lots(parking_boy.parking_lots, placeholder + "#")
    end
  end
end
