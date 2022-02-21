class RemoveLoteToNotaFiscalItemLote < ActiveRecord::Migration[5.2]
  def change
    remove_column :nota_fiscal_item_lotes, :lote, :string
  end
end
