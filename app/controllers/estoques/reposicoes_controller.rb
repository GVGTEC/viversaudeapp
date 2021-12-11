class Estoques::ReposicoesController < ApplicationController
  def new
    params[:data_reposicao] ||= Time.zone.now.strftime('%Y-%m-%d')

    @estoque = Estoque.new
    @estoque.fornecedor_id = params[:fornecedor_id] if params[:fornecedor_id].present?
    @estoque.documento = params[:documento] if params[:documento].present?
    @estoque.data_reposicao = params[:data_reposicao]
  end

  def create
    @estoque = Estoque.new(estoque_params)
    @estoque.ultima_alteracao = Estoque::REPOSICAO  
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
    movimento_estoque = MovimentoEstoque.new(
      estoque_id: @estoque.id,
      produto_id: @estoque.produto_id,
      origem: @estoque.ultima_alteracao,
      data: @estoque.updated_at,
      qtd: @estoque.estoque_atual_lote,
      estoque_inicial: 0,
      estoque_final: @estoque.estoque_atual_lote,
      preco_custo: @estoque.preco_custo_reposicao,
      empresa_id: @estoque.empresa_id
    )
    
    movimento_estoque.save
  end

  # Only allow a list of trusted parameters through.
  def estoque_params
    params.require(:estoque).permit(:produto_id, :fornecedor_id, :lote, :documento, :ultima_alteracao, :estoque_atual_lote, :data_reposicao, :data_validade, :estoque_reservado, :preco_custo_reposicao)
  end
end
