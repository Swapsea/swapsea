# frozen_string_literal: true

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

    # Everyone
    can %i[index privacy_policy terms_of_use registration thanks contact_us setup faq], :home

    if user.has_role? :admin
      can :manage, :all
    # Manager
    elsif user.has_role? :manager
      can :read, Patrol do |patrol|
        patrol.club_id == user.club_id
      end
      can [:read, :swaps, :patrol, :member, :sign_on_report], Roster do |roster|
        roster.patrol.club_id == user.club_id
      end
      can [:index, :my_offers, :my_requests, :confirmed], Swap do |swap|
        swap.user.club_id == user.club_id
      end
      can [:create], Request
      can [:read], Request do |request|
        request.user.club_id == user.club_id
      end
      can(%i[update destroy confirm_cancel], Request, user:)
      cannot [:update], Request do |request|
        request.offers.where(status: 'accepted').present?
      end
      cannot :index, Request
      can [:create], Offer
      can [:read, :confirm_accept, :confirm_decline], Offer do |offer|
        offer.user.club_id == user.club_id
      end
      can(%i[update destroy confirm_withdraw], Offer, user:)
      can [:accept, :decline], Offer do |offer|
        offer.request.user == user
      end
      can :read, Proficiency do |prof|
        prof.club_id == user.club_id
      end
      can [:update, :destroy], Proficiency do |prof|
        prof.club_id == user.club_id
      end
      can :admin, Proficiency do |prof|
        prof.club_id == user.club_id
      end
      can [:create], ProficiencySignup
      can [:read, :destroy], ProficiencySignup do |prof_signup|
        prof_signup.user.club_id == user.club_id
      end
      can %i[read index], OutreachPatrol
      can %i[read create], OutreachPatrolSignUp
      can :destroy, OutreachPatrolSignUp
      can [:read, :ics], User do |u|
        u.club_id == user.club_id
      end
      cannot :index, User
      can [:index], :dashboard
      can %i[index set], :selected_user
      can [:sign_on_report], Roster do |roster|
        roster.patrol.club_id == user.club_id
      end
    # Club Member
    elsif user.has_role? :member
      can :read, Patrol do |patrol|
        patrol.club_id == user.club_id
      end
      can [:read, :swaps, :patrol, :member, :sign_on_report], Roster do |roster|
        roster.patrol.club_id == user.club_id
      end
      can [:index, :my_offers, :my_requests, :confirmed], Swap do |swap|
        swap.user.club_id == user.club_id
      end
      can [:create], Request
      can [:read], Request do |request|
        request.user.club_id == user.club_id
      end
      can(%i[update destroy confirm_cancel], Request, user:)
      cannot [:update], Request do |request|
        request.offers.where(status: 'accepted').present?
      end
      cannot :index, Request
      can [:create], Offer
      can [:read, :confirm_accept, :confirm_decline], Offer do |offer|
        offer.user.club_id == user.club_id
      end
      can(%i[update destroy confirm_withdraw], Offer, user:)
      can [:accept, :decline], Offer do |offer|
        offer.request.user == user
      end
      can :read, Proficiency do |prof|
        prof.club_id == user.club_id
      end
      can [:create], ProficiencySignup
      can [:read], ProficiencySignup do |prof_signup|
        prof_signup.user.club_id == user.club_id
      end
      can(:destroy, ProficiencySignup, user:)
      can %i[read index], OutreachPatrol
      can %i[read create], OutreachPatrolSignUp
      can(:destroy, OutreachPatrolSignUp, user:)
      can [:read, :ics], User do |u|
        u.club_id == user.club_id
      end
      cannot :index, User
      can [:index], :dashboard
      can %i[index set], :selected_user
    else
      can :create, Lead
      can :sign_on_report, Roster
      can %i[activate read ics], User
      cannot %i[index show], User
    end
  end
end
