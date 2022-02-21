class CreateNotaFiscalItemLotes < ActiveRecord::Migration[5.2]
  def change
    create_table :nota_fiscal_item_lotes do |t|
      t.references :nota_fiscal_item, foreign_key: true
      t.string :lote
      t.float :estoque_inicial
      t.float :estoque_final

      t.timestamps
    end
  end
end
