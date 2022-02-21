class CreateOrcamentos < ActiveRecord::Migration[5.2]
  def change
    create_table :orcamentos do |t|
      t.references :cliente, foreign_key: true
      t.references :vendedor, foreign_key: true
      t.datetime :data_emissao
      t.float :valor_total
      t.text :observacao
      t.string :flag

      t.timestamps
    end
  end
end
