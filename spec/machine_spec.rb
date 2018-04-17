module Vendr
  RSpec.describe Machine do
    before(:each) do
      @machine = Machine.new(coins: { fifty_pence: 50, five_pence: 50, two_pence: 50 }, products: { crisps: 50 })
    end

    it "should load items into the machine" do
      expect(@machine.inventory).to eq({ coins: { fifty_pence: 50, five_pence: 50, two_pence: 50 }, products: { crisps: 50 } })
    end

    it "selects the chosen product" do
      @machine.select_product(:crisps)

      expect(@machine.instance_variable_get(:@selected_product)).to eq(:crisps)
    end

    it "throws an error if the chosen product does not exist" do
      expect { @machine.select_product(:sweets) }.to raise_error(ArgumentError)
    end

    it "accepts a coin that is inserted" do
      @machine.insert_coin(:twenty_pence)

      expect(@machine.instance_variable_get(:@inserted_coins)).to eq([:twenty_pence])
    end

    it "throws an error for a coin it doesn't recognise" do
      expect { @machine.insert_coin(:quarter) }.to raise_error(ArgumentError)
    end

    it "can vend a product with no change and update the inventory" do
      @machine.select_product(:crisps)

      @machine.insert_coin(:fifty_pence)
      @machine.insert_coin(:twenty_pence)
      @machine.insert_coin(:five_pence)

      vend_output = @machine.vend
      inventory = @machine.inventory

      expect(vend_output).to eq({ product: :crisps, change: [] })
      expect(inventory).to eq({
        products: { crisps: 49 },
        coins: {
          fifty_pence: 51, five_pence: 51, two_pence: 50, twenty_pence: 1
        }
      })
    end

    it "can vend a product with change and update the inventory" do
      @machine.select_product(:crisps)

      @machine.insert_coin(:twenty_pence)
      @machine.insert_coin(:twenty_pence)
      @machine.insert_coin(:five_pence)
      @machine.insert_coin(:two_pence)
      @machine.insert_coin(:one_pound)

      vend_output = @machine.vend
      inventory = @machine.inventory

      expect(vend_output).to eq({ product: :crisps, change: [:fifty_pence, :twenty_pence, :two_pence] })
      expect(inventory).to eq({
        products: { crisps: 49 },
        coins: {
          fifty_pence: 49, five_pence: 51, two_pence: 50, twenty_pence: 1, one_pound: 1
        }
      })
    end

    it "resets the machine and refunds any inserted coins" do
      @machine.select_product(:crisps)

      @machine.insert_coin(:twenty_pence)
      @machine.insert_coin(:twenty_pence)
      @machine.insert_coin(:five_pence)
      @machine.insert_coin(:two_pence)
      @machine.insert_coin(:one_pound)

      expect(@machine.reset).to eq({ product: nil, change: [:twenty_pence, :twenty_pence, :five_pence, :two_pence, :one_pound] })
      expect(@machine.instance_variable_get(:@inserted_coins)).to eq(nil)
      expect(@machine.instance_variable_get(:@selected_product)).to eq(nil)
    end
  end
end
