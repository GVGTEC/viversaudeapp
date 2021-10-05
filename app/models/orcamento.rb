class Orcamento < ApplicationRecord
  belongs_to :cliente
  belongs_to :vendedor

  has_many :orcamento_itens, dependent: :destroy
end
