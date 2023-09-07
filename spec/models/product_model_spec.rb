require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validations' do
    it 'validates the uniqueness of name' do
      product1 = FactoryBot.create(:product, name: 'TestProduct')
      product2 = FactoryBot.build(:product, name: 'testproduct') 
      expect(product1).to be_valid
      expect(product2).not_to be_valid
      expect(product2.errors[:name]).to include('has already been taken')
    end

    it 'validates that available is numerical and greater than 0' do
      product1 = FactoryBot.build(:product, available: 5)
      product2 = FactoryBot.build(:product, available: 'not_a_number')
      product3 = FactoryBot.build(:product, available: 0)
      expect(product1).to be_valid
      expect(product2).not_to be_valid
      expect(product2.errors[:available]).to include('is not a number')
      expect(product3).not_to be_valid
      expect(product3.errors[:available]).to include('must be greater than 0')
    end
  end
end
