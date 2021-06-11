class ContasPagarController < ApplicationController
  before_action :set_contas_pagar, only: %i[ show edit update destroy ]

  # GET /contas_pagar or /contas_pagar.json
  def index
    @contas_pagar = ContasPagar.all
  end

  # GET /contas_pagar/1 or /contas_pagar/1.json
  def show
  end

  # GET /contas_pagar/new
  def new
    @contas_pagar = ContasPagar.new
  end

  # GET /contas_pagar/1/edit
  def edit
  end

  # POST /contas_pagar or /contas_pagar.json
  def create
    @contas_pagar = ContasPagar.new(contas_pagar_params)

    respond_to do |format|
      if @contas_pagar.save
        format.html { redirect_to @contas_pagar, notice: "Contas pagar was successfully created." }
        format.json { render :show, status: :created, location: @contas_pagar }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @contas_pagar.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contas_pagar/1 or /contas_pagar/1.json
  def update
    respond_to do |format|
      if @contas_pagar.update(contas_pagar_params)
        format.html { redirect_to @contas_pagar, notice: "Contas pagar was successfully updated." }
        format.json { render :show, status: :ok, location: @contas_pagar }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @contas_pagar.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contas_pagar/1 or /contas_pagar/1.json
  def destroy
    @contas_pagar.destroy
    respond_to do |format|
      format.html { redirect_to contas_pagar_index_url, notice: "Contas pagar was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contas_pagar
      @contas_pagar = ContasPagar.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def contas_pagar_params
      params.require(:contas_pagar).permit(:fornecedores_id, :plano_contas_id, :documento, :historico, :data_emissao, :valor_total)
    end
end
