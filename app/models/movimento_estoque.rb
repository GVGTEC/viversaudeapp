class MovimentoEstoque < ApplicationRecord
  belongs_to :estoque
  belongs_to :produto
  belongs_to :empresa
  belongs_to :nota_fiscal, optional: true

  def self.novo_movimento(estoque)
    movimento_estoque = new(
      estoque_id: estoque.id,
      produto_id: estoque.produto_id,
      origem: estoque.ultima_alteracao,
      data: estoque.updated_at,
      qtd: estoque.estoque_atual_lote,
      estoque_inicial: 0,
      estoque_final: estoque.estoque_atual_lote,
      preco_custo: estoque.preco_custo_reposicao
    )
    
    movimento_estoque.save
  end
end
