class NotaFiscalItensController < ApplicationController
  before_action :set_nota_fiscal_item, only: %i[ show edit update destroy ]

  # GET /nota_fiscal_itens or /nota_fiscal_itens.json
  def index
    @nota_fiscal_itens = NotaFiscalItem.all
  end

  # GET /nota_fiscal_itens/1 or /nota_fiscal_itens/1.json
  def show
  end

  # GET /nota_fiscal_itens/new
  def new
    @nota_fiscal_item = NotaFiscalItem.new
  end

  # GET /nota_fiscal_itens/1/edit
  def edit
  end

  # POST /nota_fiscal_itens or /nota_fiscal_itens.json
  def create
    @nota_fiscal_item = NotaFiscalItem.new(nota_fiscal_item_params)

    respond_to do |format|
      if @nota_fiscal_item.save
        format.html { redirect_to @nota_fiscal_item, notice: "Nota fiscal item was successfully created." }
        format.json { render :show, status: :created, location: @nota_fiscal_item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @nota_fiscal_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /nota_fiscal_itens/1 or /nota_fiscal_itens/1.json
  def update
    respond_to do |format|
      if @nota_fiscal_item.update(nota_fiscal_item_params)
        format.html { redirect_to @nota_fiscal_item, notice: "Nota fiscal item was successfully updated." }
        format.json { render :show, status: :ok, location: @nota_fiscal_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @nota_fiscal_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nota_fiscal_itens/1 or /nota_fiscal_itens/1.json
  def destroy
    @nota_fiscal_item.destroy
    respond_to do |format|
      format.html { redirect_to nota_fiscal_itens_url, notice: "Nota fiscal item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_nota_fiscal_item
      @nota_fiscal_item = NotaFiscalItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def nota_fiscal_item_params
      params.require(:nota_fiscal_item).permit(:nota_fiscal_id, :produto_id, :descricao, :cfop, :st, :ncm, :cst, :unidade, :quantidade, :preco_unitario, :preco_total, :aliquota_icms, :valor_bc_icms, :valor_icms, :aliquota_icms_st, :valor_bc_icms_st, :valor_icms_st, :aliquota_ipi, :valor_ipi, :aliquota_pis, :valor_pis, :aliquota_cofins, :valor_cofins, :aliquota_difal, :valor_difal, :valor_fcp, :aliquota_fcp, :local_estoque, :baixou_estoque, :pagar_comissao_sn, :comissao_ven_pc, :comissao_ven_vr, :comissao_ter_pc, :comissao_ter_vr)
    end
end
