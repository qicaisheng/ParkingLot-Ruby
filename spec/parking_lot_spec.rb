require 'parking_lot'
require 'car'

describe ParkingLot do
  context 'when a car park to the parking lot' do
    it 'should be able to pick the car' do
      parking_lot = ParkingLot.new
      car = Car.new

      parking_lot.park(car)

      picked_car = parking_lot.pick
      expect(picked_car).to eq car
    end
  end
end
