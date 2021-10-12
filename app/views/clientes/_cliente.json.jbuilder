json.extract! cliente, :id, :nome, :pessoa, :cpf, :rg, :cnpj, :ie, :endereco, :bairro, :cidade, :cep, :uf, :email,
              :codcidade_ibge, :created_at, :updated_at
json.url cliente_url(cliente, format: :json)
