class Product < ApplicationRecord
    validates :name, uniqueness: { case_sensitive: false }
    validates :available, numericality: { greater_than: 0 }
end
