class CreateTransportadoras < ActiveRecord::Migration[5.2]
  def change
    create_table :transportadoras do |t|
      t.string :nome
      t.string :cnpj
      t.string :ie
      t.string :endereco
      t.string :bairro
      t.string :cidade
      t.string :cep
      t.string :uf

      t.timestamps
    end
  end
end
