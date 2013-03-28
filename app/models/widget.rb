class Widget
  include Mongoid::Document
  include Mongoid::Timestamps

  attr_accessible :type, :body, :file, :x, :y, :user_id, :image, :image_cache

  field :type, type: String
  field :body, type: String
  field :x, type: Fixnum, default: -> { 0 }
  field :y, type: Fixnum, default: -> { 0 }

  mount_uploader :image, ImageUploader
  belongs_to :user
end
