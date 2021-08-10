class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities

    if user.has_role? :admin
        can :manage, :all
    elsif user.has_role? :manager
        can :set, SelectedUser
        can :read, Patrol do |patrol|
            patrol.organisation == user.organisation
        end
        can [:read, :swaps, :patrol, :member, :patrol_report], Roster do |roster|
            roster.organisation == user.organisation
        end
        can [:index, :my_offers, :my_requests, :confirmed], Swap do |swap|
            swap.user.organisation == user.organisation
        end
        can [:create], Request
        can [:read], Request do |request|
            request.user.organisation == user.organisation
        end
        can [:update, :destroy, :confirm_cancel], Request, :user => user
        cannot [:update], Request do |request|
            request.offers.where(:status => 'accepted').present?
        end
        cannot :index, Request
        can [:create], Offer
        can [:read, :confirm_accept, :confirm_decline], Offer do |offer|
            offer.user.organisation == user.organisation
        end
        can [:update, :destroy, :confirm_cancel], Offer, :user => user
        can [:accept, :decline], Offer do |offer|
            offer.request.user == user
        end
        can :read, Proficiency do |prof|
            prof.organisation == user.organisation
        end
        can [:update, :destroy], Proficiency do |prof|
            prof.organisation == user.organisation
        end
        can :admin, Proficiency do |prof|
            prof.organisation == user.organisation
        end
        can [:create], ProficiencySignup
        can [:read, :destroy], ProficiencySignup do |prof_signup|
            prof_signup.user.organisation == user.organisation
        end
        can [:read, :index], OutreachPatrol
        can [:read, :create], OutreachPatrolSignUp
        can :destroy, OutreachPatrolSignUp
        can [:read, :ics], User do |u|
            u.organisation == user.organisation
        end
        can [:index, :privacy_policy, :terms_of_use, :thanks, :contact_us], :home
        cannot :index, User
        can [:index], :dashboard
        can [:index, :set], :selected_user
        can [:report,:patrol_report], Roster do |roster|
            roster.organisation == user.organisation
        end
    elsif user.has_role? :member
        can :read, Patrol do |patrol|
            patrol.organisation == user.organisation
        end
        can [:read, :swaps, :patrol, :member, :patrol_report], Roster do |roster|
            roster.organisation == user.organisation
        end
        can [:index, :my_offers, :my_requests, :confirmed], Swap do |swap|
            swap.user.organisation == user.organisation
        end
        can [:create], Request
        can [:read], Request do |request|
            request.user.organisation == user.organisation
        end
        can [:update, :destroy, :confirm_cancel], Request, :user => user
        cannot [:update], Request do |request|
            request.offers.where(:status => 'accepted').present?
        end
        cannot :index, Request
        can [:create], Offer
        can [:read, :confirm_accept, :confirm_decline], Offer do |offer|
            offer.user.organisation == user.organisation
        end
        can [:update, :destroy, :confirm_cancel], Offer, :user => user
        can [:accept, :decline], Offer do |offer|
            offer.request.user == user
        end
        can :read, Proficiency do |prof|
            prof.organisation == user.organisation
        end
        can [:create], ProficiencySignup
        can [:read], ProficiencySignup do |prof_signup|
            prof_signup.user.organisation == user.organisation
        end
        can :destroy, ProficiencySignup, :user => user
        can [:read, :index], OutreachPatrol
        can [:read, :create], OutreachPatrolSignUp
        can :destroy, OutreachPatrolSignUp, :user => user
        can [:read, :ics], User do |u|
            u.organisation == user.organisation
        end
        can [:index, :privacy_policy, :terms_of_use, :thanks, :contact_us], :home
        cannot :index, User
        can [:index], :dashboard
        can [:index, :set], :selected_user
    else
        can :patrol_report, Roster
        can :create, Lead
        can [:read, :ics], User
        cannot [:index, :show], User
        can :activate, User
        can [:index, :privacy_policy, :terms_of_use, :thanks, :contact_us], :home
    end

  end
end
