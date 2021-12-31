class ContasRecController < ApplicationController
  before_action :set_contas_rec, only: %i[show edit update destroy]

  def index
    @contas_rec = empresa.contas_rec

    # paginação na view index (lista)
    options = { page: params[:page] || 1, per_page: 50 }
    @contas_rec = @contas_rec.paginate(options)
  end

  def show; end

  def new
    @contas_rec = ContasRec.new
  end

  def edit; end

  def create
    @contas_rec = ContasRec.new(contas_rec_params)
    @contas_rec.empresa_id = @adm.empresa.id

    respond_to do |format|
      if @contas_rec.save
        save_contas_rec_parcelas
        format.html { redirect_to @contas_rec, notice: 'Contas rec Cadastrado' }
        format.json { render :show, status: :created, location: @contas_rec }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @contas_rec.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @contas_rec.update(contas_rec_params)
        save_contas_rec_parcelas
        format.html { redirect_to @contas_rec, notice: 'Contas rec Alterado' }
        format.json { render :show, status: :ok, location: @contas_rec }
      else
        format.html { render :edit, status: :unprocessable_entity }
         format.json { render json: @contas_rec.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @contas_rec.destroy
    respond_to do |format|
      format.html { redirect_to contas_rec_index_url, notice: 'Contas rec Excluído' }
      format.json { head :no_content }
    end
  end

  private

  def set_contas_rec
    @contas_rec = ContasRec.find(params[:id])
  end

  def save_contas_pagar_parcelas
    if params[:contas_rec].present? && params[:contas_rec][:contas_rec_parcela].present?
      @contas_rec.contas_rec_parcelas.destroy_all
      params[:contas_rec][:contas_rec_parcela].each do |parcela|
        next unless parcela[:data_vencimento].present? || parcela[:data_recebimento].present?

        contas_rec_parcela = ContasRecParcela.new(
          data_vencimento: parcela[:data_vencimento],
          data_pagamento: parcela[:data_pagamento],
          valor_parcela: parcela[:valor_parcela],
          valor_juros_desconto: parcela[:valor_juros_desconto],
          documento: parcela[:documento],
          descricao: parcela[:descricao],
          contas_rec: @contas_rec
        )
        
        contas_rec_parcela.save!
      end
    end
  end

  def contas_rec_params
    params.require(:contas_rec).permit(:cliente_id, :plano_conta_id, :documento, :historico, :data_emissao,
                                       :valor_total)
  end
end
