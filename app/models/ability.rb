class Ability
  include CanCan::Ability

  def initialize(user)
    # can :create, Ticket
    # can :read, Ticket, user: user
    # can :read, Ticket, user: user
    # can :manage, :all if user.owner?
    # cannot :create, Theater if user.customer?
    if user.type == 'Owner'
      # Owners can manage all resources
      can :manage, :all
    else
      can :read,Show
      can :create, Ticket
      can :read, Ticket, user: user
      cannot :create, Theater if user.customer?
      can :read ,Movie
      can :search_movie ,Movie
      can :search_movie_by_name ,Movie
    end
  end
end
