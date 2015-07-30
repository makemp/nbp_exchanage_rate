require 'date'
require 'open-uri'
require_relative './commons.rb'
module NBP
  class XMLFilesList
    attr_reader :dir_name, :matched_base_file_names

    BASE_NAME = 'dir'

    include Commons

    def initialize(date, file_extension = '.txt')
      @dir_name = files_list_name(date) + file_extension
      @formatted_date = nbp_date_format_string(date)
      @matched_base_file_names = []
    end

    def fetch_file_names
      dir_file = open(Commons::CORE_WEB_PATH + dir_name, 'r')
      @matched_base_file_names = dir_file.each_line.with_object([]) do |line, arr|
        trim_line = line.strip
        arr << trim_line if trim_line[-6..-1] == formatted_date
      end
    end

    def matched_file_names_as_hashes
      matched_base_file_names.map do |name|
        { table_name: name[0],
          table_number: name[1..3],
          constant_element: name[4],
          year: name[5..6],
          month: name[7..8],
          day: name[9..10],
          extension: name[-4..-1] }
      end
    end

    private

    attr_reader :formatted_date

    def nbp_date_format_string(date)
      date_hash = nbp_date_format_hash(date)
      date_hash[:year] + date_hash[:month] + date_hash[:day]
    end

    def files_list_name(date)
      year = date.year.to_s
      return BASE_NAME if year[-2..-1] == DateTime.now.year.to_s[-2..-1]
      BASE_NAME + year
    end
  end
end
