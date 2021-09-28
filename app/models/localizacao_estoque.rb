class LocalizacaoEstoque < ApplicationRecord
  has_many :produtos, dependent: :destroy
  belongs_to :empresa
end
