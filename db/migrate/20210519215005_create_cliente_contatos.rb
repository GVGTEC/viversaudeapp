class CreateClienteContatos < ActiveRecord::Migration[5.2]
  def change
    create_table :cliente_contatos do |t|
      t.references :cliente, foreign_key: true
      t.string :nome
      t.string :telefone
      t.string :email

      t.timestamps
    end
  end
end
