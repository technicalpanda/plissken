require 'spec_helper'

require File.expand_path(File.dirname(__FILE__) + '/../../lib/plissken')

RSpec.describe 'A Hash' do
  describe 'with camelBack keys' do
    describe 'which are JSON-style strings' do
      describe 'in the simplest case' do
        let(:hash) { [{ 'firstKey' => 'fooBar' }] }

        describe 'non-destructive snakification' do
          let(:snaked) { hash.map(&:to_snake_keys) }
          it 'snakifies the key' do
            expect(snaked.first).to have_key(:first_key)
          end

          it 'leaves the key as a string' do
            expect(snaked.first.keys).to eq([:first_key])
          end

          it 'leaves the value untouched' do
            expect(hash.first.values).to eq(['fooBar'])
          end

          it 'leaves the original hash untouched' do
            expect(hash.first.keys).to eq(['firstKey'])
          end
        end
      end

      describe 'containing an array of other hashes' do
        let(:hash) do
          {
            'appleType' => 'Granny Smith',
            'vegetableTypes' => [
              { 'potatoType' => 'Golden delicious' },
              { 'otherTuberType' => 'peanut' },
              { 'peanutNamesAndSpouses' => [
                { 'billThePeanut' => 'sallyPeanut' },
                { 'sammyThePeanut' => 'jillPeanut' }
              ] }
            ] }
        end

        describe 'non-destructive snakification' do
          subject(:snaked) { hash.to_snake_keys }
          #
          it 'recursively snakifies the keys on the top level of the hash' do
            expect(snaked.include?(:apple_type)).to be_truthy
            expect(snaked.include?(:vegetable_types)).to be_truthy
          end

          it 'leaves the values on the top level alone' do
            expect(snaked[:apple_type]).to eq('Granny Smith')
          end

          it 'converts second-level keys' do
            expect(snaked[:vegetable_types].first)
              .to have_key(:potato_type)
          end

          it 'leaves second-level values alone' do
            expect(snaked[:vegetable_types].first)
              .to have_value('Golden delicious')
          end

          it 'converts third-level keys' do
            expect(snaked[:vegetable_types].last[:peanut_names_and_spouses]
                       .last).to have_value('jillPeanut')
            expect(snaked[:vegetable_types]
                       .last[:peanut_names_and_spouses]
                       .last).to have_key(:sammy_the_peanut)
          end

          it 'leaves third-level values alone' do
            expect(snaked[:vegetable_types]
              .last[:peanut_names_and_spouses]
              .first[:bill_the_peanut]).to eq('sallyPeanut')
            expect(snaked[:vegetable_types]
              .last[:peanut_names_and_spouses]
              .last[:sammy_the_peanut]).to eq('jillPeanut')
          end
        end
      end
    end

    describe 'which are symbols' do
      describe 'in the simplest case' do
        let(:hash)  { { :firstKey => 'fooBar' } }

        describe 'non-destructive snakification' do
          subject(:snaked) { hash.to_snake_keys }

          it 'snakifies the key' do
            expect(snaked).to have_key(:first_key)
          end

          it 'leaves the key as a symbol' do
            expect(:first_key).to eq(snaked.keys.first)
          end

          it 'leaves the value untouched' do
            expect(snaked.values.first).to eq('fooBar')
          end

          it 'leaves the original hash untouched' do
            expect(hash).to have_key(:firstKey)
          end
        end
      end
      #
      describe 'containing an array of other hashes' do
        let(:hash) do
          {
            :appleType => 'Granny Smith',
            :vegetableTypes => [
              { :potatoType => 'Golden delicious' },
              { :otherTuberType => 'peanut' },
              { :peanutNamesAndSpouses => [
                { :billThePeanut => 'sallyPeanut' },
                { :sammyThePeanut => 'jillPeanut' }
              ] }
            ] }
        end
        #
        describe 'non-destructive snakification' do
          subject(:snaked) { hash.to_snake_keys }
          #
          it 'recursively snakifies the keys on the top level of the hash' do
            expect(snaked.include?(:apple_type)).to be_truthy
            expect(snaked.include?(:vegetable_types)).to be_truthy
          end

          it 'leaves the values on the top level alone' do
            expect(snaked[:apple_type]).to eq('Granny Smith')
          end

          it 'converts second-level keys' do
            expect(snaked[:vegetable_types].first)
              .to have_key(:potato_type)
          end

          it 'leaves second-level values alone' do
            expect(snaked[:vegetable_types].first)
              .to have_value('Golden delicious')
          end

          it 'converts third-level keys' do
            expect(snaked[:vegetable_types].last[:peanut_names_and_spouses]
                       .last).to have_value('jillPeanut')
            expect(snaked[:vegetable_types]
                       .last[:peanut_names_and_spouses]
                       .last).to have_key(:sammy_the_peanut)
          end

          it 'leaves third-level values alone' do
            expect(snaked[:vegetable_types]
                       .last[:peanut_names_and_spouses]
                       .first[:bill_the_peanut]).to eq('sallyPeanut')
            expect(snaked[:vegetable_types]
                       .last[:peanut_names_and_spouses]
                       .last[:sammy_the_peanut]).to eq('jillPeanut')
          end
        end
      end
    end
  end

  describe 'strings with spaces in them' do
    let(:hash)  { { ' With Spaces ' => ' FooBar ' } }
    subject { hash.to_snake_keys }

    it "doesn't get snaked, although it does get downcased" do
      is_expected.to have_key(:'with spaces')
    end
    it 'should have value equal to ' do
      is_expected.to have_value('FooBar')
    end
  end
end
