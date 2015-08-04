require_relative '../spec_helper'

describe NBP::ExchangeRate do
  describe 'class methods' do
    subject(:exchange_rate) { described_class }
    it { is_expected.to respond_to(:last_a) }
    it { is_expected.to respond_to(:last_b) }
    it { is_expected.to respond_to(:last_c) }
    it { is_expected.to respond_to(:exchange_a) }
    it { is_expected.to respond_to(:exchange_b) }
    it { is_expected.to respond_to(:exchange_c) }
    it { is_expected.to respond_to(:on_date) }
    it { is_expected.to respond_to(:by_file) }
    it { is_expected.to respond_to(:all_exchange_rates) }

    let(:expected) do
      [
        {
          'nazwa_kraju' => 'Hiszpania',
          'symbol_waluty' => '101',
          'nazwa_waluty' => 'HiszpaniaWaluta',
          'przelicznik' => '1',
          'odnosnik' => nil,
          'kurs_kupna' => '0,2090',
          'kurs_sprzedazy' => '0,2110',
          'kurs_sredni' => '0,2100' },
        {
          'nazwa_kraju' => 'USA',
          'symbol_waluty' => '101',
          'nazwa_waluty' => 'USAWaluta',
          'przelicznik' => '1',
          'odnosnik' => nil,
          'kurs_kupna' => '0,2090',
          'kurs_sprzedazy' => '0,2110',
          'kurs_sredni' => '0,2100' },
        {
          'nazwa_kraju' => 'Japonia',
          'symbol_waluty' => '101',
          'nazwa_waluty' => 'JaponiaWaluta',
          'przelicznik' => '1',
          'odnosnik' => nil,
          'kurs_kupna' => '0,2090',
          'kurs_sprzedazy' => '0,2110',
          'kurs_sredni' => '0,2100' }
      ]
    end

    it { expect(exchange_rate.all_exchange_rates(Date.parse('2013-01-10'))).to eq expected }
  end

  describe 'instance methods' do
    let(:expected) do
      {
        'tabela_kursow' => {
          'numer_tabeli' => '137/2013/BGK', 'data_notowania' => Date.parse('2013-07-16'),
          'data_publikacji' => Date.parse('2013-07-17'), 'pozycja' => [{
            'nazwa_kraju' => 'Kraje byłej RWPG',
            'symbol_waluty' => '101',
            'nazwa_waluty' => 'rb. transf.',
            'przelicznik' => '1',
            'odnosnik' => nil,
            'kurs_kupna' => '0,2090',
            'kurs_sprzedazy' => '0,2110',
            'kurs_sredni' => '0,2100'
          }, {
            'nazwa_kraju' => 'Albania',
            'symbol_waluty' => '315',
            'nazwa_waluty' => 'rb. clear. (Albania)',
            'przelicznik' => '1',
            'odnosnik' => nil,
            'kurs_kupna' => '0,2090',
            'kurs_sprzedazy' => '0,2110',
            'kurs_sredni' => '0,2100'
          }, {
            'nazwa_kraju' => 'Kambodża',
            'symbol_waluty' => '317',
            'nazwa_waluty' => 'rb. clear. (Kambodża)',
            'przelicznik' => '1',
            'odnosnik' => nil,
            'kurs_kupna' => '0,2090',
            'kurs_sprzedazy' => '0,2110',
            'kurs_sredni' => '0,2100'
          }, {
            'nazwa_kraju' => 'KRL-D',
            'symbol_waluty' => '319',
            'nazwa_waluty' => 'rb. clear. (KRL-D)',
            'przelicznik' => '1',
            'odnosnik' => nil,
            'kurs_kupna' => '0,2090',
            'kurs_sprzedazy' => '0,2110',
            'kurs_sredni' => '0,2100'
          }, {
            'nazwa_kraju' => 'Pozostałe',
            'symbol_waluty' => '0',
            'nazwa_waluty' => 'USD clear.',
            'przelicznik' => '1',
            'odnosnik' => '*)',
            'kurs_kupna' => '3,2571',
            'kurs_sprzedazy' => '3,2899',
            'kurs_sredni' => '3,2735'
          }],
          '@typ' => 'H',
          '@uid' => '13h137'
        }
      }
    end
    subject { described_class.on_date(DateTime.parse('13-07-17'), table_name: 'h', table_number: '137') }
    its(:fetch) { is_expected.to match expected }
  end
end
