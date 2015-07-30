exchange_rate = File.open(NBP.root + '/spec/stub_responses/nbp_exchange_rate_fetch.xml', 'r').read
file_names = File.open(NBP.root + '/spec/stub_responses/file_names.txt', 'r').read

RSpec.configure do |config|
  config.before(:each) do
    WebMock.stub_request(:get, 'http://www.nbp.pl/kursy/xml/h137z130717.xml')
      .to_return(status: 200, body: exchange_rate, headers: {})
    WebMock.stub_request(:get, 'http://www.nbp.pl/kursy/xml/dir2013.txt')
      .to_return(status: 200, body: file_names, headers: {})
  end
end
