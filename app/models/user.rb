class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  include ActiveModel::SecurePassword

  has_secure_password
  attr_accessible :username, :email, :password, :password_confirmation, :neighbors_attributes

  field :username, type: String
  slug { |current_model| current_model.username.downcase }
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

  has_many :neighbors, class_name: 'User', inverse_of: :users
  belongs_to :users, inverse_of: :neighbors
  # accepts_nested_attributes_for :neighbors

  has_many :widgets, inverse_of: nil


  # The JSON representation of the neighbor data does not reflect the database
  # so we need to make a few adjustments.
  def as_json(options = {})
    user = super(options.merge(except: [:password_digest, :neighbor_ids]))
    user[:neighbors] = []

    self.neighbors.each do |neighbor|
      user[:neighbors] << { username: neighbor.username,
                            user_id: neighbor.id }
    end

    return user
  end
end
