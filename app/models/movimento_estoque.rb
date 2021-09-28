class MovimentoEstoque < ApplicationRecord
  belongs_to :estoque

  def self.novo_movimento(estoque)
    movimento_estoque = MovimentoEstoque.new
    movimento_estoque.estoque_id = estoque.id
    movimento_estoque.produto_id = estoque.produto_id
    movimento_estoque.origem = estoque.ultima_alteracao
    movimento_estoque.data = estoque.updated_at
    movimento_estoque.qtd = estoque.estoque_atual_lote
    movimento_estoque.estoque_inicial = 0
    movimento_estoque.estoque_final = estoque.estoque_atual_lote
    movimento_estoque.preco_custo = estoque.preco_custo_reposicao
    movimento_estoque.save
  end
end
