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
          let(:hash) do [{
            'appleType' => 'Granny Smith',
            'vegetableTypes' => [
              { 'potatoType' => 'Golden delicious' },
              { 'otherTuberType' => 'peanut' },
              { 'peanutNamesAndSpouses' => [
                { 'billThePeanut' => 'sallyPeanut' },
                { 'sammyThePeanut' => 'jillPeanut' }
              ] }
            ]}]
          end
          
        describe 'non-destructive snakification' do
            subject(:snaked) { hash.map(&:to_snake_keys).first }
      #
          it 'recursively snakifies the keys on the top level of the hash' do
            expect(snaked.include?(:apple_type)).to be_truthy
            expect(snaked.include?(:vegetable_types)).to be_truthy
          end

          it 'leaves the values on the top level alone' do
            expect(snaked[:apple_type]).to eq('Granny Smith')
          end

          it 'converts second-level keys' do
            expect(snaked[:vegetable_types].first.keys.last)
                .to eq(:potato_type)
          end

          it 'leaves second-level values alone' do
            expect(snaked[:vegetable_types].first.values.last)
                .to eq('Golden delicious')
          end

          it 'converts third-level keys' do
            expect(snaked[:vegetable_types].last[:peanut_names_and_spouses]
                       .last.values.last).to eq('jillPeanut')
            expect(snaked[:vegetable_types].last[:peanut_names_and_spouses]
                       .last.keys.last).to eq(:sammy_the_peanut)
          end
      #
      #     it 'leaves third-level values alone' do
      #       assert_equal 'sallyPeanut', @snaked['vegetable_types']
      #         .last['peanut_names_and_spouses']
      #         .first['bill_the_peanut']
      #       assert_equal 'jillPeanut', @snaked['vegetable_types']
      #         .last['peanut_names_and_spouses']
      #         .last['sammy_the_peanut']
      #     end
        end
      end
    end

    # describe 'which are symbols' do
    #   describe 'in the simplest case' do
    #     before do
    #       @hash = { :firstKey => 'fooBar' }
    #     end
    #
    #     describe 'non-destructive snakification' do
    #       before do
    #         @snaked = @hash.to_snake_keys
    #       end
    #
    #       it 'snakifies the key' do
    #         assert_equal(@snaked.keys.first, :first_key)
    #       end
    #
    #       it 'leaves the key as a symbol' do
    #         assert_equal(:first_key, @snaked.keys.first)
    #       end
    #
    #       it 'leaves the value untouched' do
    #         assert_equal(@snaked.values.first, 'fooBar')
    #       end
    #
    #       it 'leaves the original hash untouched' do
    #         assert_equal(@hash.keys.first, :firstKey)
    #       end
    #     end
    #   end
    #
    #   describe 'containing an array of other hashes' do
    #     before do
    #       @hash = {
    #         :appleType => 'Granny Smith',
    #         :vegetableTypes => [
    #           { :potatoType => 'Golden delicious' },
    #           { :otherTuberType => 'peanut' },
    #           { :peanutNamesAndSpouses => [
    #             { :billThePeanut => 'sallyPeanut' },
    #             { :sammyThePeanut => 'jillPeanut' }
    #           ] }
    #         ] }
    #     end
    #
    #     describe 'non-destructive snakification' do
    #       before do
    #         @snaked = @hash.to_snake_keys
    #       end
    #
    #       it 'recursively snakifies the keys on the top level of the hash' do
    #         assert @snaked.keys.include?(:apple_type)
    #         assert @snaked.keys.include?(:vegetable_types)
    #       end
    #
    #       it 'leaves the values on the top level alone' do
    #         assert_equal(@snaked[:apple_type], 'Granny Smith')
    #       end
    #
    #       it 'converts second-level keys' do
    #         assert @snaked[:vegetable_types].first.key? :potato_type
    #       end
    #
    #       it 'leaves second-level values alone' do
    #         assert @snaked[:vegetable_types].first.value? 'Golden delicious'
    #       end
    #
    #       it 'converts third-level keys' do
    #         assert @snaked[:vegetable_types].last[:peanut_names_and_spouses]
    #           .first.key?(:bill_the_peanut)
    #         assert @snaked[:vegetable_types].last[:peanut_names_and_spouses]
    #           .last.key?(:sammy_the_peanut)
    #       end
    #
    #       it 'leaves third-level values alone' do
    #         assert_equal 'sallyPeanut', @snaked[:vegetable_types]
    #           .last[:peanut_names_and_spouses]
    #           .first[:bill_the_peanut]
    #         assert_equal 'jillPeanut', @snaked[:vegetable_types]
    #           .last[:peanut_names_and_spouses]
    #           .last[:sammy_the_peanut]
    #       end
    #     end
    #   end
    # end
  end

  # describe 'strings with spaces in them' do
  #   before do
  #     @hash = { 'With Spaces' => 'FooBar' }
  #     @snaked = @hash.to_snake_keys
  #   end
  #
  #   it "doesn't get snaked, although it does get downcased" do
  #     assert @snaked.keys.include? 'with spaces'
  #   end
  # end
end
