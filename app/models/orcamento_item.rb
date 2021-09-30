class OrcamentoItem < ApplicationRecord
  belongs_to :orcamento
  belongs_to :produto
end
