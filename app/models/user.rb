class User < ApplicationRecord
	class << self
		def from_omniauth(auth_data)
			where(auth_data.slice('provider', 'uid')).first || create_from_omniauth(auth_data)
		end

		def create_from_omniauth(auth_data)
			create! do |user|
				user.provider = auth_data['provider']
				user.uid = auth_data['uid']
				user.nickname = auth_data['info']['nickname']
				user.email = auth_data['info']['email']
				user.name = auth_data['info']['name']
				user.avatar = auth_data['info']['image']
				user.provider_token = auth_data['credentials']['token']
			end
		end
	end
end
