require 'parking_lot'
require 'car'
require 'super_parking_boy'

describe SuperParkingBoy do
  context 'given the super parking boy manages a parking lot' do
    before :each do
      @parking_lot = ParkingLot.new(1)
      @super_parking_boy = SuperParkingBoy.new(@parking_lot)
      @car = Car.new
    end

    it 'should be able to pick the car parked in parking lot' do
      token = @parking_lot.park(@car)

      picked_car = @super_parking_boy.pick(token)
      expect(picked_car).to eq @car
    end

    it 'should be able to park the car' do
      token = @super_parking_boy.park(@car)

      picked_car = @parking_lot.pick(token)
      expect(picked_car).to eq @car
    end

    it 'should not be able to park the car when parking lot is full' do
      @parking_lot.park(@car)

      token = @super_parking_boy.park(Car.new)
      expect(token).to be_falsy
    end
  end

  context 'given the super parking boy mangage two parking lots' do
    it 'should be able to park the car to the parking lot with more space rate' do
      parking_lot1 = ParkingLot.new(2)
      parking_lot2 = ParkingLot.new(1)
      super_parking_boy = SuperParkingBoy.new(parking_lot1, parking_lot2)

      parking_lot1.park(Car.new)

      car = Car.new
      token = super_parking_boy.park(car)
      picked_car = parking_lot2.pick(token)
      expect(picked_car).to eq car
    end
  end
end
