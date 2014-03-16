CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider              => 'AWS',
    :aws_access_key_id     => 'AKIAI5LTV7VBJBBUIYVA',
    :aws_secret_access_key => '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'
  }
  config.fog_directory    = 'cillusion'
end