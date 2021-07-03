class EstoquesController < ApplicationController
  before_action :set_estoque, only: %i[ show ]

  def index
    @estoques = Estoque.all
    @estoques = @estoques.where(produto_id: params[:produto_id]) if params[:produto_id].present?
  end

  def show
  end

  def reposicao
    params[:data_reposicao] ||= Time.zone.now.strftime("%Y-%m-%dT%H:%M:%S")
    @estoque = Estoque.new
    @estoque.fornecedor_id = params[:fornecedor_id] if params[:fornecedor_id].present?
    @estoque.documento = params[:documento] if params[:documento].present?
    @estoque.data_reposicao = params[:data_reposicao]
  end

  def create_reposicao
    @params = "/estoques/reposicao"
    @estoque = Estoque.new(estoque_params)
    @estoque.ultima_alteracao = "REP"

    if @estoque.save
      Produto.atualizar_produto_reposto(@estoque, params)
      @estoque.movimentacao_em_estoque
      path_with_params = "#{@params}?fornecedor_id=#{@estoque.fornecedor_id}&documento=#{@estoque.documento}&data_reposicao=#{@estoque.data_reposicao}"
      action = @params.split("/")[2].capitalize
      flash[:notice] = "#{action} em estoque feito com sucesso."
      redirect_to path_with_params 
    end
  end

  def ajuste
    new
    @params = "/estoques/ajuste"
    if params[@params]
      set_estoque
      qtd_estoque_final = (@estoque.produto.estoque_atual - @estoque.estoque_atual_lote) + estoque_params[:estoque_atual_lote].to_f
      @estoque.estoque_atual_lote = estoque_params[:estoque_atual_lote]
      @estoque.ultima_alteracao = "AJU"

      if @estoque.save
        movimento_estoque = MovimentoEstoque.new
        movimento_estoque.estoque_id = @estoque.id
        movimento_estoque.origem = @estoque.ultima_alteracao
        movimento_estoque.data = @estoque.updated_at
        movimento_estoque.qtd = @estoque.estoque_atual_lote
        movimento_estoque.estoque_inicial = @estoque.produto.estoque_atual
        movimento_estoque.estoque_final = qtd_estoque_final
        movimento_estoque.preco_custo = @estoque.produto.preco_custo
        movimento_estoque.save

        produto = @estoque.produto
        produto.estoque_atual = qtd_estoque_final
        produto.save

        action = @params.split("/")[2].capitalize
        flash[:notice] = "#{action} em estoque feito com sucesso."
        redirect_to estoques_path 
      end
    end
  end

  def baixa
    new
    @params = "/estoques/baixa"
    if params[@params]
      set_estoque
      @estoque.estoque_atual_lote = params[:estoque_atual_lote].to_f
      @estoque.ultima_alteracao = "BAI"
      
      if @estoque.save
        movimento_estoque = MovimentoEstoque.new
        movimento_estoque.estoque_id = @estoque.id
        movimento_estoque.origem = @estoque.ultima_alteracao
        movimento_estoque.data = @estoque.updated_at
        movimento_estoque.qtd = @estoque.estoque_atual_lote
        movimento_estoque.estoque_inicial = @estoque.produto.estoque_atual
        movimento_estoque.estoque_final = @estoque.produto.estoque_atual - @estoque.estoque_atual_lote.to_f
        movimento_estoque.preco_custo = @estoque.produto.preco_custo
        movimento_estoque.save

        produto = @estoque.produto
        produto.estoque_atual -= @estoque.estoque_atual_lote.to_f
        produto.save

        action = @params.split("/")[2].capitalize
        flash[:notice] = "#{action} em estoque feito com sucesso."
        redirect_to estoques_path 
      end
    end
  end

  private
    def new
      @estoque = Estoque.new
    end

    def set_estoque
      @estoque = Estoque.find(params[:id])
    end

    def estoque_params
      params.require(@params).permit(:produto_id, :fornecedor_id, :lote, :documento, :ultima_alteracao, :estoque_atual_lote, :data_reposicao, :data_validade, :estoque_reservado, :preco_custo_reposicao)
    end
end
