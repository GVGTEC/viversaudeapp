class NotaFiscalTransporta < ApplicationRecord
  belongs_to :nota_fiscal
  belongs_to :transportadora
end
