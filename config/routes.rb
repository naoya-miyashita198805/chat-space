Rails.application.routes.draw do
  devise_for :users
  # 最上位にdevise_for :users、したのresourceには記入しなくて良いと思われる
  
  # resource :messages, only: [:index]こちらはフロント実装において
  # あくまでブラウザで表示するために用いた。deviseをinstallし初期画面を
  # ログイン画面にするためこちらのコードは不要になるが後学のためにラインアウトにしておく
  resource :users, only: [:edit, :update]
  root "messages#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
end
