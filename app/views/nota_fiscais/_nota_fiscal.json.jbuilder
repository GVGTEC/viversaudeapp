json.extract! nota_fiscal, :id, :numero_nota, :numero_pedido, :cfop_id, :entsai, :cliente_id, :fornecedor_id,
              :vendedor_id, :data_emissao, :data_saida, :hora_saida, :valor_desconto, :valor_produtos, :valor_total_nota, :valor_frete, :valor_outras_despesas, :numero_pedido_compra, :tipo_pagamento, :meio_pagamento, :numero_parcelas_pagamento, :observacao, :chave_acesso_nfe, :nota_cancelada_sn, :created_at, :updated_at
json.url nota_fiscal_url(nota_fiscal, format: :json)
