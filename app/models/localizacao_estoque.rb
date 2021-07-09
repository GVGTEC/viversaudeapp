class LocalizacaoEstoque < ApplicationRecord
  has_many :produtos, dependent: :destroy
end
