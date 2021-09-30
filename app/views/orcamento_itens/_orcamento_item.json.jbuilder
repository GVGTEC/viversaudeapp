json.extract! orcamento_item, :id, :orcamento_id, :produto_id, :quantidade, :preco_unitario, :preco_total, :created_at, :updated_at
json.url orcamento_item_url(orcamento_item, format: :json)
