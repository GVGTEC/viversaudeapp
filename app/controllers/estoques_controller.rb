class EstoquesController < ApplicationController
  before_action :set_estoque, only: %i[ show update destroy ]

  def index
    @estoques = Estoque.all
    @estoques = @estoques.where(produto_id: params[:produto_id]) if params[:produto_id].present?
  end

  def show
  end

  def reposicao
    new
    @params = "/estoques/reposicao"
    if params[@params]
      @estoque = Estoque.new(estoque_params)
      create
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

    def create
      respond_to do |format|
        if @estoque.save
          format.html { redirect_to estoques_path, notice: "#{@params.split("/")[2].capitalize} em estoque feito com sucesso." }
          format.json { render :show, status: :created, location: @estoque }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @estoque.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @estoque.update(estoque_params)
          format.html { redirect_to estoques_path, notice: "#{@params.split("/")[2].capitalize} em estoque feito com sucesso." }
          format.json { render :show, status: :ok, location: @estoque }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @estoque.errors, status: :unprocessable_entity }
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
      params.require(@params).permit(:produto_id, :fornecedor_id, :lote, :documento, :qtd, :data_reposicao, :data_validade, :estoque_atual, :estoque_minimo, :estoque_reservado)
    end
end
