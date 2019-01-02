# README


This is a simple rails app where a user can create a story with a picture and a sentence and then other users can add to the story one sentence at a time.


in order to get the app to work you need to add a file /config/initializers/omniauth.rb

and in that file add

OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET']
end
