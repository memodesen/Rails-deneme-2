# spec/_spec.rb
require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :controller do

  describe "GET #index" do
    it "returns a successful response" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "returns all products" do
      products = FactoryBot.create_list(:product, 3)
      get :index
      expect(response).to have_http_status(:success)
      expect(assigns(:products)).to eq(products)
    end
  end

  describe "GET #show" do
    it "returns a successful response" do
      product = FactoryBot.create(:product)
      get :show, params: { id: product.id }
      expect(response).to have_http_status(:success)
    end

    it "returns the requested product" do
      product = FactoryBot.create(:product)
      get :show, params: { id: product.id }
      expect(response).to have_http_status(:success)
      expect(assigns(:product)).to eq(product)
    end
  end

  describe "DELETE #destroy" do
    it "deletes the product" do
      product = FactoryBot.create(:product)
      delete :destroy, params: { id: product.id }
      expect(response).to have_http_status(:success)
      expect(Product.exists?(product.id)).to be_falsey
    end
  end


  
  describe "PUT #update" do
  it "updates the product" do
    product = FactoryBot.create(:product)
    puts "Before Update: #{product.inspect}"
    updated_params = { name: "Updated Product", category: "Updated Category", available: 5 }
    put :update, params: { id: product.id, product: updated_params }
    product.reload
    puts "After Update: #{product.inspect}"
    expect(response).to have_http_status(:ok)
    expect(product.name).to eq("Updated Product")
  end
  
  

  it "fails to update the product with invalid parameters" do
    product = FactoryBot.create(:product)
    original_name = product.name
    invalid_params = { name: "", category: "Updated Category", available: -5 } 
    put :update, params: { id: product.id, product: invalid_params }
    product.reload
    expect(response).to have_http_status(:unprocessable_entity)
    expect(product.name).to eq(original_name)
  end
  



end





describe "POST #buy" do
  it "buys the product with valid quantity" do
    product = FactoryBot.create(:product, available: 10)
    buy_params = { product_id: product.id, quantity: 5 }
    post :buy, params: buy_params
    expect(response).to have_http_status(:ok)
    expect(product.reload.available).to eq(5)
  end

  it "fails to buy the product with invalid quantity" do
    product = FactoryBot.create(:product, available: 10)
    buy_params = { product_id: product.id, quantity: 15 }
    post :buy, params: buy_params
    expect(response).to have_http_status(:bad_request)
  end
  
end


describe 'POST #create' do
context 'with valid parameters' do
  it 'creates a new product' do
    expect {
      post :create, params: { name: 'New Product', category: 'Electronics', available: 10 }
    }.to change(Product, :count).by(1)
  end

  it 'returns a success response' do
    post :create, params: { name: 'New Product', category: 'Electronics', available: 10 }
    expect(response).to have_http_status(:ok)
  end
end

context 'with invalid parameters' do
  it 'does not create a new product' do
    expect {
      post :create, params: { name: '', category: '', available: -1 }
    }.to_not change(Product, :count)
  end

  it 'returns a bad request response' do
    post :create, params: { name: '', category: '', available: -1 }
    expect(response).to have_http_status(:bad_request)
  end
end

end





end
