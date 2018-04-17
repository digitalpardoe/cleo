# Cleo

I opted to implement the vending machine as a reusable Ruby gem and, for the
purposes of completing the exercise, I used RSpec tests to test both the basic
functionality and prove how the flow would operate in an application.

The main test file ([vendr_spec.rb](spec/vendr_spec.rb)) contains the tests
that simulate the vending machine's usage.

## Running

The gem has only been tested on Ruby 2.5.1 but may run on other versions. To run the tests and simulate the flow please:

```
bundle install
```

And then

```
rake spec
```

## Notes

To keep things simple for the exercise available coins and products are defined
within the [Coin](lib/vendr/models/coin.rb) and
[Product](lib/vendr/models/product.rb) classes. In reality, as this is a gem,
we'd probably provide a way to load these from a configuration file (probably
YAML) or a database.
