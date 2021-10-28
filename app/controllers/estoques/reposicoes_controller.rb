class Estoques::ReposicoesController < ApplicationController
  # GET /estoques/reposicoes/new
  def new
    params[:data_reposicao] ||= Time.zone.now.strftime('%Y-%m-%d')

    @estoque = Estoque.new
    @estoque.fornecedor_id = params[:fornecedor_id] if params[:fornecedor_id].present?
    @estoque.documento = params[:documento] if params[:documento].present?
    @estoque.data_reposicao = params[:data_reposicao]
  end

  # POST /estoques/reposicoes
  def create
    @estoque = Estoque.new(estoque_params)
    @estoque.ultima_alteracao = 'REP'
    @estoque.empresa_id = @adm.empresa.id
    
    respond_to do |format|
      if @estoque.save
        @estoque.atualizar_produto_reposicao(params)
        salve_movimento_estoque

        path_with_params = "/estoques/reposicoes/new?fornecedor_id=#{@estoque.fornecedor_id}&documento=#{@estoque.documento}&data_reposicao=#{@estoque.data_reposicao}"
        format.html { redirect_to path_with_params, notice: "Reposição do Produto #{@estoque.produto.descricao} feita com sucesso." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def salve_movimento_estoque
    movimento_estoque = MovimentoEstoque.new
    movimento_estoque.estoque_id = @estoque.id
    movimento_estoque.produto_id = @estoque.produto_id
    movimento_estoque.origem = @estoque.ultima_alteracao
    movimento_estoque.data = @estoque.updated_at
    movimento_estoque.qtd = @estoque.estoque_atual_lote
    movimento_estoque.estoque_inicial = 0
    movimento_estoque.estoque_final = @estoque.estoque_atual_lote
    movimento_estoque.preco_custo = @estoque.preco_custo_reposicao
    movimento_estoque.save
  end

  # Only allow a list of trusted parameters through.
  def estoque_params
    params.require(:estoque).permit(:produto_id, :fornecedor_id, :lote, :documento, :ultima_alteracao, :estoque_atual_lote, :data_reposicao, :data_validade, :estoque_reservado, :preco_custo_reposicao)
  end
end
