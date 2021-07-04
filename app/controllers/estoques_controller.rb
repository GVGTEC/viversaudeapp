class EstoquesController < ApplicationController
  before_action :set_estoque, only: %i[ show update destroy ]

  def index
    @estoques = Estoque.all
    @estoques = @estoques.where(produto_id: params[:produto_id]) if params[:produto_id].present?
  end

  def show
  end

  def reposicao
    params[:data_reposicao] ||= Time.zone.now.strftime("%Y-%m-%d")
    @estoque = Estoque.new
    @estoque.fornecedor_id = params[:fornecedor_id] if params[:fornecedor_id].present?
    @estoque.documento = params[:documento] if params[:documento].present?
    @estoque.data_reposicao = params[:data_reposicao].present?
  end

  def create_reposicao
    @params = "/estoques/reposicao"
    @estoque = Estoque.new(estoque_params)
    respond_to do |format|
      if @estoque.save
        atualizar_produto
        path_with_params = "#{@params}?fornecedor_id=#{@estoque.fornecedor_id}&documento=#{@estoque.documento}&data_reposicao=#{@estoque.data_reposicao}"
        action = @params.split("/")[2].capitalize
        format.html { redirect_to path_with_params, notice: "#{action} em estoque feito com sucesso." }
      else
        format.html { render estoques_reposicao_path, status: :unprocessable_entity }
      end
    end
  end

  def ajuste
    new
    @params = "/estoques/ajuste"
    if params[@params]
      set_estoque
      update
    end
  end

  def baixa
    new
    @params = "/estoques/baixa"
    if params[@params]
      set_estoque
      update
    end
  end

  private
    def new
      @estoque = Estoque.new
    end

    def update
      respond_to do |format|
        if @estoque.update(estoque_params)
          action = @params.split("/")[2].capitalize
          format.html { redirect_to estoques_path, notice: "#{action} em estoque feito com sucesso." }
        else
          format.html { render estoques_path, status: :unprocessable_entity }
        end
      end
    end

    def atualizar_produto
      produto = @estoque.produto
      produto.estoque_atual += @estoque.estoque_atual_lote if @params.include?("reposicao")
      produto.preco_custo = params[:preco_custo_reposicao]
      produto.preco_custo_medio = params[:preco_custo_reposicao]
      produto.save
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_estoque
      @estoque = Estoque.find(params[:id])
    end


    def estoque_params
      params.require(@params).permit(:produto_id, :fornecedor_id, :lote, :documento, :estoque_atual_lote, :data_reposicao, :data_validade, :estoque_reservado)
    end
end
