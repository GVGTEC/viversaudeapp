class Produto < ApplicationRecord
  belongs_to :empresa
  belongs_to :fornecedor
end
