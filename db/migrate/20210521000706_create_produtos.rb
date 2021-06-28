class CreateProdutos < ActiveRecord::Migration[5.2]
  def change
    create_table :produtos do |t|
      t.references :localizacao_estoque, foreign_key: true
      t.boolean :situacao
      t.datetime :data_inativo
      t.string :descricao
      t.string :descricao_nfe
      t.string :codigo_barras
      t.string :ncm
      t.string :situacao_tributaria
      t.string :unidade
      t.decimal :embalagem
      t.boolean :controlar_estoque
      t.boolean :por_lote
      t.boolean :bloquear_preco
      t.datetime :data_ultima_reposicao
      t.datetime :data_ultimo_reajuste
      t.decimal :preco_custo
      t.decimal :preco_custo_medio
      t.decimal :margem_lucro
      t.decimal :preco_venda
      t.decimal :preco_oferta
      t.decimal :margem_lucro_oferta
      t.datetime :data_inicial_oferta
      t.datetime :data_final_oferta
      t.decimal :comissao_pc
      t.decimal :estoque_atual
      t.decimal :estoque_minimo

      t.timestamps
    end
  end
end
