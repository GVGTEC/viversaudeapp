class Terceiro < ApplicationRecord
  has_many :clientes, dependent: :destroy
  belongs_to :empresa
end
