# ImageUpload
class ImageUpload
  @queue = :upload

  def self.perform(path)
    Image.upload(path)
  end
end
