class Widget
  include Mongoid::Document
  include Mongoid::Timestamps

  attr_accessible :type, :body, :file, :x, :y, :user_id, :image, :image_cache

  field :type, type: String
  field :body, type: String
  field :x, type: Fixnum, default: -> { 0 }
  field :y, type: Fixnum, default: -> { 0 }

  # I considered having a separate image model like Ichiban.
  # A separate model would be cleaner too, but in the name of progress,
  # I'm going to declare the upload here.

  mount_uploader :image, ImageUploader
  field :width, type: Fixnum
  field :height, type: Fixnum
  field :md5, type: String

  belongs_to :user

  before_validation :read_dimensions
  before_validation :generate_md5

  def read_dimensions
    if self.image.path
      dimensions = self.image.get_geometry
      if dimensions.nil?
        errors.add(:image_geometry, "could not be read." )
      else
        self.width = dimensions[:width]
        self.height = dimensions[:height]
      end
    end
  end

  def generate_md5
    if self.image.path
      self.md5 = Digest::MD5.file(self.image.path).hexdigest
      errors.add(:image_MD5, "could not be generated.") unless self.md5
    end
  end

  def as_json(options = {})
    # Carrierwave will append empty image information.
    image_attributes = [:image, :width, :height, :md5]

    widget_json = super(options.merge!(except: image_attributes))
    unless self[:image].nil?

      # Let's nest the image information.
      widget_json.merge!(self.image.as_json)

      image_attributes.delete(:image)
      image_attributes.each do |attr|
        widget_json[:image][attr] = self.send(attr)
      end
    end

    return widget_json
  end
end
