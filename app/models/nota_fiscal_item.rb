class NotaFiscalItem < ApplicationRecord
  belongs_to :nota_fiscal
  belongs_to :produto
end
