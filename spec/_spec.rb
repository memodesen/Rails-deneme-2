# spec/_spec.rb
require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :controller do

  describe "GET #index" do
    it "returns a successful response" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "returns all products" do
      products = [Product.new(id: 1, name: "Product 1"), Product.new(id: 2, name: "Product 2"), Product.new(id: 3, name: "Product 3")]
      allow(Product).to receive(:all).and_return(products) 
      get :index
      expect(assigns(:products)).to eq(products)
    end
  end

  describe "GET #show" do
    it "returns a successful response" do
      product = Product.new(id: 1, name: "Sample Product")
      allow(Product).to receive(:find).with("1").and_return(product) 
      get :show, params: { id: 1 }
      expect(response).to have_http_status(:success)
    end

    it "returns the requested product" do
      product = Product.new(id: 1, name: "Sample Product")
      allow(Product).to receive(:find).with("1").and_return(product) 
      get :show, params: { 
        id: 1 
      }
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




end
