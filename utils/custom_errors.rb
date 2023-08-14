# frozen_string_literal: true

require_relative '../app_constants'
module CustomErrors
  include ParkingLotConstants

  class RecordNotFound < RuntimeError
    def initialize(message = ERR_RECORD_NOT_FOUND)
      super(message)
    end
  end

  class InvalidInput < RuntimeError
    def initialize(message = ERR_INVALID_INPUT)
      super(message)
    end
  end

  class AlreadyExist < RuntimeError
    def initialize(message = "Already Exist")
      super(message)
    end
  end

  class ConnectionIssue < RuntimeError
    def initialize(message = "Connection Issue")
      super(message)
    end
  end

  class CarNotFound < RecordNotFound
    def initialize(message = ERR_CAR_NOT_FOUND)
      super(message)
    end
  end

  class NoEmptySlot < RecordNotFound
    def initialize(message = ERR_NO_EMPTY_SLOTS)
      super(message)
    end

  end

  class NoParkedCar < RecordNotFound
    def initialize(message = ERR_CAR_NOT_FOUND)
      super(message)
    end
  end

  class InvalidRegNo < InvalidInput
    def initialize(message = ERR_INVALID_REGISTRATION_NO)
      super(message)
    end
  end

  class CarAlreadyParked < AlreadyExist
    def initialize(message = ERR_CAR_ALREADY_PARKED)
      super(message)
    end
  end

end