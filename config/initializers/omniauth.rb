Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '993700720647405', 'ac60f29a8599c3e4c704269b3433f0e4', scope: 'email'
end