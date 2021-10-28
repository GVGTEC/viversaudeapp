class Estoque::Ajuste < ApplicationRecord
  def movimentacao_em_estoque
    movimento_estoque = MovimentoEstoque.new
    movimento_estoque.estoque_id = id
    movimento_estoque.origem = ultima_alteracao
    movimento_estoque.data = updated_at
    movimento_estoque.qtd = estoque_atual_lote
    movimento_estoque.estoque_inicial = produto.estoque_atual - estoque_atual_lote rescue 0
    movimento_estoque.estoque_final = produto.estoque_atual
    movimento_estoque.preco_custo = preco_custo_reposicao
    movimento_estoque.save
  end
end
