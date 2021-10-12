json.extract! contas_rec, :id, :cliente_id, :plano_conta_id, :documento, :historico, :data_emissao, :valor_total,
              :created_at, :updated_at
json.url contas_rec_url(contas_rec, format: :json)
