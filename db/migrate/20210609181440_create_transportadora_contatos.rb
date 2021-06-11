class CreateTransportadoraContatos < ActiveRecord::Migration[5.2]
  def change
    create_table :transportadora_contatos do |t|
      t.references :transportadora, foreign_key: true
      t.string :nome
      t.string :telefone
      t.string :email

      t.timestamps
    end
  end
end
