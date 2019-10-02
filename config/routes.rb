Rails.application.routes.draw do
	get '/login', to: redirect('/auth/github')
	get '/auth/:provider/callback', to: 'sessions#create'
	get 'auth/failure', to: redirect('/')

	resource :session, only: [:create]

	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
