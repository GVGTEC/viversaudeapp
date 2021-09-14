class CreateNotaFiscais < ActiveRecord::Migration[5.2]
  def change
    create_table :nota_fiscais do |t|
      t.references :empresa, foreign_key: true
      t.integer :codnot_sac
      t.integer :numero_nota
      t.integer :numero_pedido
      t.references :cfop, foreign_key: true
      t.string :entsai
      t.references :cliente, foreign_key: true
      t.references :fornecedor, foreign_key: true
      t.references :vendedor, foreign_key: true
      t.references :transportadora, foreign_key: true
      t.datetime :data_emissao
      t.datetime :data_saida
      t.string :hora_saida
      t.float :valor_desconto
      t.float :valor_produtos
      t.float :valor_total_nota
      t.float :valor_frete
      t.float :valor_outras_despesas
      t.string :numero_pedido_compra
      t.string :tipo_pagamento
      t.integer :meio_pagamento
      t.integer :numero_parcelas_pagamento
      t.text :observacao
      t.string :chave_acesso_nfe
      t.string :nota_cancelada_sn
      t.string :distancia_parcelas

      t.timestamps
    end
  end
end
