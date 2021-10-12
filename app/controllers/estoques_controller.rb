class EstoquesController < ApplicationController
  before_action :set_estoque, only: %i[show]
  skip_before_action :verify_authenticity_token, only: [:importar]

  def index
    @estoques = Estoque.where(empresa_id: @adm.empresa.id)
    @estoques = @estoques.where(produto_id: params[:produto_id]) if params[:produto_id].present?

    # paginação na view index (lista)
    options = { page: params[:page] || 1, per_page: 10 }
    @estoques = @estoques.paginate(options)
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
    estoque.codprd_sac = linha[codprd_sac]

    if Produto.find_by(codprd_sac: linha[codprd_sac]).present?
      estoque.produto_id = Produto.find_by(codprd_sac: linha[codprd_sac]).id
    end

    estoque.lote = linha[lote]

    if linha[fornecedor_id].to_i.positive?
      begin
        estoque.fornecedor_id = Fornecedor.find(linha[fornecedor_id].to_i).id
      rescue StandardError
        estoque.fornecedor_id = Fornecedor.create(id: linha[fornecedor_id].to_i).id
      end
    end

    # estoque.quantidade = linha[quantidade]
    estoque.estoque_atual_lote = linha[estoque_atual_lote]
    # estoque.saidas = linha[saidas]

    estoque.preco_custo_reposicao = separate_comma(linha[preco_custo_reposicao].to_i)
    estoque.data_reposicao = linha[data_reposicao]
    estoque.data_validade = linha[data_validade]
    estoque.empresa_id = @adm.empresa.id

    estoque.save
  end

  def show; end

  def reposicao
    params[:data_reposicao] ||= Time.zone.now.strftime('%Y-%m-%d')
    @estoque = Estoque.new
    @estoque.fornecedor_id = params[:fornecedor_id] if params[:fornecedor_id].present?
    @estoque.documento = params[:documento] if params[:documento].present?
    @estoque.data_reposicao = params[:data_reposicao]
  end

  def create_reposicao
    @estoque = Estoque.new(estoque_reposicao_params.merge(ultima_alteracao: 'REP'))
    @estoque.empresa_id = @adm.empresa.id

    if @estoque.save
      update_produto_reposicao

      movimento_estoque = MovimentoEstoque.new
      movimento_estoque.estoque_id = @estoque.id
      movimento_estoque.produto_id = @estoque.produto_id
      movimento_estoque.origem = @estoque.ultima_alteracao
      movimento_estoque.data = @estoque.updated_at
      movimento_estoque.qtd = @estoque.estoque_atual_lote
      movimento_estoque.estoque_inicial = 0
      movimento_estoque.estoque_final = @estoque.estoque_atual_lote
      movimento_estoque.preco_custo = @estoque.preco_custo_reposicao
      movimento_estoque.save

      path_with_params = "/estoques/reposicao?fornecedor_id=#{@estoque.fornecedor_id}&documento=#{@estoque.documento}&data_reposicao=#{@estoque.data_reposicao}"
      redirect_to path_with_params
    end
  end

  def ajuste
    @estoque = Estoque.new
    @params = '/estoques/ajuste'
    updated_ajuste if params[@params]
  end

  def baixa
    @estoque = Estoque.new
    @params = '/estoques/baixa'
    updated_baixa if params[@params]
  end

  private

  def set_estoque
    @estoque = Estoque.find(params[:id])
  end

  def updated_ajuste
    @estoque = Estoque.find(params[:id])
    estoque_atual_lote = @estoque.estoque_atual_lote
    qtd_estoque_final = (@estoque.produto.estoque_atual - @estoque.estoque_atual_lote) + estoque_ajuste_params[:estoque_atual_lote].to_f
    @estoque.estoque_atual_lote = estoque_ajuste_params[:estoque_atual_lote]
    @estoque.ultima_alteracao = 'AJU'

    if @estoque.save
      movimento_estoque = MovimentoEstoque.new
      movimento_estoque.estoque_id = @estoque.id
      movimento_estoque.produto_id = @estoque.produto_id
      movimento_estoque.origem = @estoque.ultima_alteracao
      movimento_estoque.data = @estoque.updated_at
      movimento_estoque.qtd = 0
      movimento_estoque.estoque_inicial = estoque_atual_lote
      movimento_estoque.estoque_final = @estoque.estoque_atual_lote
      movimento_estoque.preco_custo = @estoque.produto.preco_custo
      movimento_estoque.save

      produto = @estoque.produto
      produto.estoque_atual = qtd_estoque_final
      produto.save

      redirect_to estoques_path
    end
  end

  def updated_baixa
    @estoque = Estoque.find(params[:id])
    estoque_atual_lote = @estoque.estoque_atual_lote
    @estoque.estoque_atual_lote = estoque_atual_lote - params[:estoque_atual_lote].to_f
    @estoque.ultima_alteracao = 'BAI'

    if @estoque.save
      movimento_estoque = MovimentoEstoque.new
      movimento_estoque.estoque_id = @estoque.id
      movimento_estoque.produto_id = @estoque.produto_id
      movimento_estoque.origem = @estoque.ultima_alteracao
      movimento_estoque.data = @estoque.updated_at
      movimento_estoque.estoque_inicial = estoque_atual_lote
      movimento_estoque.qtd = params[:estoque_atual_lote].to_f
      movimento_estoque.estoque_final = @estoque.estoque_atual_lote
      movimento_estoque.preco_custo = @estoque.produto.preco_custo
      movimento_estoque.save

      produto = @estoque.produto
      produto.estoque_atual -= params[:estoque_atual_lote].to_f
      produto.save

      redirect_to estoques_path
    end
  end

  def update_produto_reposicao
    produto = @estoque.produto
    produto.preco_custo_medio = @estoque.calculo_preco_custo_medio
    produto.estoque_atual += @estoque.estoque_atual_lote
    produto.preco_custo = @estoque.preco_custo_reposicao
    produto.margem_lucro = params[:margem_lucro]
    produto.preco_venda = params[:preco_venda]
    produto.save
  end

  def estoque_reposicao_params
    params.require('/estoques/reposicao').permit(:produto_id, :fornecedor_id, :lote, :documento, :ultima_alteracao,
                                                 :estoque_atual_lote, :data_reposicao, :data_validade, :estoque_reservado, :preco_custo_reposicao)
  end

  def estoque_ajuste_params
    params.require('/estoques/ajuste').permit(:produto_id, :fornecedor_id, :lote, :documento, :ultima_alteracao,
                                              :estoque_atual_lote, :data_reposicao, :data_validade, :estoque_reservado, :preco_custo_reposicao)
  end

  def estoque_baixa_params
    params.require('/estoques/baixa').permit(:produto_id, :fornecedor_id, :lote, :documento, :ultima_alteracao,
                                             :estoque_atual_lote, :data_reposicao, :data_validade, :estoque_reservado, :preco_custo_reposicao)
  end

  def separate_comma(number)
    reverse_digits = number.to_s.chars.reverse
    reverse_digits.each_slice(2).map(&:join).join(',').reverse.to_f
  end

  def separate_margem(number)
    reverse_digits = number.to_s.chars.reverse
    reverse_digits.each_slice(4).map(&:join).join(',').reverse.to_f
  end
end
