# spec/factories/products.rb
FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "Product #{n}" }
    category { "Example Category" }
    available { 10 }
  end
end
