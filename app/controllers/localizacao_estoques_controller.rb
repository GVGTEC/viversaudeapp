class LocalizacaoEstoquesController < ApplicationController
  before_action :set_localizacao_estoque, only: %i[show edit update destroy]

  # GET /localizacao_estoques or /localizacao_estoques.json
  def index
    @localizacao_estoques = administrador.empresa.localizacao_estoques

    # paginação na view index (lista)
    options = { page: params[:page] || 1, per_page: 50 }
    @localizacao_estoques = @localizacao_estoques.paginate(options)
  end

  # GET /localizacao_estoques/1 or /localizacao_estoques/1.json
  def show; end

  # GET /localizacao_estoques/new
  def new
    @localizacao_estoque = LocalizacaoEstoque.new
  end

  # GET /localizacao_estoques/1/edit
  def edit; end

  # POST /localizacao_estoques or /localizacao_estoques.json
  def create
    @localizacao_estoque = LocalizacaoEstoque.new(localizacao_estoque_params)
    @localizacao_estoque.empresa_id = @adm.empresa.id

    respond_to do |format|
      if @localizacao_estoque.save
        format.html { redirect_to @localizacao_estoque, notice: 'Localizacao estoque Cadastrado' }
        format.json { render :show, status: :created, location: @localizacao_estoque }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @localizacao_estoque.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /localizacao_estoques/1 or /localizacao_estoques/1.json
  def update
    respond_to do |format|
      if @localizacao_estoque.update(localizacao_estoque_params)
        format.html { redirect_to @localizacao_estoque, notice: 'Localizacao estoque Alterado' }
        format.json { render :show, status: :ok, location: @localizacao_estoque }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @localizacao_estoque.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /localizacao_estoques/1 or /localizacao_estoques/1.json
  def destroy
    @localizacao_estoque.destroy
    respond_to do |format|
      format.html { redirect_to localizacao_estoques_url, notice: 'Localizacao estoque Excluído' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_localizacao_estoque
    @localizacao_estoque = LocalizacaoEstoque.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def localizacao_estoque_params
    params.require(:localizacao_estoque).permit(:local, :observacao)
  end
end
