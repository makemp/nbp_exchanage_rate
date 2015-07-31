require_relative '../spec_helper'

describe NBP::XMLFilesList do
  subject(:xml_files_list) { described_class.new(DateTime.parse('13-07-17')) }

  describe '#initialize' do
    its(:dir_name) { is_expected.to eq 'dir2013.txt' }
    its(:matched_base_file_names) { is_expected.to eq [] }
    its(:formatted_date) { is_expected.to eq '130717' }
  end

  describe 'fetching file names and present them as hashes' do
    let(:files_array_of_hash) do
      [{ table_name: 'c',
         table_number: '137',
         constant_element: 'z',
         year: '13',
         month: '07',
         day: '17',
         extension: '0717'
       },
       {
         table_name: 'h',
         table_number: '137',
         constant_element: 'z',
         year: '13',
         month: '07',
         day: '17',
         extension: '0717'
       },
       {
         table_name: 'a',
         table_number: '137',
         constant_element: 'z',
         year: '13',
         month: '07',
         day: '17',
         extension: '0717'
       },
       {
         table_name: 'b',
         table_number: '029',
         constant_element: 'z',
         year: '13',
         month: '07',
         day: '17',
         extension: '0717'
       }
      ]
    end

    before do
      xml_files_list.fetch_file_names
    end

    its(:matched_base_file_names) { is_expected.to eq %w(c137z130717 h137z130717 a137z130717 b029z130717) }
    its(:matched_file_names_as_hashes) do
      is_expected.to match_array files_array_of_hash
    end
  end

  describe 'private files_list_name method' do
    context 'current year' do
      it "returns 'dir'" do
        expect(xml_files_list.send(:files_list_name, DateTime.now)).to eq 'dir'
      end
    end

    context 'another year' do
      it "returns 'dir' with year" do
        expect(xml_files_list.send(:files_list_name, DateTime.parse('12-07-17'))).to eq 'dir2012'
      end
    end
  end
end
