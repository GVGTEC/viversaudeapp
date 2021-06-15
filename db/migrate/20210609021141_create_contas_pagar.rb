class CreateContasPagar < ActiveRecord::Migration[5.2]
  def change
    create_table :contas_pag do |t|
      t.references :fornecedor, foreign_key: true
      t.references :plano_conta, foreign_key: true
      t.string :documento
      t.string :historico
      t.datetime :data_emissao
      t.decimal :valor_total

      t.timestamps
    end
  end
end
