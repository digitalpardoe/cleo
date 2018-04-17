module Vendr
  class InsufficientChangeError < StandardError
    def initialize(msg="Insufficient change present in vending machine")
      super
    end
  end
end
