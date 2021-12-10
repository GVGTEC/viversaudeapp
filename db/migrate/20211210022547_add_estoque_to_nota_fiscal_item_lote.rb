class AddEstoqueToNotaFiscalItemLote < ActiveRecord::Migration[5.2]
  def change
    add_reference :nota_fiscal_item_lotes, :estoque, foreign_key: true
  end
end
