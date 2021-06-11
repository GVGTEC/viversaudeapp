class CreateContasPagar < ActiveRecord::Migration[5.2]
  def change
    create_table :contas_pagar do |t|
      t.references :fornecedores, foreign_key: true
      t.references :plano_contas, foreign_key: true
      t.string :documento
      t.string :historico
      t.datetime :data_emissao
      t.decimal :valor_total

      t.timestamps
    end
  end
end
