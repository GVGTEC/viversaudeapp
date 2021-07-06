class CreateContatos < ActiveRecord::Migration[5.2]
  def change
    create_table :contatos do |t|
      t.string :nome
      t.string :email
      t.string :telefone
      t.string :natureza
      t.bigint :natureza_id

      t.timestamps
    end
  end
end
