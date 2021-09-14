class ContasRecController < ApplicationController
  before_action :set_contas_rec, only: %i[show edit update destroy]

  # GET /contas_rec or /contas_rec.json
  def index
    @contas_rec = ContasRec.where(empresa_id: @adm.empresa.id)

    # paginação na view index (lista)
    options = {page: params[:page] || 1, per_page: 50}
    @contas_rec = @contas_rec.paginate(options)
  end

  # GET /contas_rec/1 or /contas_rec/1.json
  def show
  end

  # GET /contas_rec/new
  def new
    @contas_rec = ContasRec.new
  end

  # GET /contas_rec/1/edit
  def edit
  end

  # POST /contas_rec or /contas_rec.json
  def create
    @contas_rec = ContasRec.new(contas_rec_params)
    @contas_rec.empresa_id = @adm.empresa.id

    respond_to do |format|
      if @contas_rec.save
        save_contas_rec_parcelas
        format.html { redirect_to @contas_rec, notice: "Contas rec was successfully created." }
        format.json { render :show, status: :created, location: @contas_rec }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @contas_rec.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contas_rec/1 or /contas_rec/1.json
  def update
    respond_to do |format|
      if @contas_rec.update(contas_rec_params)
        save_contas_rec_parcelas
        format.html { redirect_to @contas_rec, notice: "Contas rec was successfully updated." }
        format.json { render :show, status: :ok, location: @contas_rec }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @contas_rec.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contas_rec/1 or /contas_rec/1.json
  def destroy
    @contas_rec.destroy
    respond_to do |format|
      format.html { redirect_to contas_rec_index_url, notice: "Contas rec was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_contas_rec
    @contas_rec = ContasRec.find(params[:id])
  end

  def save_contas_pagar_parcelas
    if params[:contas_rec].present? && params[:contas_rec][:contas_rec_parcela].present?
      @contas_pag.contas_rec_parcelas.destroy_all
      params[:contas_rec][:contas_rec_parcela].each do |parcela|
        if parcela[:data_vencimento].present? || parcela[:data_recebimento].present?
          contas_rec_parcela = ContasRecParcela.new
          contas_rec_parcela.data_vencimento = parcela[:data_vencimento]
          contas_rec_parcela.data_pagamento = parcela[:data_pagamento]
          contas_rec_parcela.valor_parcela = parcela[:valor_parcela]
          contas_rec_parcela.valor_juros_desconto = parcela[:valor_juros_desconto]
          contas_rec_parcela.documento = parcela[:documento]
          contas_rec_parcela.descricao = parcela[:descricao]
          contas_rec_parcela.contas_rec = @contas_rec
          contas_rec_parcela.save!
        end
      end
    end
  end

  # Only allow a list of trusted parameters through.
  def contas_rec_params
    params.require(:contas_rec).permit(:cliente_id, :plano_conta_id, :documento, :historico, :data_emissao, :valor_total)
  end
end
