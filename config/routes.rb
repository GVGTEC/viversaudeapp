Rails.application.routes.draw do
  resources :icms
  resources :cfop
  resources :terceiros
  resources :contas_pag
  resources :vendedores
  resources :contas_rec
  resources :plano_contas
  resources :administradores
  resources :transportadoras
  resources :localizacao_estoques

  resources :estoques, only: %i[index show] do
    collection do
      post 'importar'

      scope module: 'estoques' do
        resources :reposicoes, only: %i[new create]
        resources :ajustes, :baixas, only: %i[new create]
      end
    end
  end

  resources :empresas do
    get 'configuracoes', on: :collection
  end
  
  resources :orcamentos do
    resources :orcamento_itens
  end

  resources :nota_fiscais do
    get 'observacoes', on: :member

    resources :gerar_nota_fiscais, only: [:gerar_nota] do
      get 'gerar_nota', on: :collection
    end

    resources :nota_fiscal_itens
    resources :nota_fiscal_duplicatas, only: %i[new create]
  end

  resources :produtos do
    post 'importar', on: :collection
    resources :movimento_estoques, only: [:index]
  end

  resources :clientes do
    post 'importar', on: :collection
  end

  resources :fornecedores do
    post 'importar', on: :collection
  end

  resources :importacoes do
    collection do
      get 'clientes'
      get 'produtos'
      get 'estoques'
      get 'fornecedores'
    end
  end

  root to: 'home#index'

  get '/login', to: 'login#index'
  post '/login', to: 'login#logar'
  get '/sair', to: 'login#deslogar'
end
