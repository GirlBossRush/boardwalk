class Widget
  include Mongoid::Document

  attr_accessible :type, :body, :file, :x, :y

  field :type
  field :body
  field :x
  field :y

  belongs_to :user
end
