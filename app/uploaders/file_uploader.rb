# FileUploader
class FileUploader < CarrierWave::Uploader::Base
  def store_dir
    "tmp/#{SecureRandom.hex}"
  end
end
