# Image
class Image < ActiveRecord::Base
  has_and_belongs_to_many :events
  has_many :orders

  mount_uploader :original, FileUploader
  mount_uploader :image, ImageUploader

  before_save :create_events

  def url(version)
    return image.url version if image?
    Rails.cache.fetch([self, 'original-url'], expires_in: 1.hour) do
      original.url
    end
  end

  def next event
    event.images.where('taken_at > ?', taken_at).order('taken_at ASC').first
  end

  def events_name
    names = exifs.try(:[], 'dc').try(:[], 'subject')
    return [] if names.nil?
    names
  end

  def create_events
    events_name.each do |name|
      event = Event.find_or_create_by(name: name)
      events << event unless events.include? event
    end
  end

  def process
    self.image = open(original.url)
    save!
    # Pusher.trigger_async('event', 'new-image', {}) if Pusher.key.present?
  end

  def self.create_from_path path
    fog = Fog::Storage.new(provider: 'AWS',
                           aws_access_key_id: ENV['AWS_KEY'],
                           aws_secret_access_key: ENV['AWS_SECRET']
    )
    file = fog.directories.get(ENV['AWS_BUCKET']).files.get(path)

    local_file = Tempfile.new('tmp', Rails.root.join('tmp'), encoding: 'ascii-8bit')
    local_file.write(file.body)
    local_file.close
    image = Image.create! image: local_file, md5: Digest::MD5.file(local_file).hexdigest
    local_file.unlink
    image
  end

  def self.upload(path)
    Rails.logger.info path
    return unless File.exist?(path)
    file = File.open(path)
    md5 = Digest::MD5.file(path).hexdigest
    response = HTTParty.get(Rails.application.routes.url_helpers.image_url(id: md5))
    if response.code.to_i == 404
      # Delayed::Job.enqueue UploadJob.new(path)
      image = Image.create! original: file
      original = image[:original]
      image.delete
      HTTParty.post(Rails.application.routes.url_helpers.images_url, {
        body: {
          image: {
            original: original,
            md5: md5
          }
        }
      })
    else
      Rails.logger.info "#{response.code}: #{path}"
    end
  end

  def to_param
    md5
  end
end
