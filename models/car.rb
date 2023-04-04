require_relative "utils/orm.rb"
require_relative "constants.rb"

class Car
  def initialize(registration_no)
    @registration_no = registration_no
    @slot_id = Nil
    @entry_time = Time.now
    car_data = Car.find_by_registration_no(registration_no)
    if (car_data)
      @slot_id = car[:slot_id]
      @entry_time = car[:entry_time]
    end
  end

  def self.find_by_registration_no(registration_no)
    cars = CustomOrm.read_db_file(db_name: DB_CARS)
    cars[registration_no]
  end
end
