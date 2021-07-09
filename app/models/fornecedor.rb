class Fornecedor < ApplicationRecord
  has_many :produtos, dependent: :destroy
  
  def contatos
    Contato.where(natureza: "fornecedores", natureza_id: self.id)
  rescue
    []
  end
end
