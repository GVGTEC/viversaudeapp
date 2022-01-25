class Estoques::BaixasController < ApplicationController
  before_action :set_estoque, only: %i[create]

  def new
    @estoque = Estoque.new
  end

  def create
    estoque_atual_lote = @estoque.estoque_atual_lote
    @estoque.estoque_atual_lote = estoque_atual_lote - params[:qtd_baixa].to_f
    @estoque.ultima_alteracao = Estoque::BAIXA 

    respond_to do |format|
      if @estoque.save
        @estoque.atualizar_produto_baixas(params)
        salve_movimento_estoque(estoque_atual_lote)
        format.html { redirect_to estoques_path, notice: 'Estoque baixado com Sucesso' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_estoque
    @estoque = Estoque.find(params[:estoque][:id])
  end

  def salve_movimento_estoque(estoque_atual_lote)
    movimento_estoque = MovimentoEstoque.new(
      estoque_id: @estoque.id,
      produto_id: @estoque.produto_id,
      origem: @estoque.ultima_alteracao,
      data: @estoque.updated_at,
      estoque_inicial: estoque_atual_lote,
      qtd: params[:qtd_baixa].to_f,
      estoque_final: @estoque.estoque_atual_lote,
      preco_custo: @estoque.produto.preco_custo,
      empresa_id: @estoque.empresa_id
    )
    
    movimento_estoque.save
  end

  # Only allow a list of trusted parameters through.
  def estoque_params
    params.require(:estoque).permit(:produto_id, :fornecedor_id, :lote, :documento, :ultima_alteracao, :estoque_atual_lote, :data_reposicao, :data_validade, :estoque_reservado, :preco_custo_reposicao)
  end
end
