class User
  include Mongoid::Document
  include ActiveModel::SecurePassword
  has_secure_password
  attr_accessible :username, :email, :password, :password_confirmation

  field :username
  field :email, type: String
  field :password_digest, type: String

  validates(:username,
            presence: true,
            format: /^[A-Za-z\-\d_]+$/, # Alphanumeric, underscores and dashes
            uniqueness: { case_sensitive: false })

  validates(:password,
            presence: { on: :create })

  validates(:email,
            uniqueness: { case_sensitive: false },
            format: /.+@.+\..+/i) # Just an '@' and a '.'
end
