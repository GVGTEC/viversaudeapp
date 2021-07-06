class Cliente < ApplicationRecord
  default_scope{ order("nome asc")}

  def contatos
    Contato.where(natureza: "clientes", natureza_id: self.id)
  rescue
    []
  end
end
