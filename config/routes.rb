Rails.application.routes.draw do
  resources :contas_rec
  resources :terceiros
  resources :cfop
  resources :administradores
  resources :vendedores
  resources :transportadoras
  resources :contas_pag
  resources :plano_contas
  resources :empresas
  resources :localizacao_estoques
  resources :fornecedores

  get "/nota_fiscais/download_txt", to: "nota_fiscais#download_txt"
  resources :nota_fiscais do
    resources :nota_fiscal_itens
    resources :nota_fiscal_duplicatas, only: [:new, :create]
  end

  get "/estoques/ajuste", to: "estoques#ajuste"
  get "/estoques/reposicao", to: "estoques#reposicao"
  get "/estoques/baixa", to: "estoques#baixa"
  post "/estoques/ajuste", to: "estoques#ajuste"
  post "/estoques/reposicao", to: "estoques#create_reposicao"
  post "/estoques/baixa", to: "estoques#baixa"
  resources :estoques, only: [:index, :show]
  
  post "/produtos/importar", to: "produtos#importar"

  resources :produtos do
    resources :movimento_estoques, only: [:index] 
  end
  
  post "/clientes/importar", to: "clientes#importar"
  resources :clientes

  get "/importar/clientes", to: "importar#clientes"

  get "/importar_fornecedor/importar", to: "importar_fornecedores#importar"
  post "/importar_fornecedor/importar_arquivo", to: "importar_fornecedores#importar_arquivo"

  get "/importar_cliente/importar", to: "importar_clientes#importar"
  post "/importar_cliente/importar_arquivo", to: "importar_clientes#importar_arquivo"


  get "/importar_produto/importar", to: "importar_produtos#importar"
  post "/importar_produto/importar_arquivo", to: "importar_produtos#importar_arquivo"

  get "/importar_estoque/importar", to: "importar_estoques#importar"
  post "/importar_estoque/importar_arquivo", to: "importar_estoques#importar_arquivo"

  root to: "home#index"
end
