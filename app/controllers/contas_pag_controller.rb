class ContasPagController < ApplicationController
  before_action :set_contas_pagar, only: %i[ show edit update destroy ]

  # GET /contas_pagar or /contas_pagar.json
  def index
    @contas_pag = ContasPag.where(empresa_id: @adm.empresa.id)

    # paginação na view index (lista)
    options = {page: params[:page] || 1, per_page: 50} 
    @contas_pag = @contas_pag.paginate(options)    
  end

  # GET /contas_pagar/1 or /contas_pagar/1.json
  def show
  end

  # GET /contas_pagar/new
  def new
    @contas_pag = ContasPag.new
  end

  # GET /contas_pagar/1/edit
  def edit
  end

  # POST /contas_pagar or /contas_pagar.json
  def create
    @contas_pag = ContasPag.new(contas_pagar_params)
    @contas_pag.empresa_id = @adm.empresa.id

    respond_to do |format|
      if @contas_pag.save
        save_contas_pagar_parcelas
        format.html { redirect_to @contas_pag, notice: "Contas pagar Cadastrado" }
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
      if @contas_pag.update(contas_pagar_params)
        save_contas_pagar_parcelas
        format.html { redirect_to @contas_pag, notice: "Contas pagar Alterado" }
        format.json { render :show, status: :ok, location: @contas_pagar }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @contas_pagar.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contas_pagar/1 or /contas_pagar/1.json
  def destroy
    @contas_pag.destroy
    respond_to do |format|
      format.html { redirect_to contas_pagar_index_url, notice: "Contas pagar Excluído" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contas_pagar
      @contas_pag = ContasPag.find(params[:id])
    end

    def save_contas_pagar_parcelas
      if params[:contas_pag].present? && params[:contas_pag][:contas_pagar_parcela].present?
        @contas_pag.contas_pagar_parcelas.destroy_all
        params[:contas_pag][:contas_pagar_parcela].each do |parcela|
          if parcela[:data_vencimento].present? || parcela[:data_pagamento].present?
            contas_pagar_parcela = ContasPagarParcela.new
            contas_pagar_parcela.data_vencimento = parcela[:data_vencimento]
            contas_pagar_parcela.data_pagamento = parcela[:data_pagamento]
            contas_pagar_parcela.valor_parcela = parcela[:valor_parcela]
            contas_pagar_parcela.valor_juros_desconto = parcela[:valor_juros_desconto]
            contas_pagar_parcela.documento = parcela[:documento]
            contas_pagar_parcela.descricao = parcela[:descricao]
            contas_pagar_parcela.contas_pag = @contas_pag
            contas_pagar_parcela.save!
          end
        end
      end
    end

    # Only allow a list of trusted parameters through.
    def contas_pagar_params
      params.require(:contas_pag).permit(:fornecedor_id, :plano_conta_id, :documento, :historico, :data_emissao, :valor_total)
    end
end
