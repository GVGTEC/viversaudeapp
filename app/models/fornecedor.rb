class Fornecedor < ApplicationRecord
  has_many :produtos, dependent: :destroy
  belongs_to :empresa
  
  def contatos
    Contato.where(natureza: "fornecedores", natureza_id: self.id)
  rescue
    []
  end
end
