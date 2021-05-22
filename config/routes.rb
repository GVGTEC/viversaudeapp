Rails.application.routes.draw do
  resources :produtos
  resources :localizacao_estoques
  resources :cliente_contatos
  resources :clientes
  resources :fornecedor_contatos
  resources :fornecedores
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "home#index"
end
