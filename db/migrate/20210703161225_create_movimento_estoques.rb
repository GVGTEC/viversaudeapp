class CreateMovimentoEstoques < ActiveRecord::Migration[5.2]
  def change
    create_table :movimento_estoques do |t|
      t.references :estoque, foreign_key: true
      t.string :origem
      t.date :data
      t.float :qtd
      t.float :estoque_inicial
      t.float :estoque_final
      t.float :preco_custo

      t.timestamps
    end
  end
end
