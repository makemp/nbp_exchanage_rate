require 'date'
require_relative './commons.rb'
module NBP
  class XMLFileList
    attr_accessor :name

    BASE_NAME = 'dir'

    include Commons

    def initialize(date, file_extension = '.txt')
      @name =  file_list_name(date) + file_extension
    end

    private

    def file_list_name(date)
      year = date.year.to_s
      return BASE_NAME if year[-2..-1] = DateTime.now.year.to_s[-2..-1]
      BASE_NAME + year
    end
  end
end
