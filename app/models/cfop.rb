class Cfop < ApplicationRecord
  belongs_to :empresa

  has_many :nota_fiscais, dependent: :delete_all
end
