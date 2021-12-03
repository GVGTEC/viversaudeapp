class CfopController < ApplicationController
  before_action :set_cfop, only: %i[show edit update destroy]

  def index
    @cfop = empresa.cfop

    options = { page: params[:page] || 1, per_page: 50 }
    @cfop = @cfop.paginate(options)
  end

  def show; end

  def new
    @cfop = Cfop.new
  end

  def edit; end

  def create
    respond_to do |format|
      params[:codigo].each do |key, value|
        @cfop = Cfop.new(cfop_params)
        @cfop.codigo = value
        @cfop.informativo = key
        @cfop.empresa_id = empresa.id
        @cfop.save
      end

      format.html { redirect_to cfop_index_path, notice: 'Cfop Cadastrado' }
      format.json { render :show, status: :created, location: @cfop }
    rescue StandardError
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: @cfop.errors, status: :unprocessable_entity }
    end
  end

  def update
    respond_to do |format|
      @natureza = @cfop.natureza_operacao
      if @cfop.update(cfop_params)
        atualiza_cfops_com_mesma_natureza
        format.html { redirect_to cfop_index_path, notice: 'Cfop Alterado' }
        format.json { render :show, status: :ok, location: @cfop }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cfop.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @cfop.destroy
    respond_to do |format|
      format.html { redirect_to cfop_index_url, notice: 'Cfop Excluído' }
      format.json { head :no_content }
    end
  end

  private

  def set_cfop
    @cfop = Cfop.find(params[:id])
  end

  def atualiza_cfops_com_mesma_natureza
    cfops = Cfop.where(natureza_operacao: @natureza)
    cfops.each do |cfop|
      cfop.update(cfop_params)
    end
  end

  def cfop_params
    params.require(:cfop).permit(:descricao, :natureza_operacao, :natureza_operacao_st, :operacao, :nota_complementar_impostos_sn, :entrada_saida_es, :cliente_fornecedor_cf, :calcular_impostos_sn, :faturamento_sn, :observacao)
  end
end
