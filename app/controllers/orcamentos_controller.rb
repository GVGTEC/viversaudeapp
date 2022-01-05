class OrcamentosController < ApplicationController
  before_action :set_orcamento, only: %i[show edit update destroy]

#  if params[:gerar_pdf].present?
#    render pdf: "Invoice No",
#    page_size: "A4"
#    template: "orcamentos/index.pdf.erb",
#    layout: "pdf.html.erb
#    lowquality: true,
#    zoom:1
#    dpi: 75
#    return
#  end

  def relatorio
    render pdf: "file",
    template: "orcamento/relatorio.pdf.erb",
    #layout: "pdf.html.erb"
    layout: "relatorio.pdf.erb"
  end

  def index
    #@nota_fiscais = empresa.nota_fiscais (HABILITAR QUANDO CRIAR O CAMPO EMPRESA NO ORCAMENTO)

    @orcamentos = Orcamento.all
    @orcamentos = @orcamentos.order('Id desc')
   
    # @orcamentos = Orcamento.where(empresa_id: @adm.empresa.id)   O CAMPO EMPRESA_ID AINDA NÃO EXISTE NA TABELA DE ORÇAMENTO

    options = { page: params[:page] || 1, per_page: 50 }
    @orcamentos = @orcamentos.paginate(options)
  end

  def show; end

  def new
    @orcamento = Orcamento.new
    @orcamento.data_emissao = Time.zone.now.strftime('%Y-%m-%dT%H:%M')
  end

  def edit; end

  def create
    @orcamento = Orcamento.new(orcamento_params)

    respond_to do |format|
      if @orcamento.save

        # format.html { redirect_to @orcamento, notice: "Orçamento Cadastrado" }
        format.html { redirect_to new_orcamento_orcamento_item_path(@orcamento)}
        format.json { render :show, status: :created, location: @orcamento }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @orcamento.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @orcamento.update(orcamento_params)
        #format.html { redirect_to @orcamento, notice: 'Orçamento Alterado' }
        format.html { redirect_to new_orcamento_orcamento_item_path(@orcamento), notice: '' }
        format.json { render :show, status: :ok, location: @orcamento }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @orcamento.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @orcamento.destroy
    respond_to do |format|
      format.html { redirect_to orcamentos_url, notice: 'Orcamento Excluído' }
      format.json { head :no_content }
    end
  end

  private

  def set_orcamento
    @orcamento = Orcamento.find(params[:id])
  end

  def orcamento_params
    params.require(:orcamento).permit(:cliente_id, :vendedor_id, :data_emissao, :valor_sub_total, :valor_desconto, :valor_total, :observacao, :flag)
  end
end
