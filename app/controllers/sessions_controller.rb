class SessionsController < ApplicationController
	def create
		puts '💭 ' * 50
		pp(auth_hash)

		user = User.from_omniauth(auth_hash)
		#session[:user_id] = user.id
		#self.current_user = @user
		#redirect_to root_url, notice: 'Signed in!'
		redirect_to '/', notice: 'Signed in!'
	end

	protected

	def auth_hash
		request.env['omniauth.auth']
	end
end
