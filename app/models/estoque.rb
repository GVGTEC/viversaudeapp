class Estoque < ApplicationRecord
  belongs_to :produto
  belongs_to :fornecedor
  belongs_to :empresa

  def movimentacao_em_estoque
    movimento_estoque = MovimentoEstoque.new
    movimento_estoque.estoque_id = self.id
    movimento_estoque.origem = self.ultima_alteracao
    movimento_estoque.data = self.updated_at
    movimento_estoque.qtd = self.estoque_atual_lote
    movimento_estoque.estoque_inicial = self.produto.estoque_atual - self.estoque_atual_lote rescue 0
    movimento_estoque.estoque_final = self.produto.estoque_atual
    movimento_estoque.preco_custo = self.preco_custo_reposicao
    movimento_estoque.save
  end

  def calculo_preco_custo_medio
    produto = self.produto
    relacao_estoque_atual =  produto.estoque_atual * produto.preco_custo rescue 0
    relacao_estoque_reposicao =  self.estoque_atual_lote * self.preco_custo_reposicao.to_i rescue 0
    qtd_total_estoque = produto.estoque_atual + self.estoque_atual_lote
    qtd_relacao = relacao_estoque_atual + relacao_estoque_reposicao
    
    preco_custo_medio = qtd_relacao / qtd_total_estoque rescue 0
    return preco_custo_medio.ceil(2)
  end
end
