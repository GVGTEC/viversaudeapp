class CreateFornecedorContatos < ActiveRecord::Migration[5.2]
  def change
    create_table :fornecedor_contatos do |t|
      t.references :fornecedor, foreign_key: true
      t.string :nome
      t.string :telefone
      t.string :email
      t.string :cargo
      t.string :departamento      

      t.timestamps
    end
  end
end
