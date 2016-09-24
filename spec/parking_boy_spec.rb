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

    it 'should not be able to park the car when parking lot is full' do
      @parking_lot.park(@car)

      token = @parking_boy.park(Car.new)
      expect(token).to be_falsy
    end
  end

  context 'given the parking boy manage two parking lot' do
    before :each do
      @parking_lot1 = ParkingLot.new(1)
      @parking_lot2 = ParkingLot.new(1)
      @parking_boy = ParkingBoy.new(@parking_lot1, @parking_lot2)
      @car1 = Car.new
      @car2 = Car.new
    end

    it 'should be park the car to another parking lot when a parking lot is full' do
      @parking_lot1.park(@car1)

      token = @parking_boy.park(@car2)
      picked_car = @parking_lot2.pick(token)
      expect(picked_car).to eq @car2
    end

    it 'should not be able to park the car when parking lots are full' do
      @parking_lot1.park(@car1)
      @parking_lot2.park(@car2)

      token = @parking_boy.park(Car.new)
      expect(token).to be_falsy
    end
  end
end
