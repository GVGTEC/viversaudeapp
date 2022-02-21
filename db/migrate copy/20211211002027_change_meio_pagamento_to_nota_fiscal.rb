class ChangeMeioPagamentoToNotaFiscal < ActiveRecord::Migration[5.2]
  def change
    change_column :nota_fiscais, :meio_pagamento, :string
  end
end
