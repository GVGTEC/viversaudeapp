class ProdutosController < ApplicationController
  before_action :set_produto, only: %i[show edit update destroy]
  skip_before_action :verify_authenticity_token, only: [:importar]

  def index
    @produtos = empresa.produtos
    @produtos = @produtos.order('descricao asc')
    @produtos = @produtos.where("lower(descricao_nfe) ilike '%#{params[:descricao]}%'") if params[:descricao].present?
    @produtos = @produtos.where(id: params[:codigo]) if params[:codigo].present?

    # paginação na view index (lista)
    if params[:format] == 'json'
      @produtos = @produtos.joins('inner join estoques on estoques.produto_id = produtos.id')
      @produtos = @produtos.having("sum(estoques.estoque_atual_lote) > '0'").group(:id, :descricao)
      return
    end

    #respond_to do |format|
    #  format.html
    #  format.json
    #  format.pdf
    #    {render template: 'produtos/relatorio', pdf: 'relatorio'}
    #end

    options = { page: params[:page] || 1, per_page: 100 }
    @produtos = @produtos.paginate(options)
  end

  #if params[:gerar_pdf].present?
  #  render pdf: "Relatorio"
  #    template: "produtos/index.pdf.erb"
  #    layout: "pdf.html"
  #  return
  #end

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
      importar_linha(line.split(';')) if line.present?
    end
  end

  def importar_linha(linha)
    codprd_sac = 0
    situacao = 1 # se branco ele esta ativo
    codigo_fabricante = 2
    codigo_barras = 3
    descricao = 4
    descricao_nfe = 5
    fornecedor_id = 6
    situacao_tributaria = 10
    ncm = 12
    unidade = 14
    preco_custo_medio = 15 # duas casas decimais
    preco_custo = 16 # duas casas decimais
    margem_lucro = 17 # 4 casas decimais
    preco_venda = 18
    margem_lucro_oferta = 19
    preco_oferta = 20
    data_inicial_oferta = 21
    controlar_estoque = 23
    estoque_atual = 24
    estoque_minimo = 25
    data_ultimo_reajuste = 28
    comissao_pc = 31
    bloquear_preco = 32
    localizacao_estoque_id = 33

    produto = Produto.find_by(codprd_sac: linha[codprd_sac])
    produto ||= Produto.new

    produto.codprd_sac = linha[codprd_sac].strip rescue linha[codprd_sac]
    produto.situacao = linha[situacao].presence || 'ATIVO'
    produto.codigo_fabricante = linha[codigo_fabricante].strip rescue linha[codigo_fabricante]
    produto.codigo_barras = linha[codigo_barras].strip rescue linha[codigo_barras]
    produto.descricao = linha[descricao].strip rescue linha[descricao]
    produto.descricao_nfe = linha[descricao_nfe].strip rescue linha[descricao_nfe]
    produto.situacao_tributaria = linha[situacao_tributaria].strip rescue linha[situacao_tributaria]
    produto.ncm = linha[ncm].strip rescue linha[ncm]
    produto.unidade = linha[unidade].strip rescue linha[unidade]

    #produto.preco_custo_medio = separate_comma(linha[preco_custo_medio].to_i)   
    #produto.preco_custo = separate_comma(linha[preco_custo].to_i)
    #produto.margem_lucro = separate_margem(linha[margem_lucro].to_i)
    #produto.preco_venda = separate_comma(linha[preco_venda].to_i)
    #produto.margem_lucro_oferta = separate_margem(linha[margem_lucro_oferta].to_i)
    #produto.preco_oferta = separate_comma(linha[preco_oferta].to_i)
 
    produto.preco_custo_medio = linha[preco_custo_medio].to_f / 100
    produto.preco_custo = linha[preco_custo].to_f / 100
    produto.margem_lucro = linha[margem_lucro].to_f / 10000
    produto.preco_venda = linha[preco_venda].to_f / 100
    produto.margem_lucro_oferta = linha[margem_lucro_oferta].to_f / 10000
    produto.preco_oferta = linha[preco_oferta].to_f / 100
    
    #debugger
    
    produto.data_inicial_oferta = Estoque.formatar_data(linha[data_inicial_oferta])
    produto.controlar_estoque = linha[controlar_estoque] == "S"
    produto.estoque_atual = (linha[estoque_atual].to_i / 100) rescue linha[estoque_atual].to_i
    produto.estoque_minimo = (linha[estoque_minimo].to_i / 100) rescue linha[estoque_minimo].to_i
    produto.data_ultimo_reajuste = Estoque.formatar_data(linha[data_ultimo_reajuste])
    produto.comissao_pc = linha[comissao_pc].to_i
    produto.bloquear_preco = linha[bloquear_preco].present?
    produto.empresa_id = empresa.id
    
    fornecedor = linha[fornecedor_id].to_i
    produto.fornecedor_id = Fornecedor.find_or_create_by(id: fornecedor, empresa_id: empresa.id).id unless fornecedor.zero?

    localizacao_estoque = linha[localizacao_estoque_id].to_i
    produto.localizacao_estoque_id = LocalizacaoEstoque.find_or_create_by(id: localizacao_estoque, empresa_id: empresa.id).id unless localizacao_estoque.zero?
  
    produto.save
  end

  def show
    respond_to do |format|
      format.html
      format.pdf do
        #render pdf: "file name", template: "produtos/show.html.erb"
        render pdf: "Produto id: #{@produto.id}", template: "produtos/relatorio.pdf.html.erb"
      end
    end
  end

  def new
    @produto = Produto.new
  end

  def edit; end

  def create
    @produto = Produto.new(produto_params)
    @produto.empresa_id = @adm.empresa.id

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
    #debugger
    respond_to do |format|
      if @produto.update(produto_params)
        #@produto.preco_custo = produto_params[:preco_custo].tr(",",".")
        #@produto.save
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
    @produto = Produto.find(params[:id])
  end
                                             
  def produto_params
    params.require(:produto).permit(:localizacao_estoque_id, :fornecedor_id, :codprd_sac, :situacao, :data_inativo, :descricao, :descricao_nfe, :codigo_fabricante, :codigo_barras, :ncm, :situacao_tributaria, :unidade, 
                                    :embalagem, :controlar_estoque, :por_lote, :bloquear_preco, :data_ultima_reposicao, :data_ultimo_reajuste, :preco_custo, :preco_custo_medio, :margem_lucro, :preco_venda, 
                                    :preco_oferta, :margem_lucro_oferta, :data_inicial_oferta, :data_final_oferta, :comissao_pc, :estoque_atual, :estoque_minimo, :origem)
  end

  def separate_comma(number)
    #debugger
    reverse_digits = number.to_s.chars.reverse
    reverse_digits.each_slice(2).map(&:join).join(',').reverse.to_f
  end

  def separate_margem(number)
    reverse_digits = number.to_s.chars.reverse
    reverse_digits.each_slice(4).map(&:join).join(',').reverse.to_f
  end
end
