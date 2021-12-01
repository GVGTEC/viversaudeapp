class EstoquesController < ApplicationController
  before_action :set_estoque, only: %i[show]
  skip_before_action :verify_authenticity_token, only: [:importar]

  def index
    @estoques = empresa.estoques
    @estoques = @estoques.where("lote ilike '%#{params[:lote]}%'") if params[:lote].present?
    @estoques = @estoques.where(produto_id: params[:produto_id]) if params[:produto_id].present?
    
    # paginação na view index (lista)
    if params[:format] != 'json'
      options = { page: params[:page] || 1, per_page: 10 }
      @estoques = @estoques.paginate(options)
    end
  end

  def importar
    if params[:arquivo].blank?
      flash[:error] = 'Selecione um arquivo .CSV'
      redirect_to '/importar_estoque/importar'
      return
    end

    if File.basename(params[:arquivo].tempfile).include?('.CSV')
      importar_csv
    else
      flash[:error] = 'Formato de arquivo não suportado. Selecione um arquivo com a extensão .CSV'
      redirect_to '/importar_estoques'
      return
    end

    flash[:sucesso] = 'Estoques importados com sucesso'
    redirect_to estoques_path
  rescue StandardError => e
    flash[:error] = e
    redirect_to '/importar_estoques'
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
    lote = 1 # se branco ele esta ativo
    fornecedor_id = 2
    estoque_atual_lote = 4 # duas casas decimais
    preco_custo_reposicao = 6 # duas casas decimais
    data_reposicao = 8
    data_validade = 9

    estoque = Estoque.new
   
    if linha[fornecedor_id].to_i.positive?
      begin
        estoque.fornecedor_id = Fornecedor.find(linha[fornecedor_id].to_i).id
      rescue StandardError
        estoque.fornecedor_id = Fornecedor.create(id: linha[fornecedor_id].to_i).id
      end
    end

    produto = Produto.find_by(codprd_sac: linha[codprd_sac])

    estoque.produto_id = produto.id if produto.present?
    estoque.codprd_sac = linha[codprd_sac]
    estoque.lote = linha[lote]
    estoque.estoque_atual_lote = linha[estoque_atual_lote]
    estoque.preco_custo_reposicao = separar_virgula(linha[preco_custo_reposicao].to_i)
    estoque.data_reposicao = linha[data_reposicao]
    estoque.data_validade = linha[data_validade]
    estoque.empresa_id = @adm.empresa.id

    estoque.save
  end

  def show
  end

  private
    def set_estoque
      @estoque = Estoque.find(params[:id])
    end

    def separar_virgula(number)
      reverse_digits = number.to_s.chars.reverse
      reverse_digits.each_slice(2).map(&:join).join(',').reverse.to_f
    end

    def estoque_params
      params.require(:estoque).permit(:produto_id, :fornecedor_id, :lote, :documento, :ultima_alteracao, :estoque_atual_lote, :data_reposicao, :data_validade, :estoque_reservado, :preco_custo_reposicao)
    end
end
