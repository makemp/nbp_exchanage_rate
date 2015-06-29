require_relative '../spec_helper'

describe NBP::ExchangeRate do
  it { expect { NBP::ExchangeRate.new }.to raise_error(NBP::ExchangeError) }

  it do
    exchange = NBP::ExchangeRate.new(year: '15', month: '01', day: '23', table_name: 'h', table_number: '023')
    expect(exchange).to respond_to(:fetch)
  end

  subject { NBP::ExchangeRate } # yes, it is necessary
  %w(a b c).each do |suffix|
    it { is_expected.to respond_to("exchange_#{suffix}") }
    it { is_expected.to respond_to("last_#{suffix}") }
  end
  it { is_expected.to respond_to(:on_date) }
end
