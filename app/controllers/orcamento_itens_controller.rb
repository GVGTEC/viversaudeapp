class OrcamentoItensController < ApplicationController
  before_action :set_orcamento_item, only: %i[show edit update destroy]
  before_action :set_orcamento

  def index
    @orcamento_itens = OrcamentoItem.where(orcamento_id: @orcamento.id)
  end

  def show; end

  def new
    @orcamento_item = OrcamentoItem.new

    @produtos = Produto.where(empresa_id: @adm.empresa.id)
    @produtos = @produtos.order('descricao asc')
    #@produtos = @produtos.joins('inner join estoques on estoques.produto_id = produtos.id')
    #@produtos = @produtos.having("sum(estoques.estoque_atual_lote) > '0'").group(:id, :descricao)
  end

  def edit; end

  def create
    if params[:orcamento].key?(:orcamento_item)
      OrcamentoItem.where(orcamento: @orcamento.id).destroy_all

      params[:orcamento][:orcamento_item].each do |orcamento_item|
        next if orcamento_item[:cod_produto].blank?

        begin
          produto = Produto.find(orcamento_item[:cod_produto])
          @orcamento_item = OrcamentoItem.new(
            orcamento_id: @orcamento.id,
            produto_id: produto.id,
            quantidade: orcamento_item[:qtd],
            preco_unitario: formatar_preco(orcamento_item[:preco_unitario]),
            preco_total: formatar_preco(orcamento_item[:preco_total])
          )
          
          @orcamento_item.save
        rescue StandardError => e
          flash[:error] = 'Erro no cadastramento. Verifique se todos os campos estão prenchidos corretamente.'
          redirect_to new_orcamento_orcamento_item_path(@orcamento)
          return
        end
      end

      @orcamento.valor_sub_total = @orcamento.orcamento_itens.sum(:preco_total)
      #@orcamento.valor_total = @orcamento.calculo_valor_total_nota
      @orcamento.valor_total = @orcamento.valor_sub_total.to_f - @orcamento.valor_desconto.to_f
      @orcamento.save

      debugger

      #salvar_estoque
    end

    respond_to do |format|
      format.html do
        #redirect_to new_orcamento_orcamento_duplicata_path(@orcamento), notice: 'Orçamento Item Cadastrado'
        redirect_to '/orcamentos'
      end
    end
  end

  # PATCH/PUT /orcamento_itens/1 or /orcamento_itens/1.json
  def update
    respond_to do |format|
      if @orcamento_item.update(orcamento_item_params)
        format.html { redirect_to @orcamento_item, notice: 'Orçamento Item Alterado' }
        format.json { render :show, status: :ok, location: @orcamento_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @orcamento_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @orcamento_item.destroy
    respond_to do |format|
      format.html { redirect_to orcamento_itens_url, notice: 'Orçamento Item Excluído' }
      format.json { head :no_content }
    end
  end

  private

  def set_orcamento_item
    @orcamento_item = OrcamentoItem.find(params[:id])
  end

  def set_orcamento
    @orcamento = Orcamento.find(params[:orcamento_id])
  end

  def formatar_preco(valor)
    valor.gsub('.', '').gsub('R$', '').to_f
  end

  def orcamento_item_params
    params.require(:orcamento_item).permit(:orcamento_id, :produto_id, :quantidade, :preco_unitario, :preco_total)
  end
end
