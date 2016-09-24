require 'parking_lot'
require 'car'
require 'smart_parking_boy'

describe SmartParkingBoy do
  context 'given the smart parking boy manages a parking lot' do
    before :each do
      @parking_lot = ParkingLot.new(1)
      @smart_parking_boy = SmartParkingBoy.new(@parking_lot)
      @car = Car.new
    end

    it 'should be able to pick the car parked in parking lot' do
      token = @parking_lot.park(@car)

      picked_car = @smart_parking_boy.pick(token)
      expect(picked_car).to eq @car
    end

    it 'should be able to park the car' do
      token = @smart_parking_boy.park(@car)

      picked_car = @parking_lot.pick(token)
      expect(picked_car).to eq @car
    end

    it 'should not be able to park the car when parking lot is full' do
      @parking_lot.park(@car)

      token = @smart_parking_boy.park(Car.new)
      expect(token).to be_falsy
    end
  end

  context 'given the smart parking boy mangage two parking lots' do
    before :each do
      @parking_lot1 = ParkingLot.new(1)
      @parking_lot2 = ParkingLot.new(2)
      @smart_parking_boy = SmartParkingBoy.new(@parking_lot1, @parking_lot2)
      car = Car.new
    end

    it 'should be able to park the car to the parking lot with more space' do
      token = @smart_parking_boy.park(@car)
      picked_car = @parking_lot2.pick(token)
      expect(picked_car).to eq @car
    end

    it 'should not be able to park the car when parking lots are full' do
      @parking_lot1.park(@car)
      @parking_lot2.park(Car.new)
      @parking_lot2.park(Car.new)

      token = @smart_parking_boy.park(Car.new)
      expect(token).to be_falsy
    end
  end
end
