exchange_rate = File.open(NBP.root + '/spec/stub_responses/nbp_exchange_rate_fetch.xml', 'r').read
file_names = File.open(NBP.root + '/spec/stub_responses/file_names.txt', 'r').read

# rubocop:disable MethodLength
def mocked_exchange_rate(table_name, country, table_number = '137')
  <<-XML
    <tabela_kursow typ="H" uid="13#{table_name + table_number}">
      <numer_tabeli>137/2013/BGK</numer_tabeli>
      <data_notowania>2013-07-16</data_notowania>
      <data_publikacji>2013-07-17</data_publikacji>
      <pozycja>
        <nazwa_kraju>#{country}</nazwa_kraju>
        <symbol_waluty>101</symbol_waluty>
        <nazwa_waluty>#{country}Waluta</nazwa_waluty>
        <przelicznik>1</przelicznik>
        <odnosnik/>
        <kurs_kupna>0,2090</kurs_kupna>
        <kurs_sprzedazy>0,2110</kurs_sprzedazy>
        <kurs_sredni>0,2100</kurs_sredni>
      </pozycja>
    </tabela_kursow>
  XML
end
# rubocop:enable MethodLength

RSpec.configure do |config|
  config.before(:each) do
    WebMock.stub_request(:get, 'http://www.nbp.pl/kursy/xml/h137z130717.xml')
      .to_return(status: 200, body: exchange_rate, headers: {})
    WebMock.stub_request(:get, 'http://www.nbp.pl/kursy/xml/dir2013.txt')
      .to_return(status: 200, body: file_names, headers: {})
    WebMock.stub_request(:get, 'http://www.nbp.pl/kursy/xml/c007z130110.xml')
      .to_return(status: 200, body: mocked_exchange_rate('c', 'Hiszpania'), headers: {})
    WebMock.stub_request(:get, 'http://www.nbp.pl/kursy/xml/h007z130110.xml')
      .to_return(status: 200, body: mocked_exchange_rate('h', 'USA'), headers: {})
    WebMock.stub_request(:get, 'http://www.nbp.pl/kursy/xml/a007z130110.xml')
      .to_return(status: 200, body: mocked_exchange_rate('a', 'Japonia'), headers: {})
  end
end
