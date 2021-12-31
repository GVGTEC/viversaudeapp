class ContasRec < ApplicationRecord
  belongs_to :cliente
  belongs_to :plano_conta, optional: true
  belongs_to :empresa

  has_many :contas_rec_parcelas, dependent: :delete_all
end
