Rails.application.routes.draw do
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
  
  get "/estoques/ajuste", to: "estoques#ajuste"
  root to: "home#index"
end
