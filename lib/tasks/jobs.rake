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

  desc 'Teste Symbol'
  task teste_symbol: :environment do
    nome = :thiago_carlos

    puts "Hola, #{nome}"
  end

  desc 'Atualizar estoque sem validade'
  task estoque_sem_validade: :environment do
    Estoque.where(produto_id: nil).delete_all
  end

  desc 'Setval Atualizar Ids'
  task setval_atualizar_ids: :environment do
    tables = ActiveRecord::Base.connection.tables
    tables.each do |table|
      if table.classify.constantize.column_names.include?('id')
        ActiveRecord::Base.connection.exec_query("
            SELECT setval(pg_get_serial_sequence('#{table}', 'id'), max(id)) FROM #{table}
          ")
      end
    rescue StandardError => e
      puts "Não Funcionou - #{e}"
    end
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
