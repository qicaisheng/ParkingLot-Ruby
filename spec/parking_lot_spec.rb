require 'parking_lot'
require 'car'

describe ParkingLot do
  context 'when a car park to the parking lot' do
    it 'should be able to pick the car' do
      parking_lot = ParkingLot.new(3)
      car1 = Car.new
      car2 = Car.new
      car3 = Car.new

      parking_lot.park(car1)
      token = parking_lot.park(car2)
      parking_lot.park(car3)

      picked_car = parking_lot.pick(token)
      expect(picked_car).to eq car2
    end
  end

  context 'when parking lot is full' do
    before :each do
      @parking_lot = ParkingLot.new(1)
      @car1 = Car.new
      @car2 = Car.new
      @token1 = @parking_lot.park(@car1)
    end

    it 'should be not able to park the car' do
      expect(@parking_lot.park(@car2)).to be_falsy
    end

    it 'should be able to park the car after picking another car' do
      @parking_lot.pick(@token1)

      token2 = @parking_lot.park(@car2)
      picked_car = @parking_lot.pick(token2)
      expect(picked_car).to eq @car2
    end
  end
end
