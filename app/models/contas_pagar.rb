class ContasPagar < ApplicationRecord
  belongs_to :fornecedores
  belongs_to :plano_contas
end
