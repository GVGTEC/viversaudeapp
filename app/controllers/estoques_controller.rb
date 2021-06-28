class EstoquesController < ApplicationController
  before_action :set_estoque, only: %i[ show update destroy ]

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
    respond_to do |format|
      if @estoque.save
        path_with_params = "#{@params}?fornecedor_id=#{@estoque.fornecedor_id}&documento=#{@estoque.documento}&data_reposicao=#{@estoque.data_reposicao}"
        format.html { redirect_to path_with_params, notice: "#{@params.split("/")[2].capitalize} em estoque feito com sucesso." }
        format.json { render :show, status: :created, location: @estoque }
      else
        format.html { render estoques_reposicao_path, status: :unprocessable_entity }
        format.json { render json: @estoque.errors, status: :unprocessable_entity }
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
          format.html { redirect_to estoques_path, notice: "#{@params.split("/")[2].capitalize} em estoque feito com sucesso." }
          format.json { render :show, status: :ok, location: @estoque }
        else
          format.html { render estoques_path, status: :unprocessable_entity }
          format.json { render json: @estoque.errors, status: :unprocessable_entity }
        end
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_estoque
      @estoque = Estoque.find(params[:id])
    end


    def estoque_params
      params.require(@params).permit(:produto_id, :fornecedor_id, :lote, :documento, :estoque_atual_lote, :data_reposicao, :data_validade, :estoque_reservado)
    end
end
