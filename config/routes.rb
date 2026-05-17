Rails.application.routes.draw do
  root "acaos#index"
  resources :acaos do
    member do
      post :buscar_preco
    end
  end
  get 'historico', to: 'historico#index', as: 'historico'
  delete 'historico/:id', to: 'historico#destroy', as: 'destroy_historico'
  get 'configuracoes', to: 'configuracoes#index'
  patch 'configuracoes', to: 'configuracoes#update'
end
