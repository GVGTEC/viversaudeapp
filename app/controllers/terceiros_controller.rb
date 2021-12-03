class TerceirosController < ApplicationController
  before_action :set_terceiro, only: %i[show edit update destroy]

  def index
    @terceiros = empresa.terceiros

    options = { page: params[:page] || 1, per_page: 50 }
    @terceiros = @terceiros.paginate(options)
  end

  def show; end

  def new
    @terceiro = Terceiro.new
  end

  def edit; end

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

  def destroy
    @terceiro.destroy
    respond_to do |format|
      format.html { redirect_to terceiros_url, notice: 'Terceiro Excluído' }
      format.json { head :no_content }
    end
  end

  private

  def set_terceiro
    @terceiro = Terceiro.find(params[:id])
  end

  def terceiro_params
    params.require(:terceiro).permit(:nome, :pessoa, :cpf, :rg, :cnpj, :ie, :endereco, :bairro, :cidade, :cep, :uf,
                                     :telefone, :email)
  end
end
