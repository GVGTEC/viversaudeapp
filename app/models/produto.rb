class Produto < ApplicationRecord
  belongs_to :localizacao_estoque, optional: true
  belongs_to :fornecedor, optional: true
  belongs_to :empresa

  has_many :estoques, dependent: :delete_all

  def self.atualizar_produto_reposto(estoque, params)
    produto = estoque.produto
    produto.preco_custo_medio = estoque.calculo_preco_custo_medio
    produto.estoque_atual += estoque.estoque_atual_lote
    produto.preco_custo = estoque.preco_custo_reposicao
    produto.preco_venda = params[:preco_venda]
    produto.save
  end

  def verifica_detalhes_ncm(codigo_ncm)
    require 'net/http'

    uri = URI.parse("https://api.cosmos.bluesoft.com.br/ncms/#{codigo_ncm}/products")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(uri.request_uri)
    request['User-Agent'] = 'Cosmos-API-Request'
    request['Content-Type'] = 'application/json'
    request['X-Cosmos-Token'] = 'J4Tu_5FaHTXM0SaYGUrUjQ'
    response = http.request(request)
    Rails.logger.debug response.body
  end

  def tipo_situacao_tributaria
    case situacao_tributaria
    when 'T'
      'Tributada integralmente'
    when 'I'
      'Isento' 
    when 'S'
      'ICMS cobrado anteriormente por substituição tributária'
    else
      'Não tributada'
    end
  end

  def self.all_params
    %i[
      localizacao_estoque_id fornecedor_id codprd_sac situacao data_inativo descricao descricao_nfe codigo_fabricante codigo_barras ncm situacao_tributaria unidade embalagem controlar_estoque por_lote bloquear_preco data_ultima_reposicao data_ultimo_reajuste preco_custo preco_custo_medio margem_lucro preco_venda preco_oferta margem_lucro_oferta data_inicial_oferta data_final_oferta comissao_pc estoque_atual estoque_minimo origem
    ]
  end

  def self.importar_linha(empresa, linha)
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

    produto = empresa.produtos.find_by(codprd_sac: linha[codprd_sac])
    produto ||= empresa.produtos.new

    produto.codprd_sac = linha[codprd_sac].strip rescue linha[codprd_sac]
    produto.situacao = linha[situacao].presence || 'ATIVO'
    produto.codigo_fabricante = linha[codigo_fabricante].strip rescue linha[codigo_fabricante]
    produto.codigo_barras = linha[codigo_barras].strip rescue linha[codigo_barras]
    produto.descricao = linha[descricao].strip rescue linha[descricao]
    produto.descricao_nfe = linha[descricao_nfe].strip rescue linha[descricao_nfe]
    produto.situacao_tributaria = linha[situacao_tributaria].strip rescue linha[situacao_tributaria]
    produto.ncm = linha[ncm].strip rescue linha[ncm]
    produto.unidade = linha[unidade].strip rescue linha[unidade]
 
    produto.preco_custo_medio = linha[preco_custo_medio].to_f / 100
    produto.preco_custo = linha[preco_custo].to_f / 100
    produto.margem_lucro = linha[margem_lucro].to_f / 10000
    produto.preco_venda = linha[preco_venda].to_f / 100
    produto.margem_lucro_oferta = linha[margem_lucro_oferta].to_f / 10000
    produto.preco_oferta = linha[preco_oferta].to_f / 100
        
    produto.data_inicial_oferta = Estoque.formatar_data(linha[data_inicial_oferta])
    produto.controlar_estoque = linha[controlar_estoque] == "S"
    produto.estoque_atual = (linha[estoque_atual].to_i / 100) rescue linha[estoque_atual].to_i
    produto.estoque_minimo = (linha[estoque_minimo].to_i / 100) rescue linha[estoque_minimo].to_i
    produto.data_ultimo_reajuste = Estoque.formatar_data(linha[data_ultimo_reajuste])
    produto.comissao_pc = linha[comissao_pc].to_i
    produto.bloquear_preco = linha[bloquear_preco].present?
    
    fornecedor = linha[fornecedor_id].to_i
    produto.fornecedor_id = Fornecedor.find_or_create_by(id: fornecedor, empresa_id: empresa.id).id unless fornecedor.zero?

    localizacao_estoque = linha[localizacao_estoque_id].to_i
    produto.localizacao_estoque_id = LocalizacaoEstoque.find_or_create_by(id: localizacao_estoque, empresa_id: empresa.id).id unless localizacao_estoque.zero?
  
    produto.save
  end
end
