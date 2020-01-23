# # json.array! @message do |message|
# createアクションからのインスタンス変数は単数形だからarrayで
# 囲む必要なし！
# @message.image_urlにするにはちゃんとりゆがある
# imageだけだと/uploads/message/image/18/67598A1F-331C-417E-82B9-8ACC1769B2B1.jpeg"
# で送られてブラウザで反映されないから image_urlにすると67598A1F-331C-417E-82B9-8ACC1769B2B1.jpeg
# だけ取り出せてしっかりブラウザで表記される
# 検証コンソールでimageのハッシュないのキーでurlの存在は確認できるよ！
# json.id @message.id
# ここで.strftime("%Y年%m月%d日 %H時%M分")をやっとかないと非同期通信だから
# ブラウザで反映されなくなってしまうだから面倒だけど書こう！
# json.group_id @message.group_id
# json.user_id @message.user_id
# json.updated_at @message.updated_at
json.user_name @message.user.name
json.content @message.content
json.image @message.image_url
json.created_at @message.created_at.strftime("%Y年%m月%d日 %H時%M分")