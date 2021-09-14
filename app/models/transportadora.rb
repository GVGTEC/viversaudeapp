class Transportadora < ApplicationRecord
  belongs_to :empresa

  def contatos
    Contato.where(natureza: "transportadoras", natureza_id: self.id)
  rescue
    []
  end
end
