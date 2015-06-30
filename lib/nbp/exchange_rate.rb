require 'open-uri'
require 'date'
require 'nori'
require_relative './commons.rb'
module NBP
  ExchangeError = Class.new(StandardError)
  class ExchangeRate
    extend NBP::Commons
    attr_accessor :nbp_file_name # you can pass nbp_file_name directly
    attr_reader :data
    EXCHANGE_RATE_URL = 'http://www.nbp.pl/kursy/xml/'

    class << self
      %w(a b c).each do |suffix|
        define_method("exchange_#{suffix}") { new latest: "Last#{suffix.upcase}" }
        alias_method "last_#{suffix}", "exchange_#{suffix}"
      end

      def on_date(date, table_name:, table_number:)
        new({ table_name: table_name, table_number: table_number }.merge nbp_date_format_hash(date))
      end

      private

      def normalize_time_period(number_word)
        number_word.size == 1 ? '0' + number_word : number_word
      end
    end

    def initialize(constant_element = 'z', file_extension = '.xml', **fields)
      latest = fields[:latest]
      if latest
        @nbp_file_name = latest + file_extension
      else
        @nbp_file_name = fields[:table_name] + fields[:table_number] + constant_element +
                         fields[:year] + fields[:month] + fields[:day] + file_extension
      end
    rescue NoMethodError
      raise ExchangeError, 'One or more fields are missing. Unable to build the object.'
    end

    def fetch
      full_file_path = EXCHANGE_RATE_URL + nbp_file_name
      @data = ::Nori.new.parse open(full_file_path).read
    rescue OpenURI::HTTPError
      raise ExchangeError, 'Problem with connection or requested information not found.'
    end
  end
end
