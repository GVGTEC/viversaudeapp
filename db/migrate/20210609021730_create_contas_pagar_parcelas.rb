class CreateContasPagarParcelas < ActiveRecord::Migration[5.2]
  def change
    create_table :contas_pagar_parcelas do |t|
      t.references :contas_pagar, foreign_key: true
      t.datetime :data_vencimento
      t.datetime :data_pagamento
      t.decimal :valor_parcela
      t.decimal :valor_juros_desconto
      t.string :documento
      t.string :descricao

      t.timestamps
    end
  end
end
