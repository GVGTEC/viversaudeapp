Rails.application.routes.draw do
  resources :cfop
  resources :empresas
  resources :terceiros
  resources :contas_pag
  resources :vendedores
  resources :contas_rec
  resources :plano_contas
  resources :fornecedores
  resources :administradores
  resources :transportadoras
  resources :localizacao_estoques

  resources :orcamentos do
    resources :orcamento_itens
  end

  resources :nota_fiscais do
    get "/gerar_nota", to: "nota_fiscais#gerar_nota"
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

  get "/importar_clientes", to: "importar#clientes"
  get "/importar_fornecedores", to: "importar#fornecedores"
  get "/importar_produtos", to: "importar#produtos"
  get "/importar_estoques", to: "importar#estoques"

  root to: 'home#index'

  get '/login', to: 'login#index'
  post '/login', to: 'login#logar'
  get '/sair', to: 'login#deslogar'
end
