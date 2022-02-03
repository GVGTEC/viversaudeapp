json.extract! cliente_contato, :id, :cliente_id, :nome, :telefone, :email, :cargo, :departamento, :created_at, :updated_at
json.url cliente_contato_url(cliente_contato, format: :json)
