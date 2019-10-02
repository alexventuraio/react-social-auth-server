# Rails 5.2.3 API - OmniAuth::GitHub

This example API app was created with the following command that just
creates an _api only_ structure:

```ruby
rails new react-social-auth-server --api -d postgresql -T
```

Then, I wanted to integrate OAuth login using Github provider. We can do
some manual workflow by performing request directly to the Github API
endpoints but I wanted to skip that work it there is a gem that
already implements that (no need to reinvent the wheel) so I went with this
awesome gem [omniauth-github](https://github.com/omniauth/omniauth-github).

Since this is an API app, we have no way to use sessions. But, **the
problem** is that omniauth uses sessions to pass down the auth data
gotten from the provider on the callback request so we can have it
available on the `request.env['omniauth.auth']` variable.

With that in mind, we need to add the following middlewares to the rack
stack as described in the
[documentation](https://github.com/omniauth/omniauth#integrating-omniauth-into-your-rails-api)
to make it work:

```ruby
config.session_store :cookie_store, key: '_interslice_session'
config.middleware.use ActionDispatch::Cookies # Required for all session management
config.middleware.use ActionDispatch::Session::CookieStore, config.session_options
```

That's the only way I found to make it work!!!

## Usage

- In the root folder, run `bundle install` to install all the
  dependencies.
- Run the migrations with `rake db:create && rake db:migrate`.
- Start the server by running `rails s`.

The default endpoint to login is set to `/auth/github` by the
`omniauth-github` gem. But to make it simpler, I created a new one which
is `/login` and redirect it to the omniauth's default one, just for
simplicity.

```
get '/login', to: redirect('/auth/github')
```

- So, go to oint to `/login` and you will be prompted to authorize github
  app to access your account and the OAuth2 workflow will start.

- Then in the callback URL your github data will be received and there is
  the precise moment to save the user to the database (if needed).

- After persisting the user, it should be goog to create a JWT to respond
  to the client app which could be a React app.

- Finally we should redirect the user to the URL where the client app is
  hosted so that the user can interact with it as a registered user.

But that's only the desired worflow. This example only handles the
Github and OmniAuth process on a Rails API only app.
