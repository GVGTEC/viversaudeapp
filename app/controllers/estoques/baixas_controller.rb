class Estoques::BaixasController < ApplicationController
  before_action :set_estoque, only: %i[create]

  # GET /administradores/new
  def new
    @estoque = Estoque.new
  end

  # POST /administradores or /administradores.json
  def create
    estoque_atual_lote = @estoque.estoque_atual_lote
    @estoque.estoque_atual_lote = estoque_atual_lote - params[:qtd_baixa].to_f
    @estoque.ultima_alteracao = Estoque::BAIXA 

    respond_to do |format|
      if @estoque.save
        @estoque.atualizar_produto_baixas(params)
        salve_movimento_estoque(estoque_atual_lote)
        format.html { redirect_to estoques_path, notice: 'Estoque baixado com sucesso' }
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
    movimento_estoque = MovimentoEstoque.new
    movimento_estoque.estoque_id = @estoque.id
    movimento_estoque.produto_id = @estoque.produto_id
    movimento_estoque.origem = @estoque.ultima_alteracao
    movimento_estoque.data = @estoque.updated_at
    movimento_estoque.estoque_inicial = estoque_atual_lote
    movimento_estoque.qtd = params[:qtd_baixa].to_f
    movimento_estoque.estoque_final = @estoque.estoque_atual_lote
    movimento_estoque.preco_custo = @estoque.produto.preco_custo
    movimento_estoque.save
  end

  # Only allow a list of trusted parameters through.
  def estoque_params
    params.require(:estoque).permit(:produto_id, :fornecedor_id, :lote, :documento, :ultima_alteracao, :estoque_atual_lote, :data_reposicao, :data_validade, :estoque_reservado, :preco_custo_reposicao)
  end
end
