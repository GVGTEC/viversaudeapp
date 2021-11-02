class Estoques::AjustesController < ApplicationController
  before_action :set_estoque, only: %i[create]

  # GET /administradores/new
  def new
    @estoque = Estoque.new
  end

  # POST /administradores or /administradores.json
  def create
    estoque_atual_lote = @estoque.estoque_atual_lote
    qtd_estoque_final = (@estoque.produto.estoque_atual - @estoque.estoque_atual_lote) + estoque_params[:estoque_atual_lote].to_f
    @estoque.estoque_atual_lote = estoque_params[:estoque_atual_lote]
    @estoque.ultima_alteracao = Estoque::AJUSTE

    respond_to do |format|
      if @estoque.save
        @estoque.atualizar_produto_ajuste(qtd_estoque_final)

        salve_movimento_estoque(estoque_atual_lote)
        format.html { redirect_to estoques_path, notice: 'Estoque Ajustado' }
        format.json { render :show, status: :created, location: @estoque }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @estoque.errors, status: :unprocessable_entity }
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
    movimento_estoque.qtd = 0
    movimento_estoque.estoque_inicial = estoque_atual_lote
    movimento_estoque.estoque_final = @estoque.estoque_atual_lote
    movimento_estoque.preco_custo = @estoque.produto.preco_custo
    movimento_estoque.save
  end

  # Only allow a list of trusted parameters through.
  def estoque_params
    params.require(:estoque).permit(:produto_id, :fornecedor_id, :lote, :documento, :ultima_alteracao, :estoque_atual_lote, :data_reposicao, :data_validade, :estoque_reservado, :preco_custo_reposicao)
  end
end
