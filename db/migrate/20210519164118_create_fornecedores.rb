class CreateFornecedores < ActiveRecord::Migration[5.2]
  def change
    create_table :fornecedores do |t|
      t.integer :codfor_sac
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
      t.string :telefone_alternativo 
      t.string :telefone_nf          
      t.string :email
      t.string :codcidade_ibge

      t.timestamps
    end
  end
end
