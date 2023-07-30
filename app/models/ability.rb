class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user

    if user.admin?
      can :manage, :all
    elsif user.manager?
      can :manage, User
      can :manage, JoggingSession, user_id: user.id
    else
      can :manage, JoggingSession, user_id: user.id
      can :manage, User, id: user.id
    end
  end
end
