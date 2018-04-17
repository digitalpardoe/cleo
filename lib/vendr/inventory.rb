module Vendr
  class Inventory
    attr_reader :coins, :products

    def initialize(coins, products)
      @coins, @products = {}, {}

      reload(coins, products, true)
    end

    # Not a fan of the magic side effects on this method signature, would
    # probably change to an args hash with some refactoring
    def reload(coins, products, initial=false)
      coins.each do |c,q|
        raise ArgumentError.new("The coin you are attemping to load is not accepted") unless Coin.valid?(c)

        initial ? @coins[c] = q : increment_coin(c, q)
      end

      products.each do |p,q|
        raise ArgumentError.new("The product you are attempting to load does not exist") unless Product.valid?(p)

        initial ? @products[p] = q : increment_product(p, q)
      end

      current
    end

    def current
      { coins: @coins, products: @products }
    end

    def is_product_available?(product)
      Product.valid?(product) && !@products[product].nil? && @products[product] >= 1
    end

    def increment_coin(coin, quantity=1)
      increment(@coins, coin, quantity)
    end

    def decrement_coin(coin, quantity=1)
      decrement(@coins, coin, quantity)
    end

    def increment_product(product, quantity=1)
      increment(@products, product, quantity)
    end

    def decrement_product(product, quantity=1)
      decrement(@products, product, quantity)
    end

    private

    def increment(collection, item, quantity)
      collection[item] ||= 0
      collection[item] += quantity
    end

    def decrement(collection, item, quantity)
      collection[item] ||= 0

      if (collection[item] - quantity) < 0
        raise RangeError.new("Cannot have a negative number of items")
      end

      collection[item] -= quantity
    end
  end
end
