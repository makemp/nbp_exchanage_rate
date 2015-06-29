# NbpExchangeRate
Includes methods which allow to connect with Polish National Bank exchange rate API.

## Installation

Add this line to your application's Gemfile:

```ruby
  gem 'nbp_exchange_rate', github: 'makemp/nbp_exchange_rate', branch: 'master'
```

And then execute:

    $ bundle

## Usage

### Object creation

```ruby
  NBP::ExchangeRate.new(table_name: 'h', table_number: '002', day: '02', month: '12', year: '15')
```

```ruby
  NBP::ExchangeRate.on_date(date_object, table_name: 'h', table_number: '001')
```
date_object must have day, month and year methods i.e DateTime.now

```ruby
  NBP::ExchangeRate.exchange_a
  NBP::ExchangeRate.exchange_b
  NBP::ExchangeRate.exchange_c
```

These three create an object which will fetch and parse from LastA, LastB, LastC xml files.
Alias methods:

```ruby
  NBP::ExchangeRate.last_a
  NBP::ExchangeRate.last_b
  NBP::ExchangeRate.last_c
```

### Fetch and parse date from API. Returns fetched and parsed data.
After object creation you can use ```fetch``` method to call API, fetch and parse data.
i.e.

```ruby
  exchange = NBP::ExchangeRate.last_a # example object
```

```ruby
  exchange.fetch
```

### Returns fetched and parsed data without calling API again.
```ruby
  exchange.data
```

## API/Tables content details:
www.nbp.pl/home.aspx?f=/kursy/instrukcja_pobierania_kursow_walut.html
