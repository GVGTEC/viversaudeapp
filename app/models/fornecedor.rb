class Fornecedor < ApplicationRecord

  def contatos
    Contato.where(natureza: "fornecedores", natureza_id: self.id)
  rescue
    []
  end
end
