class ContasPagarParcelasController < ApplicationController
  before_action :set_contas_pagar_parcela, only: %i[ show edit update destroy ]

  # GET /contas_pagar_parcelas or /contas_pagar_parcelas.json
  def index
    @contas_pagar_parcelas = ContasPagarParcela.all
  end

  # GET /contas_pagar_parcelas/1 or /contas_pagar_parcelas/1.json
  def show
  end

  # GET /contas_pagar_parcelas/new
  def new
    @contas_pagar_parcela = ContasPagarParcela.new
  end

  # GET /contas_pagar_parcelas/1/edit
  def edit
  end

  # POST /contas_pagar_parcelas or /contas_pagar_parcelas.json
  def create
    @contas_pagar_parcela = ContasPagarParcela.new(contas_pagar_parcela_params)

    respond_to do |format|
      if @contas_pagar_parcela.save
        format.html { redirect_to @contas_pagar_parcela, notice: "Contas pagar parcela was successfully created." }
        format.json { render :show, status: :created, location: @contas_pagar_parcela }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @contas_pagar_parcela.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contas_pagar_parcelas/1 or /contas_pagar_parcelas/1.json
  def update
    respond_to do |format|
      if @contas_pagar_parcela.update(contas_pagar_parcela_params)
        format.html { redirect_to @contas_pagar_parcela, notice: "Contas pagar parcela was successfully updated." }
        format.json { render :show, status: :ok, location: @contas_pagar_parcela }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @contas_pagar_parcela.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contas_pagar_parcelas/1 or /contas_pagar_parcelas/1.json
  def destroy
    @contas_pagar_parcela.destroy
    respond_to do |format|
      format.html { redirect_to contas_pagar_parcelas_url, notice: "Contas pagar parcela was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contas_pagar_parcela
      @contas_pagar_parcela = ContasPagarParcela.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def contas_pagar_parcela_params
      params.require(:contas_pagar_parcela).permit(:contas_pagar_id, :data_vencimento, :data_pagamento, :valor_parcela, :valor_juros_desconto, :documento, :descricao)
    end
end
