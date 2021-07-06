class CreateContasPagarParcelas < ActiveRecord::Migration[5.2]
  def change
    create_table :contas_pagar_parcelas do |t|
      t.references :contas_pag, foreign_key: true
      t.datetime :data_vencimento
      t.datetime :data_pagamento
      t.float :valor_parcela
      t.float :valor_juros_desconto
      t.string :documento
      t.string :descricao

      t.timestamps
    end
  end
end
