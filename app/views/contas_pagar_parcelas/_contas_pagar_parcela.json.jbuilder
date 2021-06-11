json.extract! contas_pagar_parcela, :id, :contas_pagar_id, :data_vencimento, :data_pagamento, :valor_parcela, :valor_juros_desconto, :documento, :descricao, :created_at, :updated_at
json.url contas_pagar_parcela_url(contas_pagar_parcela, format: :json)
