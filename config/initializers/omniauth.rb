OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '760166127275-ldo7n9i9ha9pu5emr8v60dqrib1h8979.apps.googleusercontent.com', 'HmLITYvU524KFVkW61Ry90aW'
end
