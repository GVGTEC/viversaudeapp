class Fornecedor < ApplicationRecord
  has_many :produtos, dependent: :destroy
  belongs_to :empresa

  def contatos
    Contato.where(natureza: 'fornecedores', natureza_id: id)
  rescue StandardError
    []
  end
end
