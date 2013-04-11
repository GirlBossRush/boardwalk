class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user || User.new

    can :create, User
    can :read, User
    can :update, User, id: @user.id
    can :check, User

    can :create, Widget, user_id: @user.id
    can :update, Widget, user_id: @user.id
    can :destroy, Widget, user_id: @user.id
    can :read, Widget
  end
end
