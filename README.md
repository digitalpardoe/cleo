# Cleo

I opted to implement the vending machine as a reusable Ruby gem and, for the
purposes of completing the exercise, I used RSpec tests to test both the basic
functionality and prove how the flow would operate in an application.

The main test file ([vendr_spec.rb](spec/vendr_spec.rb)) contains the tests
that simulate the vending machine's usage.

## Running

The gem has only been tested on Ruby 2.5.1 but may run on other versions. To run the tests and simulate the flow please navigate to the source directory and run:

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

It currently feels a little flow-control-by-exception to me so that's something I'd probably work on if I put more time into it.

Rather than the vending machine output being a hash it could probably be represented as some sort of 'output' object.

In addition to the specification it seemed to be appropriate to add the following functionality:

* The users inserted change is added to the inventory and can also be used as change during their purchase.
* A reset function has been added to return the inserted change and no item (in terms of an application this is unnecessary but it better emulates a vending machine).

## Specification

Below is the provided specification and the spec that validates the
functionality:

* Once an item is selected and the appropriate amount of money is inserted, the vending machine should return the correct product.
  * `selects the chosen product`
  * `accepts a coin that is inserted`
  * `can vend a product with no change and update the inventory`
  * `performs as expected for a standard run through`
* It should also return change if too much money is provided, or ask for more money if insufficient funds have been inserted.
  * `can vend a product with change and update the inventory`
  * `throws and error if sufficient change is not inserted` (would be translated to a UI message in application code)
  * `performs as expected for a standard run through`
* The machine should take an initial load of products and change. The change will be of denominations 1p, 2p, 5p, 10p, 20p, 50p, £1, £2.
  * `should load items into the machine`
  * This is also covered in the setup of most specs
* There should be a way of reloading either products or change at a later point.
  * `reloads the machine and updates the inventory as expected`
  * `performs as expected once reloaded`
* The machine should keep track of the products and change that it contains.
  * `can vend a product with no change and update the inventory`
  * `can vend a product with change and update the inventory`
  * `performs as expected for multiple items`
