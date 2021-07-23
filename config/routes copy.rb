Rails.application.routes.draw do
  resources :nota_fiscal_itens
  resources :contas_rec
  resources :terceiros
  resources :nota_fiscais
  resources :cfop
  resources :administradores
  resources :vendedores
  resources :transportadoras
  resources :contas_pag
  resources :plano_contas
  resources :empresas
  resources :localizacao_estoques
  resources :fornecedores

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

  get "/importar_produto", to: "importar_produtos#importar"
  get "/importar_produto/importar", to: "importar_produtos#importar_arquivo"

  root to: "home#index"
end
