Rails.application.routes.draw do
  resources :online_files do
    collection do
      get 'process_files' => 'online_files#process_files'
      get 'download_files' => 'online_files#download_files'
    end
  end

  resources :transactions, only: [:index] do
    collection do
      get 'stats' => 'transactions#stats'
    end
  end
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
