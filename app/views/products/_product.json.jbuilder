json.extract! product, :id, :name, :category, :available, :created_at, :updated_at
json.url product_url(product, format: :json)
