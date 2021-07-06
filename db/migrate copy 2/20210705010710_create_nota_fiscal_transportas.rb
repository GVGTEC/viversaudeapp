class CreateNotaFiscalTransportas < ActiveRecord::Migration[5.2]
  def change
    create_table :nota_fiscal_transportas do |t|
      t.references :nota_fiscal, foreign_key: true
      t.references :transportadora, foreign_key: true
      t.integer :paga_frete
      t.string :numero_coleta
      t.datetime :data_coleta
      t.string :hora_coleta
      t.string :quantidade
      t.string :especie
      t.string :marca
      t.string :numero
      t.string :peso_liquido
      t.string :peso_bruto
      t.string :placa_veiculo
      t.string :estado_veiculo

      t.timestamps
    end
  end
end
