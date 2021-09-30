class CfopController < ApplicationController
  before_action :set_cfop, only: %i[ show edit update destroy ]

  # GET /cfop or /cfop.json
  def index
    @cfop = Cfop.where(empresa_id: @adm.empresa.id)

    # paginação na view index (lista)
    options = {page: params[:page] || 1, per_page: 50} 
    @cfop = @cfop.paginate(options)    
  end

  # GET /cfop/1 or /cfop/1.json
  def show
  end

  # GET /cfop/new
  def new
    @cfop = Cfop.new
  end

  # GET /cfop/1/edit
  def edit
  end

  # POST /cfop or /cfop.json
  def create
    respond_to do |format|
      begin
        params[:codigo].each do |key, value|
          @cfop = Cfop.new(cfop_params)
          @cfop.codigo = value
          @cfop.informativo = key
          @cfop.empresa_id = @adm.empresa.id
          @cfop.save
        end

        format.html { redirect_to cfop_index_path, notice: "Cfop criado com sucesso." }
        format.json { render :show, status: :created, location: @cfop }
      rescue => exception
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cfop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cfop/1 or /cfop/1.json
  def update
    respond_to do |format|
      @natureza = @cfop.natureza_operacao
      if @cfop.update(cfop_params)
        atualiza_cfops_com_mesma_natureza
        format.html { redirect_to cfop_index_path, notice: "Cfop atualizado com sucesso." }
        format.json { render :show, status: :ok, location: @cfop }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cfop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cfop/1 or /cfop/1.json
  def destroy
    @cfop.destroy
    respond_to do |format|
      format.html { redirect_to cfop_index_url, notice: "Cfop excluído com sucesso.." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cfop
      @cfop = Cfop.find(params[:id])
    end

    def atualiza_cfops_com_mesma_natureza
      cfops = Cfop.where(natureza_operacao: @natureza)
      cfops.each do |cfop|
        cfop.update(cfop_params)
      end
    end

    # Only allow a licfopsst of trusted parameters through.
    def cfop_params
      params.require(:cfop).permit(:descricao, :natureza_operacao, :natureza_operacao_st, :operacao, :nota_complementar_impostos_sn, :entrada_saida_es, :cliente_fornecedor_cf, :calcular_impostos_sn, :faturamento_sn, :observacao)
    end
end
