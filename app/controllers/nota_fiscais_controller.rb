class NotaFiscaisController < ApplicationController
  before_action :set_nota_fiscal, only: %i[show edit update destroy observacoes]

  # GET /nota_fiscais or /nota_fiscais.json
  def index
    @nota_fiscais = NotaFiscal.where(empresa_id: @adm.empresa.id)
    @nota_fiscais = @nota_fiscais.order("numero_nota desc")

    # paginação na view index (lista)
    options = { page: params[:page] || 1, per_page: 50 }
    @nota_fiscais = @nota_fiscais.paginate(options)
  end

  # GET /nota_fiscais/1 or /nota_fiscais/1.json
  def show; end

  # GET /nota_fiscais/new
  def new
    @nota_fiscal = NotaFiscal.new
    @nota_fiscal.data_emissao = Time.zone.now.strftime('%Y-%m-%dT%H:%M')
  end

  def observacoes; end

  # GET /nota_fiscais/1/edit
  def edit; end

  # POST /nota_fiscais or /nota_fiscais.json
  def create
    @nota_fiscal = NotaFiscal.new(nota_fiscal_params)

    respond_to do |format|
      if @nota_fiscal.save
        salvar_nota_fiscal_transportadora
        format.html do
          redirect_to new_nota_fiscal_nota_fiscal_item_path(@nota_fiscal), notice: 'Nota Fiscal Cadastrada'
        end
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
        salvar_nota_fiscal_transportadora
        salvar_movimento_estoque
        format.html { redirect_to nota_fiscais_path, notice: 'Nota Fiscal Alterada' }
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
      format.html { redirect_to nota_fiscais_url, notice: 'Nota Fiscal Excluída' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_nota_fiscal
    @nota_fiscal = NotaFiscal.find(params[:id] || params[:nota_fiscal_id])
  end

  def salvar_nota_fiscal_transportadora
    return if params[:quantidade].blank?
    
    NotaFiscalTransporta.where(nota_fiscal: @nota_fiscal.id).destroy_all
    if params[:nota_fiscal].key?(:transportadora_id)
      nota_fiscal_transporta = NotaFiscalTransporta.new
      nota_fiscal_transporta.nota_fiscal_id = @nota_fiscal.id
      nota_fiscal_transporta.transportadora_id = params[:nota_fiscal][:transportadora_id]
      nota_fiscal_transporta.quantidade = params[:quantidade]
      nota_fiscal_transporta.especie = params[:especie]
      nota_fiscal_transporta.marca = params[:marca]
      nota_fiscal_transporta.peso_liquido = params[:peso_liquido]
      nota_fiscal_transporta.peso_bruto = params[:peso_bruto]
      nota_fiscal_transporta.save
    end
  end

  def salvar_movimento_estoque
    return if params[:movimentos].blank?
    
    movimentos = params[:movimentos].split("[").join("").split("]")
    movimentos = movimentos.first.split("},").map{|mv| mv = mv.include?("}") ? mv << "" : mv << "}"  }
    
    MovimentoEstoque.where(nota_fiscal_id: @nota_fiscal.id).destroy_all
    movimentos.each do |movimento|
      movimento = JSON.parse(movimento)
      movimento_estoque = MovimentoEstoque.new
      movimento_estoque.produto_id = movimento["produto_id"]
      movimento_estoque.estoque_id = movimento["estoque_id"]
      movimento_estoque.nota_fiscal_id = @nota_fiscal.id
      movimento_estoque.origem = movimento["origem"]
      movimento_estoque.data = movimento["data"].to_date
      movimento_estoque.qtd = movimento["qtd"]
      movimento_estoque.estoque_inicial = movimento["estoque_inicial"]
      movimento_estoque.estoque_final = movimento["estoque_final"]
      movimento_estoque.preco_custo = Produto.find(movimento["produto_id"]).preco_custo
      movimento_estoque.save
    end
  end

  # Only allow a list of trusted parameters through.
  def nota_fiscal_params
    debugger
    params.require(:nota_fiscal).permit(:numero_nota, :numero_pedido, :cfop_id, :entsai, :cliente_id, :fornecedor_id,
                                        :vendedor_id, :transportadora_id, :data_emissao, :data_saida, :hora_saida, :valor_desconto, :valor_produtos, :valor_total_nota, :valor_frete, :valor_outras_despesas, :numero_pedido_compra, :tipo_pagamento, :meio_pagamento, :numero_parcelas_pagamento, :observacao, :chave_acesso_nfe, :nota_cancelada_sn, :pagar_frete)
  end
end
