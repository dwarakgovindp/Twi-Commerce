class LoginController < ApplicationController
	
	def homepage

	end

	def login_twitter
		redirect_to "/auth/twitter"
	end

	def account
		auth = request.env["omniauth.auth"]
		user_id = auth[:uid]
		account = User.find_by(user_id:user_id)

		if account.nil?
			new_account(auth)
		else
			session[:id] = account.id
			redirect_to "/dashboard"
		end
	end


	def new_account(auth)	
		twitter_handle = auth[:info][:nickname]
		access_token = auth[:credentials][:token]
		access_secret = auth[:credentials][:secret]
		user_id = auth[:uid]
		img = auth[:info][:image]
		country = auth[:info][:location]

		new_account = User.new(
						twitter_handle:twitter_handle,
						access_token:access_token,
						access_secret:access_secret,
						user_id:user_id,
						img:img,
						country:country
					)
		if new_account.save
			session[:id] = new_account.id
			redirect_to "/dashboard"
		else
			redirect_to "/"
		end
	end
	
end
