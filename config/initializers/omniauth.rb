OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
    provider :facebook, '1640944012891208', '1d485edc4d776e8a6edb88f608f29511'
end