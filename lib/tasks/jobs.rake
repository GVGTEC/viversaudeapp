namespace :jobs do
  desc 'Download TxT'
  task download_txt: :environment do
    out_file = File.new('tmp/nota.txt', 'w')
    # ...
    out_file.puts('write your stuff here')
    # ...
    out_file.close
    # send_file "/tmp/nota.txt"
  end

  desc 'Deletar Todos'
  task deletar_todos: :environment do
    Fornecedor.delete_all
    LocalizacaoEstoque.delete_all
    Vendedor.delete_all
    Terceiro.delete_all
    Produto.delete_all
    Cliente.delete_all
  end

  desc 'Verifica Detalhes Ncm'
  task verifica_detalhes_ncm: :environment do
    require 'net/http'

    codigo_ncm = '36041000'

    uri = URI.parse("https://api.cosmos.bluesoft.com.br/ncms/#{codigo_ncm}/products")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(uri.request_uri)
    request['User-Agent'] = 'Cosmos-API-Request'
    request['Content-Type'] = 'application/json'
    request['X-Cosmos-Token'] = 'J4Tu_5FaHTXM0SaYGUrUjQ'
    response = http.request(request)
    puts response.body
  end
end
