# Image
class Image < ActiveRecord::Base
  mount_uploader :image, ImageUploader

  def self.create_from_path path
    fog = Fog::Storage.new({
      provider: 'AWS',
      aws_access_key_id: ENV['AWS_KEY'],
      aws_secret_access_key: ENV['AWS_SECRET']
    })
    file = fog.directories.get(ENV['AWS_BUCKET']).files.get(path)

    local_file = Tempfile.new('tmp', Rails.root.join('tmp'), encoding: 'ascii-8bit')
    puts local_file.path
    local_file.write(file.body)
    local_file.close
    image = Image.create! image: local_file, md5: Digest::MD5.file(local_file).hexdigest
    local_file.unlink
    image
  end

  def self.upload path
    return unless File.exists?(path)
    file = File.open(path)
    md5 = Digest::MD5.file(path).hexdigest
    response = HTTParty.get(Rails.application.routes.url_helpers.image_url(id: md5))
    if response.code.to_i == 404
      puts 'UPLOAD !'
      puts path
      # Delayed::Job.enqueue UploadJob.new(path)
      uploader = FileUploader.new
      uploader.store!(file)
      puts 'UPLOADED !'
      puts uploader.path
      HTTParty.post(Rails.application.routes.url_helpers.images_url, {
        body: {
          path: uploader.path,
          filename: path
        }
      })
    end
  end
end
