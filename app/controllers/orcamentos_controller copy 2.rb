class OrcamentosController < ApplicationController
  before_action :set_orcamento, only: %i[ show edit update destroy ]

  # GET /nota_fiscais or /nota_fiscais.json
  def index
    @orcamentos = Orcamento.all

    # paginação na view index (lista)
    options = {page: params[:page] || 1, per_page: 50} 
    @orcamentos = @orcamentos.paginate(options)    
  end

  # GET /nota_fiscais/1 or /nota_fiscais/1.json
  def show
  end

  # GET /nota_fiscais/new
  def new
    @orcamento = NotaFiscal.new

    params[:data_emissao] ||= Time.zone.now.strftime("%Y-%m-%d")
    @orcamento.data_emissao = params[:data_emissao]
    
    @transportadora = Transportadora.all
    @cfop = Cfop.all
  end

  # GET /nota_fiscais/1/edit
  def edit
  end

  # POST /nota_fiscais or /nota_fiscais.json
  def create
    @orcamento = NotaFiscal.new(orcamento_params)

    respond_to do |format|
      if @orcamento.save
        format.html { redirect_to new_orcamento_orcamento_item_path(@orcamento), notice: "Nota fiscal Cadastrado" }
        format.json { render :show, status: :created, location: @orcamento }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @orcamento.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /nota_fiscais/1 or /nota_fiscais/1.json
  def update
    respond_to do |format|
      if @orcamento.update(orcamento_params)
        format.html { redirect_to @orcamento, notice: "Nota fiscal Alterado" }
        format.json { render :show, status: :ok, location: @orcamento }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @orcamento.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nota_fiscais/1 or /nota_fiscais/1.json
  def destroy
    @orcamento.destroy
    respond_to do |format|
      format.html { redirect_to nota_fiscais_url, notice: "Nota fiscal Excluído" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_orcamento
      @orcamento = NotaFiscal.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def orcamento_params
      params.require(:orcamento).permit(:numero_nota, :numero_pedido, :cfop_id, :entsai, :cliente_id, :fornecedor_id, :vendedor_id, :data_emissao, :data_saida, :hora_saida, :valor_desconto, :valor_produtos, :valor_total_nota, :valor_frete, :valor_outras_despesas, :numero_pedido_compra, :tipo_pagamento, :meio_pagamento, :numero_parcelas_pagamento, :observacao, :chave_acesso_nfe, :nota_cancelada_sn)
    end
end
