json.extract! vendedor, :id, :nome, :pessoa, :cpf, :rg, :cnpj, :ie, :endereco, :bairro, :cidade, :cep, :uf, :telefone,
              :email, :created_at, :updated_at
json.url vendedor_url(vendedor, format: :json)
