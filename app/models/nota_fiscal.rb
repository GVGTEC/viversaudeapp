class NotaFiscal < ApplicationRecord
  validates :transportadora_id, presence: true

  belongs_to :cfop, optional: true
  belongs_to :cliente, optional: true
  belongs_to :fornecedor, optional: true
  belongs_to :vendedor, optional: true
  belongs_to :transportadora, optional: true
  belongs_to :empresa

  before_validation :salvar_empresa

  has_one :nota_fiscal_transporta, dependent: :destroy
  has_one :nota_fiscal_imposto, dependent: :destroy
  has_many :nota_fiscal_itens, dependent: :delete_all
  has_many :nota_fiscal_faturamento_parcelas, dependent: :delete_all
end
