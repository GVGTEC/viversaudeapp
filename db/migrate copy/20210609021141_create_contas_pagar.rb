class CreateContasPagar < ActiveRecord::Migration[5.2]
  def change
    create_table :contas_pag do |t|
      t.references :empresa, foreign_key: true
      t.references :fornecedor, foreign_key: true
      t.references :plano_conta, foreign_key: true
      t.string :documento
      t.string :historico
      t.datetime :data_emissao
      t.float :valor_total

      t.timestamps
    end
  end
end
