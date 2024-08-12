Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :fbo_accounts, only: [:index, :show] do
    resources :fbo_account_statements, as: :statements, path: :statements, only: [:index, :new, :create] do
      post :import, on: :member
    end
    resources :fbo_account_transactions, as: :transactions, path: :transactions, only: [] do
      post :assign, on: :member
    end
  end

  resources :te_schemes, only: [:show] do
    resources :te_scheme_participants, as: :participants, path: :participants, only: [:index, :new, :create, :show]
    resources :te_scheme_contributions, as: :contributions, path: :contributions, only: [:index] do
      post :reaggregate, on: :member
    end
    resources :monthly_scheme_aggregates, as: :aggregates, path: :aggregates, only: [:index]

    post :reaggregate, on: :member
  end

  # Defines the root path route ("/")
  root "home#index"
end
