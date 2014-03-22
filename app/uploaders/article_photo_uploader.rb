# encoding: utf-8

class ArticlePhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  
  storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    ActionController::Base.helpers.asset_path("fallback/" + [version_name, "Default.png"].compact.join('_'))
  end

  process :resize_to_fit => [300, 300]

  version :thumb do
    process :resize_to_fill => [48, 48]
  end

  version :small do
    process :resize_to_fill => [32, 32]
  end

end
