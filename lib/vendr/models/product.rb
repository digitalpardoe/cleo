module Vendr
  # As product and coin are so similar this could probably be a subclass of
  # something generic which would be helpful when loading data from a source
  class Product
    attr_reader :name, :price

    # The name field didn't end up getting used in this particular
    # implementation but it could be useful in an implementation with a more
    # fleshed out data model
    def initialize(name, price)
      @name = name
      @price = price
    end

    # The data is being stored in this way simply to limit the problem space,
    # should probaby be loaded from config or a database
    @@prodcuts = {
      crisps: Product.new("Crisps", 75),
      chocolate: Product.new("Chocolate", 100),
      sweets: Product.new("Sweets", 50),
      pop: Product.new("Pop", 150),
      diet_pop: Product.new("Diet Pop", 50),
      water: Product.new("Water", 125)
    }

    class << self
      def find(product)
        @@prodcuts[product]
      end

      def valid?(coin)
        @@prodcuts.has_key?(coin)
      end
    end
  end
end
