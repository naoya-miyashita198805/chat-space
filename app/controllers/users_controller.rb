class UsersController < ApplicationController
  # ここには書いていないがuserモデルにクラスメソッドとして
  # def searchのコードが書いてある
  def index
    @users = User.search(params[:keyword], current_user.id)
    respond_to do |format|
      format.html{redirect_to root_path}
      format.json
      # これによって、サーバーはJSON形式で値を返し
      # jbuilderファイルが読み込まれるようになる
    end
  end

  def edit
  end

  def update
    if current_user.update(user_params)
      # current_user	サインインしているユーザーを取得する
      # このヘルパーメソッドを使えば当然今サインインしている
      # DBの情報を取得し、それをcreateできる
      # 新規ならUser.newで良いがその機能はdeviseで最初から
      # 用意されているので我々はeditから作り出す
      redirect_to root_path
    else
      render :edit
      # これは上記の editまで戻るよと言うこと
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
