class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  # application_controllerにbefore_actionを使用しているため、全てのアクションが実行される前に
  # この部分が実行されることになります。
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
  # deviseをインストールすることでdevise_parameter_sanitizerのpermitメソッドが
  # 使えるようになりますが、これがストロングパラメータに該当する機能です。
  # サインアップ時に入力された「name」キーの内容の保存を許可しています。
  # sign_up, keys: [:name] サインアップ時[name]のキーの内容を保存を許可している
end 