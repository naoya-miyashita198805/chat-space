Rails.application.routes.draw do
  resource :messages, only: [:index]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "messages#index"
end
