require 'nbp/version'
require 'nbp/exchange_rate.rb'
require 'nbp/xml_file_list.rb'

module NBP
  def self.root
    File.dirname __dir__
  end
end
