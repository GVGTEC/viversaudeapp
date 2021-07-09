class Terceiro < ApplicationRecord
  has_many :clientes, dependent: :destroy
end
