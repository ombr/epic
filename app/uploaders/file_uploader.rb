# FileUploader
class FileUploader < CarrierWave::Uploader::Base
  storage :fog

  def random_key
    return @random_key if @random_key
    @random_key = SecureRandom.hex
    @random_key
  end

  def filename
    return "#{random_key}/#{super}" if original_filename.present?
    super
  end

  def fog_public
    false
  end

  def fog_authenticated_url_expiration
    2.hour
  end

  def max_file_size
    30.megabytes
  end
end
