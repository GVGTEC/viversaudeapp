class CreateEstoques < ActiveRecord::Migration[5.2]
  def change
    create_table :estoques do |t|
      t.references :produto, foreign_key: true
      t.string :lote
      t.decimal :estoque_atual
      t.decimal :estoque_minimo
      t.decimal :estoque_reservado

      t.timestamps
    end
  end
end
