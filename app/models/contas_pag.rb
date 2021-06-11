class ContasPag < ApplicationRecord
  belongs_to :fornecedores
  belongs_to :plano_contas
end
