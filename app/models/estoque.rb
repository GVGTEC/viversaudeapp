class Estoque < ApplicationRecord
  belongs_to :produto
  belongs_to :fornecedor
end
