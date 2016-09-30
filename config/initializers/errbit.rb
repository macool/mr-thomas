Airbrake.configure do |config|
  config.host = 'http://pangi.shiriculapo.com'
  config.project_id = -1
  config.project_key = 'deb26b5dca81c0f5fecc738ffce8595b'

  config.environment = Rails.env
  config.ignore_environments = %w(development test)
end
