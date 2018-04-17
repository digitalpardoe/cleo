module Vendr
  RSpec.describe Inventory do
    before(:each) do
      @inventory = Inventory.new({ two_pence: 50 }, { crisps: 50 })
    end


    it "should have a correctly initialzed inventory" do
      expect(@inventory.current).to eq({ coins: { two_pence: 50 }, products: { crisps: 50 } })
    end

    it "should be able to reload the inventory" do
      @inventory.reload({ fifty_pence: 10, two_pence: 50 }, { crisps: 50 })

      expect(@inventory.current).to eq(
        {
          coins: { two_pence: 100, fifty_pence: 10 },
          products: { crisps: 100 }
        }
      )
    end

    it "returns true if a product is available" do
      expect(@inventory.is_product_available?(:crisps)).to be(true)
    end

    it "returns false if a known product is unavailable" do
      expect(@inventory.is_product_available?(:sweets)).to be(false)
    end

    it "returns false if an unknown product is requested" do
      expect(@inventory.is_product_available?(:ice_cream)).to be(false)
    end

    it "increments the coins by one" do
      @inventory.increment_coin(:two_pence)

      expect(@inventory.current[:coins][:two_pence]).to eq(51)
    end

    it "increments the coins by an arbitrary amount" do
      @inventory.increment_coin(:two_pence, 5)

      expect(@inventory.current[:coins][:two_pence]).to eq(55)
    end

    it "decrements the coins by one" do
      @inventory.decrement_coin(:two_pence)

      expect(@inventory.current[:coins][:two_pence]).to eq(49)
    end

    it "decrements the coins by an arbitrary amount" do
      @inventory.decrement_coin(:two_pence, 5)

      expect(@inventory.current[:coins][:two_pence]).to eq(45)
    end

    it "increments the products by one" do
      @inventory.increment_product(:crisps)

      expect(@inventory.current[:products][:crisps]).to eq(51)
    end

    it "increments the products by an arbitrary amount" do
      @inventory.increment_product(:crisps, 5)

      expect(@inventory.current[:products][:crisps]).to eq(55)
    end

    it "decrements the products by one" do
      @inventory.decrement_product(:crisps)

      expect(@inventory.current[:products][:crisps]).to eq(49)
    end

    it "decrements the products by an arbitrary amount" do
      @inventory.decrement_product(:crisps, 5)

      expect(@inventory.current[:products][:crisps]).to eq(45)
    end
  end
end
