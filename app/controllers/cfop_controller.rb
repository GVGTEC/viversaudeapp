class CfopController < ApplicationController
  before_action :set_cfop, only: %i[ show edit update destroy ]

  # GET /cfop or /cfop.json
  def index
    @cfop = Cfop.all

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
    @cfop = Cfop.new(cfop_params)

    respond_to do |format|
      if @cfop.save
        format.html { redirect_to @cfop, notice: "Cfop was successfully created." }
        format.json { render :show, status: :created, location: @cfop }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cfop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cfop/1 or /cfop/1.json
  def update
    respond_to do |format|
      if @cfop.update(cfop_params)
        format.html { redirect_to @cfop, notice: "Cfop was successfully updated." }
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
      format.html { redirect_to cfop_index_url, notice: "Cfop was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cfop
      @cfop = Cfop.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cfop_params
      params.require(:cfop).permit(:cfop_de, :cfop_st_de, :cfop_fe, :cfop_st_fe, :descricao, :natureza_operacao, :natureza_operacao_st, :operacao, :nota_complementar_impostos_sn, :entrada_saida_es, :cliente_fornecedor_cf, :calcular_impostos_sn, :faturamento_sn, :observacao)
    end
end
