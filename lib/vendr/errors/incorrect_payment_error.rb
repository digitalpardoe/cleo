module Vendr
  class IncorrectPaymentError < StandardError
    def initialize(msg="Correct payment has not been provided")
      super
    end
  end
end
