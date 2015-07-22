CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: Rails.application.secrets.aws_key,
    aws_secret_access_key: Rails.application.secrets.aws_secret
  }
  config.fog_directory = Rails.application.secrets.aws_bucket_name
  config.fog_public = true
end
