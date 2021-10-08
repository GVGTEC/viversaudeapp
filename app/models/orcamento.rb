class Orcamento < ApplicationRecord
  belongs_to :cliente
  belongs_to :vendedor
  belongs_to :empresa

  has_many :orcamento_itens, dependent: :destroy
end
