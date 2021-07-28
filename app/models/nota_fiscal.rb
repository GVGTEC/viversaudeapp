class NotaFiscal < ApplicationRecord
  belongs_to :cfop, optional: true
  belongs_to :cliente, optional: true
  belongs_to :fornecedor, optional: true
  belongs_to :vendedor, optional: true
  belongs_to :transportadora, optional: true

  has_many :nota_fiscal_itens, :dependent => :delete_all
  has_many :nota_fiscal_faturamento_parcelas, :dependent => :delete_all
end
