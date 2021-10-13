json.extract! contas_pagar, :id, :fornecedores_id, :plano_contas_id, :documento, :historico, :data_emissao,
              :valor_total, :created_at, :updated_at
json.url contas_pagar_url(contas_pagar, format: :json)
