class NotaFiscalItensController < ApplicationController
  before_action :set_nota_fiscal_item, only: %i[show edit update destroy]
  before_action :set_nota_fiscal

  # GET /nota_fiscal_itens or /nota_fiscal_itens.json
  def index
    @nota_fiscal_itens = NotaFiscalItem.where(nota_fiscal_id: @nota_fiscal.id)
  end

  # GET /nota_fiscal_itens/1 or /nota_fiscal_itens/1.json
  def show; end

  # GET /nota_fiscal_itens/new
  def new
    @nota_fiscal_item = NotaFiscalItem.new
  end

  # GET /nota_fiscal_itens/1/edit
  def edit; end

  # POST /nota_fiscal_itens or /nota_fiscal_itens.json
  def create
    if params[:nota_fiscal].key?(:nota_fiscal_item)
      NotaFiscalItem.where(nota_fiscal: @nota_fiscal.id).destroy_all
      preco_total = 0
      params[:nota_fiscal][:nota_fiscal_item].each do |nota_fiscal_item|
        next if nota_fiscal_item[:cod_produto].blank?

        begin
          @nota_fiscal_item = NotaFiscalItem.new
          @nota_fiscal_item.nota_fiscal = @nota_fiscal
          @nota_fiscal_item.produto = Produto.find(nota_fiscal_item[:cod_produto])
          @nota_fiscal_item.descricao = @nota_fiscal_item.produto.descricao
          @nota_fiscal_item.cfop = nota_fiscal_item[:cfop]
          @nota_fiscal_item.ncm = nota_fiscal_item[:ncm]
          @nota_fiscal_item.unidade = nota_fiscal_item[:un]
          @nota_fiscal_item.quantidade = nota_fiscal_item[:qtd]
          @nota_fiscal_item.preco_unitario = nota_fiscal_item[:preco_unitario].match(/\d+/)[0]
          @nota_fiscal_item.preco_total = nota_fiscal_item[:preco_total].match(/\d+/)[0]
          @nota_fiscal_item.cst = cst
          @nota_fiscal_item.save

          calculo_imposto_item

          preco_total += nota_fiscal_item[:preco_total].match(/\d+/)[0].to_i
        rescue StandardError
          flash[:error] = 'Erro no cadastramento. Verifique se todos os campos estão prenchidos corretamente.'
          redirect_to "/nota_fiscais/#{@nota_fiscal.id}/nota_fiscal_itens/new"
        end
      end

      @nota_fiscal.valor_produtos = preco_total
      @nota_fiscal.valor_total_nota = calculo_valor_total_nota(preco_total)
      @nota_fiscal.save

      calculo_imposto_nota
    end

    respond_to do |format|
      format.html do
        redirect_to new_nota_fiscal_nota_fiscal_duplicata_path(@nota_fiscal), notice: 'Nota fiscal item Cadastrado'
      end
    end
  end

  # PATCH/PUT /nota_fiscal_itens/1 or /nota_fiscal_itens/1.json
  def update
    respond_to do |format|
      if @nota_fiscal_item.update(nota_fiscal_item_params)
        format.html { redirect_to @nota_fiscal_item, notice: 'Nota fiscal item Alterado' }
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
      format.html { redirect_to nota_fiscal_itens_url, notice: 'Nota fiscal item Excluído' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_nota_fiscal_item
    @nota_fiscal_item = NotaFiscalItem.find(params[:id])
  end

  def set_nota_fiscal
    @nota_fiscal = NotaFiscal.find(params[:nota_fiscal_id])
  end

  def calculo_valor_total_nota(preco_total)
    # preco_total - @nota_fiscal.valor_desconto + @nota_fiscal.valor_frete + @nota_fiscal.valor_outras_despesas
    preco_total
  end

  def calculo_imposto_item
    @nota_fiscal_item.aliquota_icms = Icms.find_by(estado: @nota_fiscal.cliente.uf).aliquota_icms
    @nota_fiscal_item.valor_bc_icms = @nota_fiscal_item.preco_total
    @nota_fiscal_item.valor_icms = @nota_fiscal_item.preco_total * @nota_fiscal_item.aliquota_icms / 100

    @nota_fiscal_item.aliquota_icms_st = 0
    @nota_fiscal_item.valor_bc_icms_st = 0
    @nota_fiscal_item.valor_icms_st = 0

    @nota_fiscal_item.aliquota_ipi = 0
    @nota_fiscal_item.valor_ipi = 0

    @nota_fiscal_item.aliquota_pis = @adm.empresa.aliquota_pis
    @nota_fiscal_item.valor_pis = @nota_fiscal_item.preco_total * @nota_fiscal_item.aliquota_pis / 100

    @nota_fiscal_item.aliquota_cofins = @adm.empresa.aliquota_cofins
    @nota_fiscal_item.valor_cofins = @nota_fiscal_item.preco_total * @nota_fiscal_item.aliquota_cofins / 100

    @nota_fiscal_item.aliquota_difal = 0
    @nota_fiscal_item.valor_difal = 0

    @nota_fiscal_item.valor_fcp = 0
    @nota_fiscal_item.aliquota_fcp = 0
    @nota_fiscal_item.save
  end

  def cst
    situacao_tributaria = @nota_fiscal_item.produto.situacao_tributaria

    case situacao_tributaria
    when 'T'
      '00' # Tributada integralmente
    when 'I'
      '40' # Isenta
    when 'S'
      '60' # ICMS cobrado anteriormente por substituição tributária
    else
      '41' # Não tributada
    end

    # " 00 - Tributada integralmente
    #   10 - Tributada e com cobrança do ICMS por substituição tributária
    #   20 - Com redução da BC
    #   30 - Isenta / não tributada e com cobrança do ICMS por substituição tributária
    #   40 - Isenta
    #   41 - Não tributada
    #   50 - Com suspensão
    #   51 - Com diferimento
    #   60 - ICMS cobrado anteriormente por substituição tributária
    #   70 - Com redução da BC e cobrança do ICMS por substituição tributária
    #   90 - Outras
    # "
  end

  def csosn
    " 101 - Tributada pelo Simples Nacional com permissão de crédito
      102 - Tributada pelo Simples Nacional sem permissão de crédito
      103 - Isenção do ICMS no Simples Nacional para faixa de receita bruta
      201 - Tributada pelo Simples Nacional com permissão de crédito e com cobrança do ICMS
    por substituição tributária
      202 - Tributada pelo Simples Nacional sem permissão de crédito e com cobrança do ICMS
    por substituição tributária
      203 - Isenção do ICMS no Simples Nacional para faixa de receita bruta e com cobrança do
    ICMS por substituição tributária
      300 - Imune
      400 - Não tributada pelo Simples Nacional
      500 - ICMS cobrado anteriormente por substituição tributária (substituído) ou por
    antecipação
      900 - Outros
    "
  end

  def calculo_imposto_nota
    nota_fiscal_imposto = @nota_fiscal.nota_fiscal_imposto
    nota_fiscal_imposto ||= NotaFiscalImposto.new

    nota_fiscal_imposto.nota_fiscal_id = @nota_fiscal.id
    nota_fiscal_imposto.valor_bc_icms = @nota_fiscal.nota_fiscal_itens.sum(:valor_bc_icms)
    nota_fiscal_imposto.valor_icms = @nota_fiscal.nota_fiscal_itens.sum(:valor_icms)
    nota_fiscal_imposto.valor_bc_icms_st = @nota_fiscal.nota_fiscal_itens.sum(:valor_bc_icms_st)
    nota_fiscal_imposto.valor_icms_st = @nota_fiscal.nota_fiscal_itens.sum(:valor_icms_st)
    nota_fiscal_imposto.valor_pis = @nota_fiscal.nota_fiscal_itens.sum(:valor_pis)
    nota_fiscal_imposto.valor_cofins = @nota_fiscal.nota_fiscal_itens.sum(:valor_cofins)
    nota_fiscal_imposto.valor_ipi = @nota_fiscal.nota_fiscal_itens.sum(:valor_ipi)
    nota_fiscal_imposto.valor_difal = @nota_fiscal.nota_fiscal_itens.sum(:valor_difal)
    nota_fiscal_imposto.valor_fcp = @nota_fiscal.nota_fiscal_itens.sum(:valor_fcp)
    nota_fiscal_imposto.save
  end

  # Only allow a list of trusted parameters through.
  def nota_fiscal_item_params
    params.require(:nota_fiscal_item).permit(:nota_fiscal_id, :produto_id, :descricao, :cfop, :st, :ncm, :cst,
                                             :unidade, :quantidade, :preco_unitario, :preco_total, :aliquota_icms, :valor_bc_icms, :valor_icms, :aliquota_icms_st, :valor_bc_icms_st, :valor_icms_st, :aliquota_ipi, :valor_ipi, :aliquota_pis, :valor_pis, :aliquota_cofins, :valor_cofins, :aliquota_difal, :valor_difal, :valor_fcp, :aliquota_fcp, :local_estoque, :baixou_estoque, :pagar_comissao_sn, :comissao_ven_pc, :comissao_ven_vr, :comissao_ter_pc, :comissao_ter_vr)
  end
end
