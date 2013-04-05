class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper
  include Cloudinary::CarrierWave

  version :thumbnail do
    process resize_to_limit: [200, 200]
    process convert: 'jpg'

    cloudinary_transformation quality: 90
    cloudinary_transformation :angle => :exif
  end

  def get_geometry
    if @file
      image = MiniMagick::Image.open(@file.file)
      if image
        return { width: image[:width], height: image[:height] }
      else
        return nil
      end
    end
  end

  # Add a white list of extensions which are allowed to be uploaded.
  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
