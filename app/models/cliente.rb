class Cliente < ApplicationRecord

  def contatos
    Contato.where(natureza: "clientes", natureza_id: self.id)
  rescue
    []
  end
end
