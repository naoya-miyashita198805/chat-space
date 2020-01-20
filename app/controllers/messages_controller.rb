class MessagesController < ApplicationController
  before_action :set_group
  # messages controllerはgroupsのネスト中
  def index
    @message = Message.new
    @messages = @group.messages.includes(:user)
    # ネストので引っ張ってくるための表記か
    # @group = Group.find(name)
    # @users = User.where()
    # main_chatのヘッダーでは単数のグループに対して
    # mener:以降は所属しているuserが複数いるからusers
    # でそれぞれインスタンス変数を指定しています
    # 狙いとしてはこれからmain_chatのメンバー表記でeach文を使うから
    # 理屈ではこの書き方出会っているはず
  end

  # def new
  #   @message = Message.new
  #   @group.users << current_user
  # end

  def create
    @message = @group.messages.new(message_params)
    if @message.save
      redirect_to group_messages_path(@group), notice: 'メッセージが送信されました'
    else
      @messages = @group.messages.includes(:user)
      flash.now[:alert] = 'メッセージを入力してください。'
      render :index
      # これはフラッシュメッセージ導入後に使えるflashメソッド
    end
    # @message = Message.create(content_params)
    # redirect_to group_message_path
  end

  # def show
  # end

  private

  def message_params
    params.require(:message).permit(:content, :image).merge(user_id: current_user.id)
    # params.require(:comment).permit(:text).merge(user_id: current_user.id, tweet_id: params[:tweet_id])
  end

  def set_group
    @group = Group.find(params[:group_id])
    # private以下にset_groupを定義し、before_actionを利用して呼び出すことで
    # messagesコントローラの全てのアクションで@groupを利用できるようになります。
    # 6行目の@groupはまさにそれ
  end

end
