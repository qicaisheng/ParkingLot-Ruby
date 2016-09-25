require 'parking_lot'
require 'car'
require 'parking_boy'
require 'smart_parking_boy'
require 'super_parking_boy'
require 'manager'

describe Manager do
  context 'given manager manage a parking lot and parking_boy, smart parking boy, super parking boy who all manage other parking lots' do
    before :each do
      @parking_lot1 = ParkingLot.new(1)
      @parking_lot2 = ParkingLot.new(2)
      @parking_lot3 = ParkingLot.new(4)
      @parking_lot4 = ParkingLot.new(2)

      @parking_lot2.park(Car.new)
      @parking_lot3.park(Car.new)

      @parking_boy = ParkingBoy.new(@parking_lot2, @parking_lot3, @parking_lot4)
      @smart_parking_boy = SmartParkingBoy.new(@parking_lot2, @parking_lot3, @parking_lot4)
      @super_parking_boy = SuperParkingBoy.new(@parking_lot2, @parking_lot3, @parking_lot4)
      resource = {
        parking_lots: [@parking_lot1],
        parking_boys: [@parking_boy],
        smart_parking_boys: [@smart_parking_boy],
        super_parking_boys: [@super_parking_boy]
      }
      @manager = Manager.new(resource)
      @car = Car.new
    end

    context 'by himself' do
      it 'should be able to park the car to the parking lot' do
        token = @manager.park(@car)

        picked_car = @parking_lot1.pick(token)
        expect(picked_car).to eq @car
      end

      it 'should be able to pick the car parked in the parking lot' do
        token = @parking_lot1.park(@car)

        picked_car = @manager.pick(token)
        expect(picked_car).to eq @car
      end
    end

    context 'by other parking boy' do
      it 'should be able to park the car with the help of parking boy' do
        token = @manager.park_by(@parking_boy, @car)

        picked_car = @parking_lot2.pick(token)
        expect(picked_car).to eq @car
      end

      it 'should be able to pick the car with the help of parking boy' do
        token = @manager.park_by(@parking_boy, @car)

        picked_car = @manager.pick_by(@parking_boy, token)
        expect(picked_car).to eq @car
      end

      it 'should be able to park the car with the help of smart parking boy' do
        token = @manager.park_by(@smart_parking_boy, @car)

        picked_car = @parking_lot3.pick(token)
        expect(picked_car).to eq @car
      end

      it 'should be able to pick the car with the help of smart parking boy' do
        token = @manager.park_by(@smart_parking_boy, @car)

        picked_car = @manager.pick_by(@smart_parking_boy, token)
        expect(picked_car).to eq @car
      end

      it 'should be able to park the car with the help of super parking boy' do
        token = @manager.park_by(@super_parking_boy, @car)

        picked_car = @parking_lot4.pick(token)
        expect(picked_car).to eq @car
      end

      it 'should be able to pick the car with the help of super parking boy' do
        token = @manager.park_by(@super_parking_boy, @car)

        picked_car = @manager.pick_by(@super_parking_boy, token)
        expect(picked_car).to eq @car
      end
    end

    context 'by type' do
      it 'should be able to park the car by managed parking boy' do
        token = @manager.park_by_parking_boy(@car)

        picked_car = @parking_lot2.pick(token)
        expect(picked_car).to eq @car
      end

      it 'should be able to pick the car by managed parking boy' do
        token = @manager.park_by_parking_boy(@car)

        picked_car = @manager.pick_by_parking_boy(token)
        expect(picked_car).to eq @car
      end

      it 'should be able to park the car by managed smart parking boy' do
        token = @manager.park_by_smart_parking_boy(@car)

        picked_car = @parking_lot3.pick(token)
        expect(picked_car).to eq @car
      end

      it 'should be able to pick the car by managed smart parking boy' do
        token = @manager.park_by_smart_parking_boy(@car)

        picked_car = @manager.pick_by_smart_parking_boy(token)
        expect(picked_car).to eq @car
      end

      it 'should be able to park the car by managed super parking boy' do
        token = @manager.park_by_super_parking_boy(@car)

        picked_car = @parking_lot4.pick(token)
        expect(picked_car).to eq @car
      end

      it 'should be able to pick the car by managed super parking boy' do
        token = @manager.park_by_super_parking_boy(@car)

        picked_car = @manager.pick_by_super_parking_boy(token)
        expect(picked_car).to eq @car
      end

    end
  end
end
