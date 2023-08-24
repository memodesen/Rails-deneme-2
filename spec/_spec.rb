# spec/_spec.rb
require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :controller do
  describe "GET #index" do
    it "returns a successful response" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "returns all products" do
      products = FactoryBot.create_list(:product, 3) # Using FactoryBot.create_list
      get :index
      expect(assigns(:products)).to match_array(products)
    end
  end
end
