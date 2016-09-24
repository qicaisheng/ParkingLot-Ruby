require 'parking_lot'
require 'car'

describe ParkingLot do
  context 'when a car park to the parking lot' do
    it 'should be able to pick the car' do
      parking_lot = ParkingLot.new(1)
      car = Car.new

      parking_lot.park(car)

      picked_car = parking_lot.pick
      expect(picked_car).to eq car
    end
  end

  context 'when parking lot is full' do
    before :each do
      @parking_lot = ParkingLot.new(1)
      @car1 = Car.new
      @car2 = Car.new
      @parking_lot.park(@car1)
    end

    it 'should be not able to park the car' do
      expect(@parking_lot.park(@car2)).to be_falsy
    end

    it 'should be able to park the car after picking another car' do
      @parking_lot.pick

      @parking_lot.park(@car2)
      picked_car = @parking_lot.pick
      expect(picked_car).to eq @car2
    end
  end
end
