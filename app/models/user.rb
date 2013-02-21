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
            length: { maximum: 64 },
            presence: true,
            format: /^[a-zA-Z0-9\-_]+$/, # Alphanumeric, underscores and dashes
            uniqueness: { case_sensitive: false })

  validates(:password,
            presence: { on: :create })

  validates(:email,
            uniqueness: { case_sensitive: false },
            format: /.+@.+\..+/i) # Just an '@' and a '.'

  belongs_to :north_neighbor, class_name: 'User', inverse_of: nil
  belongs_to :east_neighbor,  class_name: 'User', inverse_of: nil
  belongs_to :south_neighbor, class_name: 'User', inverse_of: nil
  belongs_to :west_neighbor,  class_name: 'User', inverse_of: nil

  # REFACTOR: This works but is bit convoluted.
  # I've considered metaprogramming but the end result is just about the same size
  # and longer to debug.

  def north_neighbor=(user)
    self.north_neighbor.unset(:south_neighbor) if self.north_neighbor

    self.north_neighbor_id = user.id
    user.south_neighbor_id = self.id
    user.save && self.save
  end

  def south_neighbor=(user)
    self.south_neighbor.unset(:north_neighbor) if self.south_neighbor

    self.south_neighbor_id = user.id
    user.north_neighbor_id = self.id
    user.save && self.save
  end

  def east_neighbor=(user)
    self.east_neighbor.unset(:west_neighbor) if self.east_neighbor

    self.east_neighbor_id = user.id
    user.west_neighbor_id = self.id
    user.save && self.save
  end

  def west_neighbor=(user)
    self.west_neighbor.unset(:east_neighbor) if self.west_neighbor

    self.west_neighbor_id = user.id
    user.east_neighbor_id = self.id
    user.save && self.save
  end

  def as_json(options = {})
    super(options.merge(except: [:password_digest]))
  end
end
