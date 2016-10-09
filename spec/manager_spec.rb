require 'parking_lot'
require 'car'
require 'parking_boy'
require 'smart_parking_boy'
require 'super_parking_boy'
require 'manager'

describe Manager do
  describe 'Park/Pick' do
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

      xcontext 'by himself' do
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

  describe 'Report' do
    context 'given manager manage two parking lot' do
      parking_lot1 = ParkingLot.new(5)
      parking_lot2 = ParkingLot.new(4)
      parking_lot1.park(Car.new)
      parking_lot1.park(Car.new)
      parking_lot1.park(Car.new)
      parking_lot2.park(Car.new)
      manager = Manager.new(parking_lots: [parking_lot1, parking_lot2])

      it 'should get the availabe space of managed parking lot' do
        expect(manager.all_available_space).to eq 5
      end

      it 'should get the all space of managed parking lot' do
        expect(manager.all_space).to eq 9
      end

      it 'should be report as follow' do
        expect(manager.report).to eq "M 5 9\n\tP 2 5\n\tP 3 4\n"
        expect(manager.report_markdown).to eq "#M 5 9\n##P 2 5\n##P 3 4\n"
      end
    end

    context 'given manager manage two parking lot and two parking boys manage different parking lot' do
      parking_lot1_by_manager = ParkingLot.new(5)
      parking_lot2_by_manager = ParkingLot.new(4)
      parking_lot1_by_manager.park(Car.new)
      parking_lot1_by_manager.park(Car.new)
      parking_lot1_by_manager.park(Car.new)
      parking_lot2_by_manager.park(Car.new)

      parking_lot_by_parking_boy1 = ParkingLot.new(10)
      parking_lot_by_parking_boy2 = ParkingLot.new(12)
      parking_lot_by_parking_boy1.park(Car.new)
      parking_lot_by_parking_boy1.park(Car.new)
      parking_lot_by_parking_boy1.park(Car.new)
      parking_lot_by_parking_boy2.park(Car.new)
      parking_lot_by_parking_boy2.park(Car.new)

      parking_boy1 = ParkingBoy.new(parking_lot_by_parking_boy1)
      parking_boy2 = ParkingBoy.new(parking_lot_by_parking_boy2)

      resource = {
        parking_lots: [parking_lot1_by_manager, parking_lot2_by_manager],
        parking_boys: [parking_boy1, parking_boy2]
      }
      manager = Manager.new(resource)

      it 'should get the availabe space of managed parking lot' do
        expect(manager.all_available_space).to eq 22
      end

      it 'should get the all space of managed parking lot' do
        expect(manager.all_space).to eq 31
      end

      it 'should be report as follow' do
        expect(manager.report).to eq "M 22 31\n\tP 2 5\n\tP 3 4\n\tB 7 10\n\t\tP 7 10\n\tB 10 12\n\t\tP 10 12\n"
        expect(manager.report_markdown).to eq "#M 22 31\n##P 2 5\n##P 3 4\n##B 7 10\n###P 7 10\n##B 10 12\n###P 10 12\n"
      end
    end

    context 'given manager manage two parking lot and a parking boy, smart parking boy, super parkin boy manage different parking lot' do
      parking_lot1_by_manager = ParkingLot.new(5)
      parking_lot2_by_manager = ParkingLot.new(4)
      parking_lot1_by_manager.park(Car.new)
      parking_lot1_by_manager.park(Car.new)
      parking_lot1_by_manager.park(Car.new)
      parking_lot2_by_manager.park(Car.new)

      parking_lot_by_parking_boy = ParkingLot.new(10)
      parking_lot_by_smart_parking_boy = ParkingLot.new(12)
      parking_lot_by_super_parking_boy = ParkingLot.new(8)
      parking_lot_by_parking_boy.park(Car.new)
      parking_lot_by_parking_boy.park(Car.new)
      parking_lot_by_smart_parking_boy.park(Car.new)
      parking_lot_by_smart_parking_boy.park(Car.new)
      parking_lot_by_smart_parking_boy.park(Car.new)
      parking_lot_by_super_parking_boy.park(Car.new)

      parking_boy = ParkingBoy.new(parking_lot_by_parking_boy)
      smart_parking_boy = SmartParkingBoy.new(parking_lot_by_smart_parking_boy)
      super_parking_boy = SuperParkingBoy.new(parking_lot_by_super_parking_boy)

      resource = {
        parking_lots: [parking_lot1_by_manager, parking_lot2_by_manager],
        parking_boys: [parking_boy],
        smart_parking_boys: [smart_parking_boy],
        super_parking_boys: [super_parking_boy]
      }
      manager = Manager.new(resource)

      it 'should get the availabe space of managed parking lot' do
        expect(manager.all_available_space).to eq 29
      end

      it 'should get the all space of managed parking lot' do
        expect(manager.all_space).to eq 39
      end

      it 'should be report as follow' do
        expect(manager.report).to eq "M 29 39\n\tP 2 5\n\tP 3 4\n\tB 8 10\n\t\tP 8 10\n\tB 9 12\n\t\tP 9 12\n\tB 7 8\n\t\tP 7 8\n"
        expect(manager.report_markdown).to eq "#M 29 39\n##P 2 5\n##P 3 4\n##B 8 10\n###P 8 10\n##B 9 12\n###P 9 12\n##B 7 8\n###P 7 8\n"
      end
    end
  end
end
