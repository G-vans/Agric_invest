Rails.application.routes.draw do
  resources :transactions do
    member do
      get 'send_payout' 
      post 'process_payout' 
    end
  end
  resources :farmers
  get 'invest/index'
  get 'invest/success'
  get '/transactions/success', to: 'transactions#success', as: 'transactions_success'
  post '/send_sms', to: 'invest#send_sms'
  post '/stkpush', to: 'invest#stkpush'
  # post 'send_sms', to: 'sms#send_sms', as: :send_sms
  resources :investments do
    member do
      post 'invest'
    end
  end 
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
end
