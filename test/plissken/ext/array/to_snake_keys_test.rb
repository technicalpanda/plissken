# frozen_string_literal: true

require File.expand_path(File.dirname(__FILE__) + "/../../../test_helper.rb")

describe "Array" do
  describe "with camelBack keys" do
    describe "which are JSON-style strings" do
      describe "in the simplest case" do
        before do
          @array = [{ "firstKey" => "fooBar" }]
        end

        describe "non-destructive snakification" do
          before do
            @snaked = @array.to_snake_keys
          end

          it "snakifies the key" do
            assert_equal("first_key", @snaked[0].keys.first)
          end

          it "leaves the key as a string" do
            assert_equal("first_key", @snaked[0].keys.first)
          end

          it "leaves the value untouched" do
            assert_equal("fooBar", @snaked[0].values.first)
          end

          it "leaves the original hash untouched" do
            assert_equal("firstKey", @array[0].keys.first)
          end
        end
      end

      describe "containing an array of other hashes" do
        before do
          @array = [{
            "appleType" => "Granny Smith",
            "vegetableTypes" => [
              { "potatoType" => "Golden delicious" },
              { "otherTuberType" => "peanut" },
              { "peanutNamesAndSpouses" => [
                { "billThePeanut" => "sallyPeanut" },
                { "sammyThePeanut" => "jillPeanut" }
              ] }
            ]
          }]
        end

        describe "non-destructive snakification" do
          before do
            @snaked = @array.to_snake_keys
          end

          it "recursively snakifies the keys on the top level of the hash" do
            assert @snaked[0].key?("apple_type")
            assert @snaked[0].key?("vegetable_types")
          end

          it "leaves the values on the top level alone" do
            assert_equal("Granny Smith", @snaked[0]["apple_type"])
          end

          it "converts second-level keys" do
            assert @snaked[0]["vegetable_types"].first.key? "potato_type"
          end

          it "leaves second-level values alone" do
            assert @snaked[0]["vegetable_types"].first.value? "Golden delicious"
          end

          it "converts third-level keys" do
            assert @snaked[0]["vegetable_types"].last["peanut_names_and_spouses"]
              .first.key?("bill_the_peanut")
            assert @snaked[0]["vegetable_types"].last["peanut_names_and_spouses"]
              .last.key?("sammy_the_peanut")
          end

          it "leaves third-level values alone" do
            assert_equal "sallyPeanut", @snaked[0]["vegetable_types"]
              .last["peanut_names_and_spouses"]
              .first["bill_the_peanut"]
            assert_equal "jillPeanut", @snaked[0]["vegetable_types"]
              .last["peanut_names_and_spouses"]
              .last["sammy_the_peanut"]
          end
        end
      end
    end

    describe "which are symbols" do
      describe "in the simplest case" do
        before do
          @array = [{ firstKey: "fooBar" }]
        end

        describe "non-destructive snakification" do
          before do
            @snaked = @array.to_snake_keys
          end

          it "snakifies the key" do
            assert_equal(:first_key, @snaked[0].keys.first)
          end

          it "leaves the key as a symbol" do
            assert_equal(:first_key, @snaked[0].keys.first)
          end

          it "leaves the value untouched" do
            assert_equal("fooBar", @snaked[0].values.first)
          end

          it "leaves the original hash untouched" do
            assert_equal(:firstKey, @array[0].keys.first)
          end
        end
      end

      describe "containing an array of other hashes" do
        before do
          @array = [{
            appleType: "Granny Smith",
            vegetableTypes: [
              { potatoType: "Golden delicious" },
              { otherTuberType: "peanut" },
              { peanutNamesAndSpouses: [
                { billThePeanut: "sallyPeanut" },
                { sammyThePeanut: "jillPeanut" }
              ] }
            ]
          }]
        end

        describe "non-destructive snakification" do
          before do
            @snaked = @array.to_snake_keys
          end

          it "recursively snakifies the keys on the top level of the hash" do
            assert @snaked[0].key?(:apple_type)
            assert @snaked[0].key?(:vegetable_types)
          end

          it "leaves the values on the top level alone" do
            assert_equal("Granny Smith", @snaked[0][:apple_type])
          end

          it "converts second-level keys" do
            assert @snaked[0][:vegetable_types].first.key? :potato_type
          end

          it "leaves second-level values alone" do
            assert @snaked[0][:vegetable_types].first.value? "Golden delicious"
          end

          it "converts third-level keys" do
            assert @snaked[0][:vegetable_types].last[:peanut_names_and_spouses]
              .first.key?(:bill_the_peanut)
            assert @snaked[0][:vegetable_types].last[:peanut_names_and_spouses]
              .last.key?(:sammy_the_peanut)
          end

          it "leaves third-level values alone" do
            assert_equal "sallyPeanut", @snaked[0][:vegetable_types]
              .last[:peanut_names_and_spouses]
              .first[:bill_the_peanut]
            assert_equal "jillPeanut", @snaked[0][:vegetable_types]
              .last[:peanut_names_and_spouses]
              .last[:sammy_the_peanut]
          end
        end
      end
    end
  end

  describe "strings with spaces in them" do
    before do
      @array = [{ "With Spaces" => "FooBar" }]
      @snaked = @array.to_snake_keys
    end

    it "doesn't get snaked, although it does get downcased" do
      assert @snaked[0].key?("with spaces")
    end
  end
end
