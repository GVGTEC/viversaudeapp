class ProdutosController < ApplicationController
  before_action :set_produto, only: %i[show edit update destroy]
  skip_before_action :verify_authenticity_token, only: [:importar]

  def index
    @produtos = empresa.produtos
    @produtos = @produtos.order(:descricao)
    @produtos = @produtos.where(id: params[:codigo]) if params[:codigo].present?

    if params[:busca].present?
      @produtos = @produtos.where("(lower(descricao_nfe) ilike '%#{params[:busca].downcase.strip}%') OR(id = #{params[:busca].downcase.strip})")
    end

    if params[:format] == 'json'
      @produtos = @produtos.joins(:estoques).having("sum(estoques.estoque_atual_lote) > '0'").group(:id, :descricao)
      return
    end

    options = { page: params[:page] || 1, per_page: 10 }
    @produtos = @produtos.paginate(options)
  end

  def importar
    if params[:arquivo].blank?
      flash[:error] = 'Selecione um arquivo .CSV'
      redirect_to '/produtos'
      return
    end

    if File.basename(params[:arquivo].tempfile).include?('.CSV')
      importar_csv
    else
      flash[:error] = 'Formato de arquivo não suportado. Selecione um arquivo com a extensão .CSV'
      redirect_to '/produtos'
      return
    end

    flash[:sucesso] = 'Produtos importados com Sucesso'
    redirect_to '/produtos'
  rescue StandardError => e
    flash[:error] = e
    redirect_to '/produtos'
    nil
  end

  def importar_csv
    File.foreach(params[:arquivo].tempfile) do |line|
      d = CharlockHolmes::EncodingDetector.detect(line)
      line = line.to_s.encode('UTF-8', d[:encoding], invalid: :replace, replace: '')
      empresa.produtos.importar_linha(empresa, line.split(';')) if line.present?
    end
  end


  def show
    return unless params[:format] == "pdf"
    render pdf: "Produto id: #{@produto.id}", template: "produtos/relatorio.pdf.html.erb"
  end

  def new
    @produto = empresa.produtos.new
  end

  def edit; end

  def create
    @produto = empresa.produtos.build(produto_params)

    respond_to do |format|
      if @produto.save
        format.html { redirect_to produtos_path, notice: 'Produto Cadastrado' }
        format.json { render :show, status: :created, location: @produto }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @produto.errors, status: :unprocessable_entity }
      end
    end
  end

  def update   
    respond_to do |format|
      if @produto.update(produto_params)
        format.html { redirect_to produtos_path, notice: 'Produto Alterado' }
        format.json { render :show, status: :ok, location: @produto }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @produto.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @produto.destroy
    respond_to do |format|
      format.html { redirect_to produtos_url, notice: 'Produto Excluído' }
      format.json { head :no_content }
    end
  end

  private

  def set_produto
    @produto = empresa.produtos.find(params[:id])
  end
                                             
  def produto_params
    params.require(:produto).permit(Produto.all_params)
  end
end
