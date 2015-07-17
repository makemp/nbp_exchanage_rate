body = File.open(NBP.root + '/spec/stub_responses/nbp_exchange_rate_fetch.xml', 'r').read

RSpec.configure do |config|
  config.before(:each) do
    WebMock.stub_request(:get, 'http://www.nbp.pl/kursy/xml/h137z130717.xml')
      .with(headers: { 'Accept': '*/*',
                       'Accept-Encoding': 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                       'User-Agent': 'Ruby' }).to_return(status: 200, body: body, headers: {})
  end
end
