class Produto < ApplicationRecord
  belongs_to :localizacao_estoque, optional: true
  belongs_to :fornecedor, optional: true
  belongs_to :empresa

  def self.atualizar_produto_reposto(estoque, params)
    produto = estoque.produto
    produto.preco_custo_medio = estoque.calculo_preco_custo_medio
    produto.estoque_atual += estoque.estoque_atual_lote
    produto.preco_custo = estoque.preco_custo_reposicao
    produto.preco_venda = params[:preco_venda]
    produto.save
  end

  def verifica_detalhes_ncm(codigo_ncm)
    require "net/http"

    uri = URI.parse("https://api.cosmos.bluesoft.com.br/ncms/#{codigo_ncm}/products")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(uri.request_uri)
    request["User-Agent"] = "Cosmos-API-Request"
    request["Content-Type"] = "application/json"
    request["X-Cosmos-Token"] = "J4Tu_5FaHTXM0SaYGUrUjQ"
    response = http.request(request)
    puts response.body
  end
end
