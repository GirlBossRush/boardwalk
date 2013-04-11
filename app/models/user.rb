class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  include ActiveModel::SecurePassword

  has_secure_password
  attr_accessible(:username,
                  :email,
                  :password,
                  :password_confirmation,
                  :neighbor_ids,
                  :neighbors_attributes,
                  :neighbors)

  field :username, type: String
  slug { |current_model| current_model.username.downcase }
  field :email, type: String
  field :password_digest, type: String
  field :role, type: String, default: -> { 'unprivileged' }

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

  has_and_belongs_to_many :users, inverse_of: :neighbors
  has_and_belongs_to_many :neighbors, class_name: 'User', inverse_of: :users

  accepts_nested_attributes_for :neighbors

  has_many :widgets, inverse_of: nil

  def neighbors=(neighbor_names)
    # REFACTOR: We're limited to 4 neighbors so it's not a huge priority to
    #           insert and delete neighbors in a smarter way. Ideally,
    #           we should collect all the users not in the neighbor_names,
    #           then remove them one by one.

    self.neighbors.clear
    users = []
    neighbor_names.reject!(&:blank?)

    neighbor_names[0...4].each do |name|
      users << User.where(_slugs: /^#{name}$/i).first
    end
    self.neighbors << users
  end

  # The JSON representation of the neighbor data does not reflect the database
  # so we need to make a few adjustments.
  def as_json(options = {})
    user = super(options.merge(except: [:password_digest, :neighbor_ids, :user_ids, :_slugs]))
    user[:neighbors] = []

    self.neighbors.each do |neighbor|
      user[:neighbors] << { username: neighbor.username,
                            user_id: neighbor.id }
    end

    return user
  end
end
