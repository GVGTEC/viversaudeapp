class Cliente < ApplicationRecord
  belongs_to :empresa
  default_scope{ order("nome asc")}

  def contatos
    Contato.where(natureza: "clientes", natureza_id: self.id)
  rescue
    []
  end
end
