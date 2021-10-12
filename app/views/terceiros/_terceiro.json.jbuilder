json.extract! terceiro, :id, :nome, :pessoa, :cpf, :rg, :cnpj, :ie, :endereco, :bairro, :cidade, :cep, :uf, :telefone,
              :email, :created_at, :updated_at
json.url terceiro_url(terceiro, format: :json)
