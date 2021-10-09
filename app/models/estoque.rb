class Estoque < ApplicationRecord
  belongs_to :produto
  belongs_to :fornecedor, optional: true
  belongs_to :empresa

  def movimentacao_em_estoque
    movimento_estoque = MovimentoEstoque.new
    movimento_estoque.estoque_id = id
    movimento_estoque.origem = ultima_alteracao
    movimento_estoque.data = updated_at
    movimento_estoque.qtd = estoque_atual_lote
    movimento_estoque.estoque_inicial = begin
      produto.estoque_atual - estoque_atual_lote
    rescue
      0
    end
    movimento_estoque.estoque_final = produto.estoque_atual
    movimento_estoque.preco_custo = preco_custo_reposicao
    movimento_estoque.save
  end

  def calculo_preco_custo_medio
    produto = self.produto
    relacao_estoque_atual = begin
      produto.estoque_atual * produto.preco_custo
    rescue
      0
    end
    relacao_estoque_reposicao = begin
      estoque_atual_lote * preco_custo_reposicao.to_i
    rescue
      0
    end
    qtd_total_estoque = produto.estoque_atual + estoque_atual_lote
    qtd_relacao = relacao_estoque_atual + relacao_estoque_reposicao

    preco_custo_medio = begin
      qtd_relacao / qtd_total_estoque
    rescue
      0
    end
    preco_custo_medio.ceil(2)
  end
end
