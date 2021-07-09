class Produto < ApplicationRecord
  belongs_to :localizacao_estoque, optional: true
  belongs_to :fornecedor, optional: true


  def self.atualizar_produto_reposto(estoque, params)
    produto = estoque.produto
    produto.preco_custo_medio = estoque.calculo_preco_custo_medio
    produto.estoque_atual += estoque.estoque_atual_lote
    produto.preco_custo = estoque.preco_custo_reposicao
    produto.preco_venda = params[:preco_venda]
    produto.save
  end
end
