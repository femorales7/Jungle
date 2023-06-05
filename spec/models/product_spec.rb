require 'rails_helper'

RSpec.describe Product, type: :model do

  describe 'validation' do
    before( :each) do
      @category = Category.create(name: "New Catergory")
      @product = Product.new(
        name: 'New Product',
        price_cents: 1000,
        quantity: 10,
        category: @category
      )
    end
    it 'should save successfully when all fields are set' do
      expect(@product.save).to be true
    end

    it 'should not save when name is not present' do
      @product.name = nil
      expect(@product.save).to be false
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'should not save when price is not present' do
      @product.price_cents = nil
      expect(@product.save).to be false
      expect(@product.errors.full_messages).to include("Price cents is not a number")
    end

    it 'should not save when quantity is not present' do
      @product.quantity = nil
      expect(@product.save).to be false
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'should not save when category is not present' do
      @product.category = nil
      expect(@product.save).to be false
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end  
  end
end
