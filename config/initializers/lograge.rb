AccessCalServer::Application.configure do
  if Rails.env.test? || Rails.env.development?
    config.lograge.enabled = false
  else
    config.lograge.enabled = true
  end
end
