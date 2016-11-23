class Ability
  include CanCan::Ability

  def initialize(user)
     user ||= User.new # guest user (not logged in)
     #if user.role?(:admin)
       can :manage, :all
     #else
      # can :read, [Scenario, Direction], message: "Sorry!"
      # can :manage, Entry, :user_id => user.id
     #end
  end
end
