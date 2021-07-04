class NotaFiscal < ApplicationRecord
  belongs_to :cfop
  belongs_to :cliente
  belongs_to :fornecedor
  belongs_to :vendedor
end
