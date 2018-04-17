module Vendr
  # As product and coin are so similar this could probably be a subclass of
  # something generic which would be helpful when loading data from a source
  class Coin
    attr_reader :name, :value

    def initialize(name, value)
      @name = name
      @value = value
    end

    # The data is being stored in this way simply to limit the problem space,
    # should probaby be loaded from config or a database
    @@coins = {
      two_pence: Coin.new("2p", 2),
      five_pence: Coin.new("5p", 5),
      ten_pence: Coin.new("10p", 10),
      twenty_pence: Coin.new("20p", 20),
      fifty_pence: Coin.new("50p", 50),
      one_pound: Coin.new("£1", 100),
      two_pounds: Coin.new("£2", 200)
    }

    class << self
      def find(coin)
        @@coins[coin]
      end

      def valid?(coin)
        @@coins.has_key?(coin)
      end
    end
  end
end
