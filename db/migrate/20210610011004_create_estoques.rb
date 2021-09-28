class CreateEstoques < ActiveRecord::Migration[5.2]
  def change
    create_table :estoques do |t|
      t.references :produto, foreign_key: true
      t.references :fornecedor, foreign_key: true
      t.string :codprd_sac
      t.string :lote
      t.string :documento
      t.string :ultima_alteracao
      t.date :data_reposicao
      t.date :data_validade
      t.float :estoque_atual_lote
      t.float :estoque_reservado
      t.float :preco_custo_reposicao

      t.timestamps
    end
  end
end
