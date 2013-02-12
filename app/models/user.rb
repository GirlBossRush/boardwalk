class User
  include Mongoid::Document
  include ActiveModel::SecurePassword
  has_secure_password
  attr_accessible :username, :email, :password, :password_confirmation

  field :username
  field :email, type: String
  field :password_digest, type: String

  validates(:username,
            length: { maximum: 64 },
            presence: true,
            format: /^[a-zA-Z0-9\-_]+$/, # Alphanumeric, underscores and dashes
            uniqueness: { case_sensitive: false })

  validates(:password,
            presence: { on: :create })

  validates(:email,
            uniqueness: { case_sensitive: false },
            format: /.+@.+\..+/i) # Just an '@' and a '.'

  def as_json(options = {})
    super(options.merge(except: [:password_digest]))
  end
end
