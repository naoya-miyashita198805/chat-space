# binding.pryでは値は取れている
# がおそらくここでグループidが定義されていないため
# 全てのグループをとる？故に下記に追記でためす
json.array! @messages do |message|
  json.content message.content
  json.image message.image.url
  json.created_at message.created_at.strftime("%Y年%m月%d日 %H時%M分")
  json.user_name message.user.name
  json.id message.id
end
