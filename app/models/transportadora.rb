class Transportadora < ApplicationRecord

  def contatos
    Contato.where(natureza: "transportadoras", natureza_id: self.id)
  rescue
    []
  end
end
