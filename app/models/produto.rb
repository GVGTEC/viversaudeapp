class Produto < ApplicationRecord
  belongs_to :localizacao_estoque, optional: true
end
