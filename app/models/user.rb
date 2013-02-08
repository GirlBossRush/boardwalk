class User
  include Mongoid::Document
  has_secure_password
  attr_accessible :email, :password, :password_confirmation

  field :email, type: String
  field :password_digest, type: String

  validates_uniqueness_of :email
end
