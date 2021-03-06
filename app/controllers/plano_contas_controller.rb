class PlanoContasController < ApplicationController
  before_action :set_plano_conta, only: %i[show edit update destroy]

  def index
    @plano_contas = empresa.plano_contas

    options = { page: params[:page] || 1, per_page: 50 }
    @plano_contas = @plano_contas.paginate(options)
  end

  def show; end

  def new
    @plano_conta = PlanoConta.new
  end

  def edit; end

  def create
    @plano_conta = PlanoConta.new(plano_conta_params)
    @plano_conta.empresa_id = @adm.empresa.id

    respond_to do |format|
      if @plano_conta.save
        format.html { redirect_to @plano_conta, notice: 'Plano conta Cadastrado' }
        format.json { render :show, status: :created, location: @plano_conta }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @plano_conta.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @plano_conta.update(plano_conta_params)
        format.html { redirect_to @plano_conta, notice: 'Plano conta Alterado' }
        format.json { render :show, status: :ok, location: @plano_conta }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @plano_conta.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @plano_conta.destroy
    respond_to do |format|
      format.html { redirect_to plano_contas_url, notice: 'Plano conta Excluído' }
      format.json { head :no_content }
    end
  end

  private

  def set_plano_conta
    @plano_conta = PlanoConta.find(params[:id])
  end

  def plano_conta_params
    params.require(:plano_conta).permit(:conta, :descricao, :grau)
  end
end
