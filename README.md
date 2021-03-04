# Jumbo::Client

Connect to the Jumbo LMS and consume the services provided.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jumbo-client', github: 'renuo/jumbo-client'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install jumbo-client

## Usage

In order to consume Manor Cobra API you should have access and configure the following environment variables:
* `JUMBO_CLIENT_API_KEY`: the ApiKey to invoke the services

Contact the Jumbo LMS team to receive further instructions regarding the Api Key.

```ruby
Jumbo::Client.new.ping
# -> { timestamp: 12345}

request = Jumbo::CouponsRequest.new(coupon_assignment_event_type: event_type, loyalty_code: '1234567890')
Jumbo::Client.new.coupons_requests.create(request)
# -> { "coupons_request": { ... }}

Jumbo::Client.new.employees.index
# -> { "employees": [{ "id": 12, "first_name": "Alessandro", "last_name": "Rodi", "email": "alessandro.rodi@renuo.ch", "promo_code": "1234", "reference_code": "abcd1234", "shop_id": "4567" }] }
```
## Development

After checking out the repo, run `bin/setup` to install dependencies.
Then, set your environment variables using a `.env` file.
Then, run `bundle exec rspec` to run the tests. 
You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Copyright

Coypright 2021 [Renuo AG](https://www.renuo.ch/).
