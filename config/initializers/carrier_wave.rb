CarrierWave.configure do |config|
  if Rails.env.staging? || Rails.env.production? || Rails.env.development?
    config.storage = :fog
    config.fog_credentials = {
        :provider               => 'AWS',
        :aws_access_key_id      => ENV['AWS_ACCESS_KEY_ID'],
        :aws_secret_access_key  => ENV['AWS_SECRET_ACCESS_KEY'],
        :region => 'ap-southeast-1'
        }
    config.fog_directory  = 'jh-myflix'
    config.fog_public = false # optional, defaults to true
    config.fog_attributes = {'Cache-Control'=>'max-age=315576000'} # optional, defaults to {}
  else
    config.storage = :file
    config.enable_processing = Rails.env.development?
    config.storage :fog
  end
end