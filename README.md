# NbpExchangeRate
Includes methods which allow to connect with Polish National Bank exchange rate API.

## Installation

Add this line to your application's Gemfile:

```ruby
  gem 'nbp_exchange_rate'
```

And then execute:

    $ bundle

## Usage

### Simplest: fetch all exchange rates on date

```ruby
  NBP::ExchangeRate.all_exchange_rates(date_object) # => Returns an array of hashes
  # date_object must have day, month and year methods i.e DateTime.now
  # Example output(shortened). Original, Polish language. API data and fields are in Polish
  # [
  #   {
  #     "nazwa_waluty"=>"dolar amerykański",
  #     "przelicznik"=>"1",
  #     "kod_waluty"=>"USD",
  #     "kurs_kupna"=>"3,7512",
  #     "kurs_sprzedazy"=>"3,8270"
  #   },
  #   {
  #     "nazwa_waluty"=>"dolar australijski",
  #     "przelicznik"=>"1",
  #     "kod_waluty"=>"AUD",
  #     "kurs_kupna"=>"2,7293",
  #     "kurs_sprzedazy"=>"2,7845"
  #   }
  # ]
```

### Get list of files on date.
To know which files are interesting.

#### Object creation

```ruby
  nbp_list = NBP::XMLFilesList.new(date_object) # date_object must have day, month and year methods i.e DateTime.now
```

#### Fetch data from API

```ruby
  nbp_list.fetch_file_names # => returns array of strings (file names without extension)
  # i.e.
  # ['c137z130717', 'h137z130717', 'a137z130717', 'b029z130717']
```

#### Retrieve file names from object

```ruby
  nbp_list.matched_base_file_names # => returns array of strings (file names without extension)
  # i.e.
  # ['c137z130717', 'h137z130717', 'a137z130717', 'b029z130717']
```

#### Present file names as hashes

```ruby
  nbp_list.matched_file_names_as_hashes # => returns array of hashes.
  # i.e.
  # [{ table_name: 'c',
  #    table_number: '137',
  #    constant_element: 'z',
  #    year: '13',
  #    month: '07',
  #    day: '17',
  #    extension: '0717'
  #  },
  #  {
  #    table_name: 'h',
  #    table_number: '137',
  #    constant_element: 'z',
  #    year: '13',
  #    month: '07',
  #    day: '17',
  #    extension: '0717'
  #  }
  # ]
```

### Get exchange rate data from API

#### Create object using file name

```ruby
  file_name = 'c137z130717'
  exchange_rate = NBP::ExchangeRate.by_file(file_name)
```
OR just:

```ruby
  filename = 'c137z130717'
  exchange_rate = NBP::ExchangeRate.new(file_name)
```

#### Create object using date, table_name and table_number

```ruby
  # date_object must have day, month and year methods i.e DateTime.now
  exchange_rate = NBP::ExchangeRate.on_date(date_object, table_name: 'h', table_number: '012')
```

#### Create object for fetching latest exchange rate data (tables A, B, C)
```ruby
   NBP::ExchangeRate.last_a
   NBP::ExchangeRate.last_b
   NBP::ExchangeRate.last_c
```
  OR
```ruby
   NBP::ExchangeRate.exchange_a
   NBP::ExchangeRate.exchange_b
   NBP::ExchangeRate.exchange_c
```

#### Create object using pure hash

```ruby
  exchange_rate = NBP::ExchangeRate.new(table_name: 'h', table_number: '002', day: '02', month: '12', year: '15')
```

#### Fetch and parse date from API. Returns fetched and parsed data.

```ruby
  exchange_rate.fetch # => returns hash of exchange rate data
```
  Example output in [one of specs](spec/nbp/exchange_rate_spec.rb) Original, Polish language. API data and fields are in Polish.

#### Retrieve exchange rate data from object
```ruby
  exchange_rate.data # => returns hash of exchange rate data
```

## API/Tables content details:
www.nbp.pl/home.aspx?f=/kursy/instrukcja_pobierania_kursow_walut.html
