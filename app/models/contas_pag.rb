class ContasPag < ApplicationRecord
  belongs_to :fornecedor
  belongs_to :plano_conta

  has_many :contas_pagar_parcelas, :dependent => :delete_all
end
