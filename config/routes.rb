Rails.application.routes.draw do
  devise_for :users
  # 最上位にdevise_for :users、したのresourceには記入しなくて良いと思われる
  # resource :messages, only: [:index]こちらはフロント実装において
  # あくまでブラウザで表示するために用いた。deviseをinstallし初期画面を
  # ログイン画面にするためこちらのコードは不要になるが後学のためにラインアウトにしておく
  
  root "groups#index"
  resources :users, only: [:edit, :update]
  # なぜresourcesと言う複数形になるのか、それはidと結びついたりするときに
  # 複数形となる、今回はdeviseのcurrent_userとか使うときにはしっかり複数形にしよう
  
  resources :groups, only: [:index, :new, :create, :edit, :update] do
    resources :messages, only: [:index, :create]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
end
