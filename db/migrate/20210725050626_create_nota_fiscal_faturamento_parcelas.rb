class CreateNotaFiscalFaturamentoParcelas < ActiveRecord::Migration[5.2]
  def change
    create_table :nota_fiscal_faturamento_parcelas do |t|
      t.references :nota_fiscal, foreign_key: true
      t.string :duplicata
      t.integer :prazo_pagamento
      t.datetime :data_vencimento
      t.float :valor_parcela

      t.timestamps
    end
  end
end
