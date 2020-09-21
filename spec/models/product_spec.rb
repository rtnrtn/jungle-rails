require 'rails_helper'

RSpec.describe Product, type: :model do

  describe 'Validations' do
    let (:category) { Category.create(name: "furniture") }
    let (:product_name) { "coffee table" }
    let (:product_description) { "wowza one of a kind" }
    let (:product_price_cents) { 300 }
    let (:product_quantity) { 40 }
    let (:product_category) { category }
    let (:product) do 
      Product.new(
        name: product_name,
        description: product_description,
        price_cents: product_price_cents,
        quantity: product_quantity,
        category: product_category
      )
    end

    context "given a product with all fields present" do
      it "saves successfully" do
        expect(product.save!).to eq(true)
        expect(Product.count).to eq(1)
      end
    end
    
    context "given an empty name field" do
      let (:product_name) { "" } 

      it "does not save" do
        expect(product.save).to eq(false)
        expect(product.errors.full_messages).to include("Name can't be blank")
        expect(Product.count).to eq(0)
      end
    end

    context "given an empty price field" do
      let (:product_price_cents) { nil }

      it "does not save" do
        expect(product.save).to eq(false)
        expect(product.errors.full_messages).to include("Price can't be blank")
        expect(Product.count).to eq(0)
      end
    end
    
    context "given an empty quantity field" do
      let (:product_quantity) { nil }

      it "does not save" do
        expect(product.save).to eq(false)
        expect(product.errors.full_messages).to include("Quantity can't be blank")
        expect(Product.count).to eq(0)
      end
    end
    
    context "given an empty category field" do
      let (:product_category) { nil } 

      it "does not save" do
        expect(product.save).to eq(false)
        expect(product.errors.full_messages).to include("Category can't be blank")
        expect(Product.count).to eq(0)
      end
    end

  end
end
