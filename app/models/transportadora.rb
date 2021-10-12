class Transportadora < ApplicationRecord
  belongs_to :empresa

  def contatos
    Contato.where(natureza: 'transportadoras', natureza_id: id)
  rescue StandardError
    []
  end
end
