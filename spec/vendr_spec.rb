module Vendr
  RSpec.describe Vendr do
    before(:each) do
      @machine = Machine.new(
        coins: {
          two_pence: 125,
          five_pence: 100,
          ten_pence: 75,
          twenty_pence: 50,
          fifty_pence: 25,
          one_pound: 10,
          two_pounds: 5
        },
        products: {
          crisps: 1,
          chocolate: 1,
          sweets: 1,
          pop: 1,
          diet_pop: 1,
          water: 1
        }
      )
    end

    it "performs as expected for a standard run through" do
      @machine.select_product(:water)
      @machine.insert_coin(:two_pounds)

      expect(@machine.vend).to eq({ product: :water, change: [:fifty_pence, :twenty_pence, :five_pence] })
    end

    it "performs as expected with a reset" do
      @machine.select_product(:water)
      @machine.insert_coin(:two_pounds)

      expect(@machine.reset).to eq({ product: nil, change: [:two_pounds] })

      @machine.select_product(:crisps)
      @machine.insert_coin(:one_pound)

      expect(@machine.vend).to eq({ product: :crisps, change: [:twenty_pence, :five_pence] })
    end

    it "performs as expected once reloaded" do
      @machine.select_product(:water)
      @machine.insert_coin(:two_pounds)

      expect(@machine.vend).to eq({ product: :water, change: [:fifty_pence, :twenty_pence, :five_pence] })

      expect { @machine.select_product(:water) }.to raise_error(ArgumentError)

      @machine.reload(products: { water: 1 })

      expect { @machine.select_product(:water) }.to_not raise_error

      @machine.insert_coin(:one_pound)
      @machine.insert_coin(:one_pound)
      @machine.insert_coin(:fifty_pence)

      expect(@machine.vend).to eq({ product: :water, change: [:one_pound, :twenty_pence, :five_pence] })
    end

    it "performs as expected for multiple items" do
      @machine.select_product(:water)
      @machine.insert_coin(:two_pounds)

      expect(@machine.vend).to eq({ product: :water, change: [:fifty_pence, :twenty_pence, :five_pence] })

      @machine.select_product(:crisps)
      @machine.insert_coin(:fifty_pence)
      @machine.insert_coin(:fifty_pence)

      expect(@machine.vend).to eq({ product: :crisps, change: [:twenty_pence, :five_pence] })
    end
  end
end
