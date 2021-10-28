class AddQtdToNotaFiscalItemLote < ActiveRecord::Migration[5.2]
  def change
    add_column :nota_fiscal_item_lotes, :qtd, :float
  end
end
