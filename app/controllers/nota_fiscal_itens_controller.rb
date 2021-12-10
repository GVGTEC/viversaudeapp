class NotaFiscalItensController < ApplicationController
  before_action :set_nota_fiscal_item, only: %i[show edit update destroy]
  before_action :set_nota_fiscal

  def index
    @nota_fiscal_itens = NotaFiscalItem.where(nota_fiscal_id: @nota_fiscal.id)
  end

  def show; end

  def new
    @nota_fiscal_item = NotaFiscalItem.new

    @produtos = Produto.where(empresa_id: @adm.empresa.id)
    @produtos = @produtos.order('descricao asc')
    #@produtos = @produtos.joins('inner join estoques on estoques.produto_id = produtos.id')
    #@produtos = @produtos.having("sum(estoques.estoque_atual_lote) > '0'").group(:id, :descricao)
  end

  def edit; end

  def create
    if params[:nota_fiscal].key?(:nota_fiscal_item)
      NotaFiscalItem.where(nota_fiscal: @nota_fiscal.id).destroy_all

      params[:nota_fiscal][:nota_fiscal_item].each do |nota_fiscal_item|
        next if nota_fiscal_item[:cod_produto].blank?

        begin
          produto = Produto.find(nota_fiscal_item[:cod_produto])
          @nota_fiscal_item = NotaFiscalItem.new(
            nota_fiscal_id: @nota_fiscal.id,
            produto_id: produto.id,
            descricao: produto.descricao,
            cfop: nota_fiscal_item[:cfop],
            ncm: nota_fiscal_item[:ncm],
            unidade: nota_fiscal_item[:un],
            quantidade: nota_fiscal_item[:qtd],
            preco_unitario: formatar_preco(nota_fiscal_item[:preco_unitario]),
            preco_total: formatar_preco(nota_fiscal_item[:preco_total])
          )
          
          @nota_fiscal_item.save
        rescue StandardError => e
          flash[:error] = 'Erro no cadastramento. Verifique se todos os campos estão prenchidos corretamente.'
          redirect_to new_nota_fiscal_nota_fiscal_item_path(@nota_fiscal)
          return
        end
      end

      @nota_fiscal.valor_produtos = @nota_fiscal.nota_fiscal_itens.sum(:preco_total)
      @nota_fiscal.valor_total_nota = @nota_fiscal.calculo_valor_total_nota
      @nota_fiscal.save

      salvar_estoque
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

  def destroy
    @nota_fiscal_item.destroy
    respond_to do |format|
      format.html { redirect_to nota_fiscal_itens_url, notice: 'Nota fiscal item Excluído' }
      format.json { head :no_content }
    end
  end

  private

  def salvar_estoque
    return if params[:movimentos].blank?
    movimentos = JSON.parse(params[:movimentos])
    
    @nota_fiscal.salvar_movimento_estoque(movimentos)
    @nota_fiscal.salvar_nota_fiscal_item_lotes(movimentos)
    @nota_fiscal.calculo_imposto_nota
  end

  def set_nota_fiscal_item
    @nota_fiscal_item = NotaFiscalItem.find(params[:id])
  end

  def set_nota_fiscal
    @nota_fiscal = NotaFiscal.find(params[:nota_fiscal_id])
  end

  def formatar_preco(valor)
    valor.gsub('R$', '').to_f
  end

  def nota_fiscal_item_params
    params.require(:nota_fiscal_item).permit(:nota_fiscal_id, :produto_id, :descricao, :cfop, :st, :ncm, :cst, :unidade, :quantidade, :preco_unitario, :preco_total, :aliquota_icms, :valor_bc_icms, :valor_icms, :aliquota_icms_st, 
                                             :valor_bc_icms_st, :valor_icms_st, :aliquota_ipi, :valor_ipi, :aliquota_pis, :valor_pis, :aliquota_cofins, :valor_cofins, :aliquota_difal, :valor_difal, :valor_fcp, 
                                             :aliquota_fcp, :local_estoque, :baixou_estoque, :pagar_comissao_sn, :comissao_ven_pc, :comissao_ven_vr, :comissao_ter_pc, :comissao_ter_vr)
  end
end
