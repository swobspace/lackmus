class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :search, :to => :read

    @user = user
    if @user.nil?
      return
    elsif @user.is_admin?
      can :manage, :all
      cannot [:update, :destroy], :roles, :ro => :true
    else
      can :navigate, [:events, :event_rules, :signatures]
      can :manage, [Event]
      can :read, [Signature, EventRule]
    end

  end
end
