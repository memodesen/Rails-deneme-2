module Api
    module V1
      class ProductsController < ApplicationController

        before_action :set_product, only: %i[ show edit update destroy ]

        skip_before_action :verify_authenticity_token, only: [:destroy, :create, :update]
        #I made skip_before_action to get results in Postman. Otherwise, I can't get results because of CSRF protection.
        #If you want,you can delete.

        #I deleted the product which has id=1 in Postman.

        def index
          @products = Product.all
          render json:@products 
        end

        def show
          render json:@product
        end

        def buy
          product_id = params[:product_id]
          quantity = params[:quantity]
          @product = Product.find(product_id)
        
          if @product.available >= quantity.to_i
            @product.available = @product.available - quantity.to_i
            @product.save
            render json: @product
          else
            render json: { message: "Invalid number" , status: :bad_request}
          end
        end

  

        def create
          @product = Product.new(product_params)
          if @product.save
            render json: @product, status: :ok
          else
            render json: {message:"Product is not saved", status: :bad_request}
          end
        end

        def destroy
          @product.destroy
          render json: {message:"Product is destroyed"}
        end

        def update
         if @product.update(product_params)
           render json: @product , status: :ok
          else
           render json:{message:"Product is not updated" , status: :bad_request}
          end       
        end

        
        private

        def set_product
          @product = Product.find(params[:id])
        end


        def product_params
          params.permit(:name,:category,:available)
        end
        
      end
    end
  end
  