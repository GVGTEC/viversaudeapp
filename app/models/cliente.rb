class Cliente < ApplicationRecord
  belongs_to :empresa
  has_many :contatos, class_name: "ClienteContato", dependent: :delete_all

  default_scope { order('nome asc') }
end
