Rails.application.routes.draw do
  get "/estoques/ajuste", to: "estoques#ajuste"
  get "/estoques/reposicao", to: "estoques#reposicao"
  get "/estoques/baixa", to: "estoques#baixa"
  #get "/estoques", to: "estoques#index"
  resources :estoques, only: :index
  resources :vendedores
  resources :transportadoras
  resources :contas_pag
  resources :plano_contas
  resources :empresas
  resources :produtos
  resources :localizacao_estoques
  resources :clientes
  resources :fornecedores
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "home#index"
end
