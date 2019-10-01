class SessionsController < ApplicationController
	def create
		puts "💭 " * 50
		pp(auth_hash)
		raise auth_hash.to_yaml
	end

	protected

	def auth_hash
		request.env['omniauth.auth']
	end
end
