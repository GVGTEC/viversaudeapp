class CreateEstoques < ActiveRecord::Migration[5.2]
  def change
    create_table :estoques do |t|
      t.references :produto, foreign_key: true
      t.references :fornecedor, foreign_key: true
      t.string :lote
      t.string :documento
      t.date :data_reposicao
      t.date :data_validade
      t.decimal :estoque_atual_lote
      t.decimal :estoque_reservado

      t.timestamps
    end
  end
end
