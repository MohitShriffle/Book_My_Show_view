class Ability
  include CanCan::Ability

  def initialize(user)
    if user.type == 'Owner'
      can :manage, :all
    else
      can :read,Show
      can :create, Ticket
      can :read, Ticket, user: user
      can :read ,Movie
      can :search_movie ,Movie
      can :search_movie_by_name ,Movie
      can :search_tickets,Ticket
      can :search_tickets_by_id,Ticket
      can :destroy,Ticket
    end
  end
end
