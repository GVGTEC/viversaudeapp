class NotaFiscalItemLote < ApplicationRecord
  belongs_to :nota_fiscal_item
  belongs_to :estoque
end
