class Vendedor < ApplicationRecord
  has_many :clientes, dependent: :destroy
end
