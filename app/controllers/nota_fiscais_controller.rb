class NotaFiscaisController < ApplicationController
  before_action :set_nota_fiscal, only: %i[ show edit update destroy ]

  # GET /nota_fiscais or /nota_fiscais.json
  def index
    @nota_fiscais = NotaFiscal.all
  end

  # GET /nota_fiscais/1 or /nota_fiscais/1.json
  def show
  end

  # GET /nota_fiscais/new
  def new
    @nota_fiscal = NotaFiscal.new

    params[:data_emissao] ||= Time.zone.now.strftime("%Y-%m-%d")
    @nota_fiscal.data_emissao = params[:data_emissao]
  end

  # GET /nota_fiscais/1/edit
  def edit
  end

  # POST /nota_fiscais or /nota_fiscais.json
  def create
    @nota_fiscal = NotaFiscal.new(nota_fiscal_params)

    respond_to do |format|
      if @nota_fiscal.save
        format.html { redirect_to @nota_fiscal, notice: "Nota fiscal was successfully created." }
        format.json { render :show, status: :created, location: @nota_fiscal }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @nota_fiscal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /nota_fiscais/1 or /nota_fiscais/1.json
  def update
    respond_to do |format|
      if @nota_fiscal.update(nota_fiscal_params)
        format.html { redirect_to @nota_fiscal, notice: "Nota fiscal was successfully updated." }
        format.json { render :show, status: :ok, location: @nota_fiscal }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @nota_fiscal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nota_fiscais/1 or /nota_fiscais/1.json
  def destroy
    @nota_fiscal.destroy
    respond_to do |format|
      format.html { redirect_to nota_fiscais_url, notice: "Nota fiscal was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_nota_fiscal
      @nota_fiscal = NotaFiscal.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def nota_fiscal_params
      params.require(:nota_fiscal).permit(:numero_nota, :numero_pedido, :cfop_id, :entsai, :cliente_id, :fornecedor_id, :vendedor_id, :data_emissao, :data_saida, :hora_saida, :valor_desconto, :valor_produtos, :valor_total_nota, :valor_frete, :valor_outras_despesas, :numero_pedido_compra, :tipo_pagamento, :meio_pagamento, :numero_parcelas_pagamento, :observacao, :chave_acesso_nfe, :nota_cancelada_sn)
    end
end
