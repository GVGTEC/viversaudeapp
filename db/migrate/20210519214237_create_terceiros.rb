class CreateTerceiros < ActiveRecord::Migration[5.2]
  def change
    create_table :terceiros do |t|
      t.string :nome
      t.string :pessoa
      t.string :cpf
      t.string :rg
      t.string :cnpj
      t.string :ie
      t.string :endereco
      t.string :bairro
      t.string :cidade
      t.string :cep
      t.string :uf
      t.string :telefone
      t.string :email

      t.timestamps
    end
  end
end
