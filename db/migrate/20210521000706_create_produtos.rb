class CreateProdutos < ActiveRecord::Migration[5.2]
  def change
    create_table :produtos do |t|
      t.references :localizacao_estoque, foreign_key: true
      t.references :fornecedor, foreign_key: true
      t.boolean :situacao
      t.datetime :data_inativo
      t.string :descricao
      t.string :descricao_nfe
      t.string :codigo_barras
      t.string :ncm
      t.string :situacao_tributaria
      t.string :unidade
      t.string :cod_fabricante
      t.float :embalagem, default: 0
      t.boolean :controlar_estoque
      t.boolean :por_lote
      t.boolean :bloquear_preco
      t.datetime :data_ultima_reposicao
      t.datetime :data_ultimo_reajuste
      t.float :preco_custo, default: 0
      t.float :preco_custo_medio, default: 0
      t.float :margem_lucro, default: 0
      t.float :preco_venda, default: 0
      t.float :preco_oferta, default: 0
      t.float :margem_lucro_oferta, default: 0
      t.datetime :data_inicial_oferta
      t.datetime :data_final_oferta
      t.float :comissao_pc, default: 0
      t.float :estoque_atual, default: 0
      t.float :estoque_minimo, default: 0

      t.timestamps
    end
  end
end
