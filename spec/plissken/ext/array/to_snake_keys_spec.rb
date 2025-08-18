# frozen_string_literal: true

RSpec.describe "Array" do
  describe "#to_snake_keys" do
    context "with keys that are strings" do
      subject(:snaked) { array.to_snake_keys }

      let(:array) { [{ "firstKey" => "fooBar" }] }

      it "snakifies the key" do
        expect(snaked[0].keys.first).to eq("first_key")
      end

      it "leaves the key as a string" do
        expect(snaked[0].keys.first).to be_a(String)
      end

      it "leaves the value untouched" do
        expect(snaked[0].values.first).to eq("fooBar")
      end

      it "leaves the original hash untouched" do
        expect(array[0].keys.first).to eq("firstKey")
      end
    end

    context "with keys that are symbols" do
      subject(:snaked) { array.to_snake_keys }

      let(:array) { [{ firstKey: "fooBar" }] }

      it "snakifies the key and remains a symbol" do
        expect(snaked[0].keys.first).to eq(:first_key)
      end

      it "leaves the value untouched" do
        expect(snaked[0].values.first).to eq("fooBar")
      end

      it "leaves the original hash untouched" do
        expect(array[0].keys.first).to eq(:firstKey)
      end
    end

    describe "containing an array of nested hashes with camelCase string keys" do
      subject(:snaked) { array.to_snake_keys }

      let(:array) do
        [{
          "appleType" => "Granny Smith",
          "vegetableTypes" => [
            {
              "potatoType" => "Golden delicious"
            },
            {
              "otherTuberType" => "peanut"
            },
            {
              "peanutFamilies" => [
                {
                  "billThePeanut" => "sallyPeanut"
                },
                {
                  "sammyThePeanut" => "jillPeanut"
                }
              ]
            }
          ]
        }]
      end

      it "recursively snakifies the keys on the top level of the hash" do
        expect(snaked[0]).to have_key("apple_type")
        expect(snaked[0]).to have_key("vegetable_types")
      end

      it "leaves the values on the top level alone" do
        expect(snaked[0]["apple_type"]).to eq("Granny Smith")
      end

      it "converts second-level keys" do
        expect(snaked[0]["vegetable_types"].first).to have_key("potato_type")
      end

      it "leaves second-level values alone" do
        expect(snaked[0]["vegetable_types"].first).to have_value("Golden delicious")
      end

      it "converts third-level keys" do
        expect(snaked[0]["vegetable_types"].last["peanut_families"].first).to have_key("bill_the_peanut")
        expect(snaked[0]["vegetable_types"].last["peanut_families"].last).to have_key("sammy_the_peanut")
      end

      it "leaves third-level values alone" do
        expect(snaked[0]["vegetable_types"].last["peanut_families"].first["bill_the_peanut"]).to eq("sallyPeanut")
        expect(snaked[0]["vegetable_types"].last["peanut_families"].last["sammy_the_peanut"]).to eq("jillPeanut")
      end
    end

    describe "containing an array of other hashes" do
      subject(:snaked) { array.to_snake_keys }

      let(:array) do
        [
          {
            appleType: "Granny Smith",
            vegetableTypes: [
              { potatoType: "Golden delicious" },
              { otherTuberType: "peanut" },
              { peanutFamilies: [
                { billThePeanut: "sallyPeanut" },
                { sammyThePeanut: "jillPeanut" }
              ] }
            ]
          }
        ]
      end

      it "recursively snakifies the keys on the top level of the hash" do
        expect(snaked[0]).to have_key(:apple_type)
        expect(snaked[0]).to have_key(:vegetable_types)
      end

      it "leaves the values on the top level alone" do
        expect(snaked[0][:apple_type]).to eq("Granny Smith")
      end

      it "converts second-level keys" do
        expect(snaked[0][:vegetable_types].first).to have_key(:potato_type)
      end

      it "leaves second-level values alone" do
        expect(snaked[0][:vegetable_types].first).to have_value("Golden delicious")
      end

      it "converts third-level keys" do
        expect(snaked[0][:vegetable_types].last[:peanut_families].first).to have_key(:bill_the_peanut)
        expect(snaked[0][:vegetable_types].last[:peanut_families].last).to have_key(:sammy_the_peanut)
      end

      it "leaves third-level values alone" do
        expect(snaked[0][:vegetable_types].last[:peanut_families].first[:bill_the_peanut]).to eq("sallyPeanut")
        expect(snaked[0][:vegetable_types].last[:peanut_families].last[:sammy_the_peanut]).to eq("jillPeanut")
      end
    end

    context "with keys with spaces in them" do
      it "doesn't get snaked, although it does get downcased" do
        expect([{ "With Spaces" => "FooBar" }].to_snake_keys[0]).to have_key("with spaces")
      end
    end

    context "with keys that aren't strings or symbols" do
      it "doesn't get snaked" do
        expect([{ 1 => "FooBar" }].to_snake_keys[0].keys.first).to eq(1)
      end
    end
  end
end
