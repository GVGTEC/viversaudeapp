class CreateCfop < ActiveRecord::Migration[5.2]
  def change
    create_table :cfop do |t|
      t.references :empresa, foreign_key: true
      t.string :codigo
      t.string :informativo
      t.string :descricao
      t.string :natureza_operacao
      t.string :natureza_operacao_st
      t.string :operacao
      t.string :nota_complementar_impostos_sn
      t.string :entrada_saida_es
      t.string :cliente_fornecedor_cf
      t.string :calcular_impostos_sn
      t.string :faturamento_sn
      t.string :arquivo_mensagem
      t.text :observacao

      t.timestamps
    end
  end
end
