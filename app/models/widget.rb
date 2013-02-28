class Widget
  include Mongoid::Document
  include Mongoid::Timestamps

  attr_accessible :type, :body, :file, :x, :y, :user_id

  field :type, type: String
  field :body, type: String
  field :x, type: Fixnum, default: -> { 0 }
  field :y, type: Fixnum, default: -> { 0 }

  belongs_to :user
end
