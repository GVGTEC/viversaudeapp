json.extract! fornecedor, :id, :nome, :pessoa, :cpf, :rg, :cnpj, :ie, :endereco, :bairro, :cidade, :cep, :uf, :email,
              :created_at, :updated_at
json.url fornecedor_url(fornecedor, format: :json)
