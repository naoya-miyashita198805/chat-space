class GroupsController < ApplicationController

  def index
    
  end

  def new
    @group = Group.new
    @group.users << current_user
    # 上記のインスタンス変数はgroup.group_users.users
    # をgroup.usersと略して書いている
    # f.collection_check_boxes :user_ids, User.all, :id, :name
    # に対応するためだと思われる
    # ChatSpaceの仕様として、グループを新規作成する時は
    # ログイン中のユーザーを必ず含めたいためあらかじめ
    # 追加しておくため。中間テーブルの使い所
    # <<は配列に要素を追加するためのものここではログイン中のユーザ情報がはいる。
    # current_userはログインしているユーザの情報を取得すると言うので
    # レコード情報全て含むと考えられる
    # ただそうなら@group.users = Group.newと記述すればいいのでは
    #そうするとcurrent_user情報が入らない
   end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to root_path, notice: 'グループを作成しました'
    else
      render :new
    end
  end

  def edit
    @group = Group.find(params[:id])
    # findを使う！
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to root_path, notice: 'グループを更新しました'
    else
      render :edit
    end
  end

  private
  def group_params
    params.require(:group).permit(:name, user_ids: [])
  end
  
end
