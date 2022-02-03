class Cliente < ApplicationRecord
  belongs_to :empresa
  default_scope { order('nome asc') }

  def contatos
    Contato.where(natureza: 'clientes', natureza_id: id)
  rescue StandardError
    []
  end

  has_many :cliente_contatos, dependent: :delete_all
end
