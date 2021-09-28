class ProdutosController < ApplicationController
  before_action :set_produto, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token, :only => [:importar]

  # GET /produtos or /produtos.json
  def index
    @produtos = Produto.all
    
    @produtos = @produtos.where("lower(descricao) ilike '%#{params[:descricao]}%'")

   # paginação na view index (lista)
    options = {page: params[:page] || 1, per_page: 50} 
    @produtos = @produtos.paginate(options)
  end

  def importar
    begin
      if params[:arquivo].blank?
        flash[:error] = "Selecione um arquivo .CSV"
        redirect_to "/produtos"
        return
      end
  
      if File.basename(params[:arquivo].tempfile).include?(".CSV")
        importar_csv
      else
        flash[:error] = "Formato de arquivo não suportado. Selecione um arquivo com a extensão .CSV"
        redirect_to "/produtos"
        return
      end
  
      flash[:sucesso] = "Produtos importados com sucesso"
      redirect_to "/produtos"
    rescue => exception
      flash[:error] = exception
      redirect_to "/produtos"
      return
    end
  end

  def importar_csv
    File.foreach(params[:arquivo].tempfile) do |line|
      d = CharlockHolmes::EncodingDetector.detect(line)
      line = line.to_s.encode("UTF-8", d[:encoding], invalid: :replace, replace: "")
      if line.present?
        importar_linha(line.split(";"))
      end
    end
  end

  def importar_linha(linha)
    id = 0
    codprd_sac = 
    situacao = 1 #se branco ele esta ativo
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
    margem_lucro = 17 #4 casas decimais
    preco_venda = 18
    margem_lucro_oferta = 19
    preco_oferta = 20
    data_inicial_oferta = 21
    data_final_oferta = 22
    controlar_estoque = 23
    estoque_atual = 24
    estoque_minimo = 25
    data_ultimo_reajuste = 28
    comissao_pc = 31
    bloquear_preco = 32
    localizacao_estoque_id = 33

        
    begin
      produto = Produto.new
      produto.id = linha[id].to_i
      produto.situacao = linha[situacao].present?? false : true
      produto.codigo_fabricante = linha[cod_fabricante]
      produto.codigo_barras = linha[codigo_barras]
      produto.descricao = linha[descricao]
      produto.descricao_nfe = linha[descricao_nfe]

      begin
        produto.fornecedor_id = Fornecedor.find(linha[fornecedor_id].to_i).id
      rescue 
        produto.fornecedor_id = Fornecedor.create(id: linha[fornecedor_id].to_i).id
      end

      produto.situacao_tributaria = linha[situacao_tributaria]
      produto.ncm = linha[ncm]
      produto.unidade = linha[unidade]
      produto.preco_custo_medio = separate_comma(linha[preco_custo_medio].to_i)
      produto.preco_custo = separate_comma(linha[preco_custo].to_i) 
      produto.margem_lucro = separate_margem(linha[margem_lucro].to_i) 
      produto.preco_venda = separate_comma(linha[preco_venda].to_i)
      produto.margem_lucro_oferta = separate_margem(linha[margem_lucro_oferta].to_i)
      produto.preco_oferta = separate_comma(linha[preco_oferta].to_i)
      produto.data_inicial_oferta = linha[data_inicial_oferta]
      produto.controlar_estoque = linha[controlar_estoque]
      produto.estoque_atual = linha[estoque_atual]
      produto.estoque_minimo = linha[estoque_minimo]
      produto.data_ultimo_reajuste = linha[data_ultimo_reajuste]
      produto.comissao_pc = linha[comissao_pc]
      produto.bloquear_preco = linha[bloquear_preco]

      begin
        produto.localizacao_estoque_id = LocalizacaoEstoque.find(linha[localizacao_estoque_id].to_i).id
      rescue 
        produto.localizacao_estoque_id = LocalizacaoEstoque.create(id: linha[localizacao_estoque_id].to_i).id
      end

      produto.save
    rescue Exception => err
      raise err
      Rails.logger.error err.message
    end
  end

  # GET /produtos/1 or /produtos/1.json
  def show
  end

  # GET /produtos/new
  def new
    @produto = Produto.new
  end

  # GET /produtos/1/edit
  def edit
  end

  # POST /produtos or /produtos.json
  def create
    @produto = Produto.new(produto_params)

    respond_to do |format|
      if @produto.save
        format.html { redirect_to produtos_path, notice: "Produto was successfully created." }
        format.json { render :show, status: :created, location: @produto }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @produto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /produtos/1 or /produtos/1.json
  def update
    respond_to do |format|
      if @produto.update(produto_params)
        format.html { redirect_to produtos_path, notice: "Produto was successfully updated." }
        format.json { render :show, status: :ok, location: @produto }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @produto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /produtos/1 or /produtos/1.json
  def destroy
    @produto.destroy
    respond_to do |format|
      format.html { redirect_to produtos_url, notice: "Produto was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_produto
      @produto = Produto.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def produto_params
      params.require(:produto).permit(:localizacao_estoque_id, :situacao, :data_inativo, :descricao, :descricao_nfe, :codigo_barras, :ncm, :situacao_tributaria, :unidade, :embalagem, :controlar_estoque, :por_lote, :bloquear_preco, :data_ultima_reposicao, :data_ultimo_reajuste, :preco_custo, :preco_custo_medio, :margem_lucro, :preco_venda, :preco_oferta, :margem_lucro_oferta, :data_inicial_oferta, :data_final_oferta, :comissao_pc)
    end

    def separate_comma(number)
      reverse_digits = number.to_s.chars.reverse
      reverse_digits.each_slice(2).map(&:join).join(",").reverse.to_f
    end

    def separate_margem(number)
      reverse_digits = number.to_s.chars.reverse
      reverse_digits.each_slice(4).map(&:join).join(",").reverse.to_f
    end
end
