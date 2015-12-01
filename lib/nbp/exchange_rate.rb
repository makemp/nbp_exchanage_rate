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

    class << self
      %w(a b c).each do |suffix|
        define_method("exchange_#{suffix}") { new "Last#{suffix.upcase}" }
        alias_method "last_#{suffix}", "exchange_#{suffix}"
      end

      def on_date(date, table_name:, table_number:)
        new({ table_name: table_name, table_number: table_number }.merge nbp_date_format_hash(date))
      end

      def by_file(file_name)
        new(file_name)
      end

      def all_exchange_rates(date)
        file_names = files_names_on_date(date)
        mutex = Mutex.new
        threads = []
        data = file_names.each_with_object([]) do |file_name, arr|
          threads << Thread.new do
            mutex.synchronize { arr << new(file_name).fetch['tabela_kursow']['pozycja'] }
          end
        end
        threads.map(&:join)
        data.flatten
      end

      private

      def files_names_on_date(date)
        XMLFilesList.new(date).fetch_file_names
      end
    end

    def initialize(base_file_name = nil, constant_element = 'z', file_extension = '.xml', **fields)
      if base_file_name
        @nbp_file_name = base_file_name + file_extension
      else
        @nbp_file_name = fields[:table_name] + fields[:table_number] + constant_element +
                         fields[:year] + fields[:month] + fields[:day] + file_extension
      end
    rescue NoMethodError
      raise ExchangeError, 'One or more fields are missing. Unable to build the object.'
    end

    def fetch
      full_file_path = Commons::CORE_WEB_PATH + nbp_file_name
      @data = ::Nori.new(parser: :rexml).parse open(full_file_path).read
      fail ExchangeError, 'Missing field tabela_kursow in fetched data' unless @data.key?('tabela_kursow')
      return @data
    rescue OpenURI::HTTPError
      raise ExchangeError, 'Problem with connection or requested information not found.'
    end
  end
end
