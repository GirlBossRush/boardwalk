class Neighbor
  include Mongoid::Document
  belongs_to :connection, class_name: 'User', inverse_of: nil
  has_and_belongs_to_many :users, inverse_of: :neighbors

  field :direction
end