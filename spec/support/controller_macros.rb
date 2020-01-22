module ControllerMacros
  def login(user)
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
    # デバイスのログインを擬似的に呼び覚ます
  end
end