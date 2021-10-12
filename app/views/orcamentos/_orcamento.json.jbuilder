json.extract! orcamento, :id, :cliente_id, :vendedor_id, :data_emissao, :valor_total, :observacao, :flag, :created_at,
              :updated_at
json.url orcamento_url(orcamento, format: :json)
