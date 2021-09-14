namespace :jobs do
  desc "Download TxT"
  task download_txt: :environment do
    out_file = File.new("tmp/nota.txt", "w")
    #...
    out_file.puts("write your stuff here")
    #...
    out_file.close

    #send_file "/tmp/nota.txt"
  end

  desc "Deletar Todos"
  task deletar_todos: :environment do
    Fornecedor.delete_all
    LocalizacaoEstoque.delete_all
    Vendedor.delete_all
    Terceiro.delete_all
    Produto.delete_all
    Cliente.delete_all
  end
end