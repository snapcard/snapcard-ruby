SNAPCARD
========

Ruby client library for the [Snapcard API](http://wallets.docs.snapcard.io/).

Install
-------

```
gem install snapcard
```

Usage
-----

```ruby
require 'snapcard'

snapcard = Snapcard::Client.new api_key: "A0gQfloO731hkLG", secret_key: "A7zjaklHkODeFiO"

response = snapcard.get path: "rates"
puts response.body

response = snapcard.get path: "transactions", limit: 1, offset: 1
puts response.body

response = snapcard.post path: "transfers", sourceAmount: "0.01", sourceCurrency: "BTC", dest: "email:test@snapcard.io"
puts response.body
```

At the moment this client is synchronous only.

Optional arguments on client initialization:
```ruby
:read_timeout # default = 20
```

Errors
------

Any status codes other than 2xx will result in an error.

Example error response:
```json
{
  "language":"en",
  "subType":"INVALID_VALUE",
  "problematicField":"dest",
  "problematicValue":"asdf",
  "exceptionId":"CvjMPW",
  "compositeType":"ValidationException.INVALID_VALUE",
  "message":"asdf is not a valid value for dest",
  "type":"ValidationException",
  "transient":false
}
```
