class ContasPag < ApplicationRecord
  belongs_to :fornecedor
  belongs_to :plano_conta
  belongs_to :empresa

  has_many :contas_pagar_parcelas, :dependent => :delete_all
end
