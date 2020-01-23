json.array! @users do |user|
  # json.group_id  user.group.id
  # json.group_name  user.group.name
  # json.content  user.message.content
  # json.user_sign_in current_user
  # 間違ってた、インクリメンタルサーチにおいて何が必要なのかをDBの中から撮ってくる
  # のを判断するのが難しい
  json.id user.id
  json.name user.name
end