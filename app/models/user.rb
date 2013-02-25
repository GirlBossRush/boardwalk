class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActiveModel::SecurePassword

  has_secure_password
  attr_accessible :username, :email, :password, :password_confirmation

  field :username
  field :email, type: String
  field :password_digest, type: String

  validates(:username,
            presence: true,
            format: /^[a-zA-Z0-9\-_]+$/, # Alphanumeric, underscores and dashes
            length: { maximum: 64 },
            uniqueness: { case_sensitive: false })

  validates(:password,
            presence: { on: :create })

  validates(:email,
            format: /.+@.+\..+/i, # Just an '@' and a '.'
            uniqueness: { case_sensitive: false })

  has_and_belongs_to_many :neighbors, inverse_of: :users


  # The JSON representation of the neighbor data does not reflect the database
  # so we need to make a few adjustments.
  def as_json(options = {})
    user = super(options.merge(except: [:password_digest, :neighbor_ids]))
    user[:neighbors] = []

    self.neighbors.each do |neighbor|
      user[:neighbors] << { direction: neighbor.direction,
                            username: neighbor.connection.username,
                            user_id: neighbor.connection.id }
    end

    return user
  end
end
