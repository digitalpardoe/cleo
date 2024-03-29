module Vendr
  class Calculator
    def initialize(inserted_coins, available_coins, product)
      if inserted_coins.nil? || available_coins.nil? || product.nil?
        raise ArgumentError.new("Must provide inserted coins, available coins and selected product")
      end

      @total_inserted = inserted_coins.collect { |coin| Coin.find(coin).value }.sum

      # Expand the available coins from their quantity to actual representation
      @available_coins = [].tap do |array|
        available_coins.each do |coin,quantity|
          quantity.times { array << coin }
        end
      end

      # Add the inserted coins to the available coins for providing change and
      # sort for the purposes of the basic algorithm
      @available_coins += inserted_coins
      @available_coins.sort! { |a,b| Coin.find(b).value <=> Coin.find(a).value  }

      @product_price = Product.find(product).price
    end

    # Basic change algorithm that takes into account the cases of
    # insufficient payment and correct change being unavailable
    def change
      if @total_inserted < @product_price
        raise IncorrectPaymentError.new("Sufficient payment has not been provided")
      elsif @total_inserted == @product_price
        []
      else
        collected_change = []
        change_to_provide = @total_inserted - @product_price

        # Works down through the sorted array of available coins until the
        # change requirement is satisfied
        @available_coins.each do |coin|
          value = Coin.find(coin).value
          if value <= change_to_provide
            collected_change << coin
            change_to_provide -= value
          end
        end

        if change_to_provide != 0
          raise InsufficientChangeError.new("Correct change is not available")
        else
          collected_change
        end
      end
    end
  end
end
