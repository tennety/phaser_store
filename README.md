## The Problem: Store with 2Checkout

Consider the following customer story:

 - I would like to be able to add products to a product catalog on my site, and have the products automatically show up on a shopping page.
 - On the shopping page, I would like for my customers to be able to select the quantity of items to purchase.
 - Then, they can hit a checkout button.
 - I use 2checkout.com as my payment processor. You can see the documentation for 2checkout.com [here](http://developers.2checkout.com).

Write a software solution that addresses the customer's needs.

### Presenting the Phaser Store!
Here you can create and sell phasers to all parties in the United
Federation of Planets for their Private Little Wars and Cowboy
Diplomacy.

<img src='http://imageshack.us/photo/my-images/94/phaser.jpg/' alt='Set
to stun!' />

## The Approach

I chose to go with a lightweight solution. I did start down the Rails
path, but quickly realized that the hassle of set up and maintenance was
not worth it given the short amount of time the requirements said this
should take.

#### Some Considerations

- There are only a few named routes required:
  - The store (product index)         -- /phasers
  - Create a new product              -- /phaser
  - Create a receipt                  -- /receipt
  - Update the receipt with sale data -- /receipt/:id

- Lightweight Testing
  - Ruby 1.9 comes with Minitest::Spec which has a readable, RSpec-like
    syntax
  - Sinatra routes can be effectively tested with Rack::Test, which
    plays well with Minitest
  - Capybara could be used with MiniTest for integration testing

- Persistence
  - The [Sinatra-ActiveRecord gem](https://github.com/bmizerany/sinatra-activerecord)
    - Written by Sinatra's author bmizerany
    - Integrates well with Sinatra
    - Rails-like migrations
    - ActiveRecord without Rails
  - SQLite3 for simplicity, can be upgraded to more heavyweight DBs
  - Transactions to maintain stock quantities in sync between orders

- Loose Coupling
  - The receipt does not contain foreign keys to the product to keep
    the product lines nimble. If I chose to stop carrying a product, I
could delete it from the DB without corrupting the orders.
  - The app creates on-the-fly product lines with 2CO. That way I'm not
    maintaining my products in multiple places.

#### Disadvantages

- Code organization
  - Sinatra's flexibility with where to put things is useful for small
    projects, but gets unwieldy if not properly organized. I have
separated the code into logical folders, but the tests don't necessarily
reflect that organization.
