module Vendr
  RSpec.describe Calculator do
    it "throws an error if we're missing arguments" do
      expect { Calculator.new([ :fifty_pence ], { five_pence: 2 }, nil) }.to raise_error(ArgumentError)
    end

    it "returns an empty array if correct coins are provided" do
      calculator = Calculator.new(
        [ :fifty_pence, :twenty_pence, :five_pence ],
        { five_pence: 2 },
        :crisps
      )

      expect(calculator.change).to eq([])
    end

    it "throws and error if the correct change is not available" do
      calculator = Calculator.new(
        [ :fifty_pence, :fifty_pence, :five_pence, :ten_pence ],
        { fifty_pence: 2 },
        :crisps
      )

      expect { calculator.change }.to raise_error(InsufficientChangeError)
    end

    it "returns the correct change" do
      calculator = Calculator.new(
        [ :one_pound ],
        { fifty_pence: 2, ten_pence: 2, five_pence: 2 },
        :crisps
      )

      expect(calculator.change).to eq([:ten_pence, :ten_pence, :five_pence])
    end

    it "returns users own coins as change if required" do
      calculator = Calculator.new(
        [ :fifty_pence, :twenty_pence, :five_pence, :ten_pence, :ten_pence ],
        { fifty_pence: 2, ten_pence: 2 },
        :crisps
      )

      expect(calculator.change).to eq([:twenty_pence])
    end

    it "throws an error if correct payment is not provided" do
      calculator = Calculator.new(
        [ :fifty_pence ],
        { fifty_pence: 2, ten_pence: 2 },
        :crisps
      )

      expect { calculator.change }.to raise_error(IncorrectPaymentError)
    end
  end
end
