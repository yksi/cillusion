class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  if Rails.env.development?
    storage :file
  else
    storage :fog
  end

  def store_dir
    "#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  end

  process :resize_to_fit => [800, 800]

  version :thumb do
    process :resize_to_fill => [300, 300]
  end

  version :small do
    process :resize_to_fill => [48, 48]
  end
end
