module Vendr
  class Machine
    def initialize(*args)
      coins = args[0].delete(:coins)
      products = args[0].delete(:products)

      raise ArgumentError.new("Must be initialized with an initial stocking of coins and products") if coins.nil? || products.nil?

      @inventory = Inventory.new(coins, products)
    end

    def reload(*args)
      coins = args[0].delete(:coins) || {}
      products = args[0].delete(:products) || {}

      @inventory.reload(coins, products)
    end

    def select_product(product)
      raise ArgumentError.new("Product is unavailable") unless @inventory.is_product_available?(product)

      @selected_product = product
    end

    def insert_coin(coin)
      raise ArgumentError.new("Coin is not accepted") unless Coin.valid?(coin)

      @inserted_coins ||= []
      @inserted_coins << coin
    end

    def vend
      change = Calculator.new(@inserted_coins, @inventory.coins, @selected_product).change

      @inserted_coins.each do |coin|
        @inventory.increment_coin(coin)
      end
      @inserted_coins = nil

      @inventory.decrement_product(@selected_product)
      change.each do |coin|
        @inventory.decrement_coin(coin)
      end

      selected_product = @selected_product
      @selected_product = nil

      { product: selected_product, change: change }
    end

    def reset
      return_coins = @inserted_coins.dup

      @selected_product = nil
      @inserted_coins = nil

      { product: @selected_product, change: return_coins }
    end

    # Returns the current contents of the machine, as this is a library we
    # return the available coins too but in a real-life situation we'd
    # probably just want to return the product stocking to publicly
    def inventory
      raise MachineNotLoadedError if @inventory.nil?
      @inventory.current
    end
  end
end
