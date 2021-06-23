json.extract! estoque, :id, :produto_id, :lote, :estoque_atual, :estoque_minimo, :estoque_reservado, :created_at, :updated_at
json.url estoque_url(estoque, format: :json)
