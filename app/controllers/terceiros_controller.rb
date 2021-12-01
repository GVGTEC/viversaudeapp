class TerceirosController < ApplicationController
  before_action :set_terceiro, only: %i[show edit update destroy]

  # GET /terceiros or /terceiros.json
  def index
    @terceiros = empresa.terceiros

    # paginação na view index (lista)
    options = { page: params[:page] || 1, per_page: 50 }
    @terceiros = @terceiros.paginate(options)
  end

  # GET /terceiros/1 or /terceiros/1.json
  def show; end

  # GET /terceiros/new
  def new
    @terceiro = Terceiro.new
  end

  # GET /terceiros/1/edit
  def edit; end

  # POST /terceiros or /terceiros.json
  def create
    @terceiro = Terceiro.new(terceiro_params)
    @terceiro.empresa_id = @adm.empresa.id

    respond_to do |format|
      if @terceiro.save
        format.html { redirect_to @terceiro, notice: 'Terceiro Cadastrado' }
        format.json { render :show, status: :created, location: @terceiro }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @terceiro.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /terceiros/1 or /terceiros/1.json
  def update
    respond_to do |format|
      if @terceiro.update(terceiro_params)
        format.html { redirect_to @terceiro, notice: 'Terceiro Alterado' }
        format.json { render :show, status: :ok, location: @terceiro }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @terceiro.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /terceiros/1 or /terceiros/1.json
  def destroy
    @terceiro.destroy
    respond_to do |format|
      format.html { redirect_to terceiros_url, notice: 'Terceiro Excluído' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_terceiro
    @terceiro = Terceiro.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def terceiro_params
    params.require(:terceiro).permit(:nome, :pessoa, :cpf, :rg, :cnpj, :ie, :endereco, :bairro, :cidade, :cep, :uf,
                                     :telefone, :email)
  end
end
