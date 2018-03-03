class Users::FacebookController < ::ApplicationController
  respond_to :json

  def create
    uri = URI("https://graph.facebook.com/#{params[:uid]}?fields=first_name,last_name,email&access_token=#{params[:access_token]}")
    info = JSON.parse(Net::HTTP.get(uri))

    auth = OpenStruct.new(
      info: OpenStruct.new(info),
      provider: :facebook,
      uid: params[:uid]
    )

    @user = User.from_facebook_oauth(auth)
    sign_in @user, event: :authentication
    respond_with @user, location: after_sign_in_path_for(@user)
  end
end
