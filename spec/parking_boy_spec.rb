require 'parking_lot'
require 'car'
require 'parking_boy'

describe ParkingBoy do
  context 'given the parking boy manages a parking lot' do
    before :each do
      @parking_lot = ParkingLot.new(1)
      @parking_boy = ParkingBoy.new(@parking_lot)
      @car = Car.new
    end

    it 'should be able to pick the car parked in parking lot' do
      token = @parking_lot.park(@car)

      picked_car = @parking_boy.pick(token)
      expect(picked_car).to eq @car
    end

    it 'should be able to park the car' do
      token = @parking_boy.park(@car)

      picked_car = @parking_lot.pick(token)
      expect(picked_car).to eq @car
    end
  end
end
